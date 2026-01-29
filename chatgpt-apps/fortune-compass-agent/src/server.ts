import express, { Request, Response } from "express";
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StreamableHTTPServerTransport } from "@modelcontextprotocol/sdk/server/streamableHttp.js";
import { isInitializeRequest } from "@modelcontextprotocol/sdk/types.js";
import { z } from "zod";
import { randomUUID } from "node:crypto";

import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

import { drawFortune } from "./engine.js"; // your existing fortune logic

// Note: This Implemention Follows MCP 1.25 document add add express to host the /get /post method

// Constants
const MCP_SERVER_NAME = "fortune-compass";
const WIDGET_NAME = "fortune-compass-widget";
const DEBUG_ENABLE = false;

const app = express();
app.use(express.json());

// Create MCP server once
const server = new McpServer({
  name: MCP_SERVER_NAME,
  version: "1.0.0",
});


const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT_DIR = path.resolve(__dirname, "..");
const ASSETS_DIR = path.join(ROOT_DIR, "assets");

function readWidgetHtml(name: string): string {
  const file = path.join(ASSETS_DIR, `${name}.html`);
  if (!fs.existsSync(file)) {
    throw new Error(`Missing widget HTML: ${file}`);
  }
  return fs.readFileSync(file, "utf8");
}

/* ------------------------------------------------------------------ */
/* Widget definition */
/* ------------------------------------------------------------------ */

const WIDGET_URI = "ui://widget/fortune-compass.html";
const widgetHtml = readWidgetHtml("fortune-compass");

const widgetMeta = {
  "openai/outputTemplate": WIDGET_URI,
  "openai/widgetAccessible": true,
} as const;

// Resource
server.resource(
  WIDGET_NAME,          // internal ID
  WIDGET_URI,                        // resource URI (string)
  {
    description: "A specialized UI widget for fortune telling",
    mimeType: "text/html+skybridge",
    _meta: widgetMeta,
  },
  async (uri: URL) => {
    return {
      contents: [
        {
          uri: uri.toString(),
          mimeType: "text/html+skybridge",
          text: widgetHtml,
          _meta: widgetMeta,
        },
      ],
    };
  }
);


// Define your fortune tool
server.registerTool(
  "tell_fortune",
  {
    title: "Tell Fortune",
    description: "Tell your fortune via Tarot, ZhouYi, or Guangong",
    inputSchema: {
      prompt: z.string().describe("Prompt for fortune telling"),
      method: z
        .enum(["tarot", "zhouyi", "guangong", "all"])
        .default("all")
        .describe("Method of divination"),
    },
  },
  async ({ prompt, method }) => {
    const result = drawFortune(prompt, method);
    return {
      content: [
        {
          type: "text",
          text: Object.values(result)
            .map((f) => `${f.method} (${f.symbol}): ${f.title}`)
            .join("\n\n"),
        },
      ],
      structuredContent: result,
      _meta: {
        "openai/toolInvocation/invoking": "Consulting the Fortune Compass",
        "openai/toolInvocation/invoked": "The oracle has spoken",
      },
    };
  }
);



// Store transports by session ID
const sessions = new Map<string, StreamableHTTPServerTransport>();

app.post("/mcp", async (req: Request, res: Response) => {
  const sessionIdHeader = req.headers["mcp-session-id"] as string | undefined;
  let transport: StreamableHTTPServerTransport;

  // --- LOG HEADERS HERE ---
  if (DEBUG_ENABLE) {
      const reqId = randomUUID();
      console.log("[mcp]---- MCP POST METHOD Headers ------ ", req.method, req.url);
      console.log("\n[mcp:http] ===== Incoming Request =====");
      console.log("[mcp:http] reqId:", reqId);
      console.log("[mcp:http] method:", req.method);
      console.log("[mcp:http] url:", req.url);
      console.log("[mcp] Headers:");
      for (const [key, value] of Object.entries(req.headers)) {
            console.log(`  ${key}: ${value}`);
      }
  }

  if (sessionIdHeader && sessions.has(sessionIdHeader)) {
    // reuse
    transport = sessions.get(sessionIdHeader)!;
  } else if (!sessionIdHeader && isInitializeRequest(req.body)) {
    // new session
    transport = new StreamableHTTPServerTransport({
      sessionIdGenerator: () => randomUUID(),
      onsessioninitialized: (id) => {
        sessions.set(id, transport);
      }
    });

    // connect MCP
    await server.connect(transport);
  } else {
    // bad
    return res.status(400).json({ error: "Invalid session" });
  }

  // handle this MCP POST
  await transport.handleRequest(req, res, req.body);
});

app.get("/mcp", async (req: Request, res: Response) => {
  const sessionIdHeader = req.headers["mcp-session-id"] as string | undefined;
  // --- LOG HEADERS HERE ---
  if (DEBUG_ENABLE) {
      const reqId = randomUUID();
      console.log("[mcp]---- MCP POST METHOD Headers ------ ", req.method, req.url);
      console.log("\n[mcp:http] ===== Incoming Request =====");
      console.log("[mcp:http] reqId:", reqId);
      console.log("[mcp:http] method:", req.method);
      console.log("[mcp:http] url:", req.url);
      console.log("[mcp] Headers:");
      for (const [key, value] of Object.entries(req.headers)) {
            console.log(`  ${key}: ${value}`);
      }
  }

  if (!sessionIdHeader || !sessions.has(sessionIdHeader)) {
    return res.status(400).json({ error: "Missing session" });
  }
  const transport = sessions.get(sessionIdHeader)!;
  await transport.handleRequest(req, res);
});

const PORT = Number(process.env.PORT ?? 8000);

app.listen(PORT, () => {
  console.log(`MCP server listening on http://localhost:${PORT}/mcp`);
});

