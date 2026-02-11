# -*- coding: utf-8 -*-
"""The main entry point of the Deep Research agent example."""
import asyncio
import os


from .deep_research_agent import DeepResearchAgent

from agentscope import logger
from agentscope.formatter import DashScopeChatFormatter
from agentscope.memory import InMemoryMemory
from agentscope.model import DashScopeChatModel
from agentscope.message import Msg
from agentscope.mcp import StdIOStatefulClient


async def main(user_query: str) -> None:
    """The main entry point for the Deep Research agent example."""
    logger.setLevel("DEBUG")

    tavily_search_client = StdIOStatefulClient(
        name="tavily_mcp",
        command="npx",
        args=["-y", "tavily-mcp@latest"],
        env={"TAVILY_API_KEY": os.getenv("TAVILY_API_KEY", "")},
    )

    default_working_dir = os.path.join(
        os.path.dirname(__file__),
        "deepresearch_agent_demo_env",
    )
    agent_working_dir = os.getenv(
        "AGENT_OPERATION_DIR",
        default_working_dir,
    )
    os.makedirs(agent_working_dir, exist_ok=True)

    try:
        await tavily_search_client.connect()
        agent = DeepResearchAgent(
            name="Friday",
            sys_prompt="You are a helpful assistant named Friday.",
            model=DashScopeChatModel(
                api_key=os.environ.get("DASHSCOPE_API_KEY"),
                model_name="qwen3-max",
                enable_thinking=False,
                stream=True,
            ),
            formatter=DashScopeChatFormatter(),
            memory=InMemoryMemory(),
            search_mcp_client=tavily_search_client,
            tmp_file_storage_dir=agent_working_dir,
            max_tool_results_words=10000,
        )
        user_name = "Bob"
        msg = Msg(
            user_name,
            content=user_query,
            role="user",
        )
        result = await agent(msg)
        logger.info(result)

    except Exception as err:
        logger.exception(err)
    finally:
        await tavily_search_client.close()



### ------ Converting Agent to Live Server with /chat endpoint  --------
import json
from typing import List, Dict, Any, Optional
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel, Field
from contextlib import asynccontextmanager
from fastapi.responses import StreamingResponse
import uuid

@asynccontextmanager
async def lifespan(app: FastAPI):
    print("Application startup...")
    await startup_event()
    yield
    print("Application shutdown...")

    await shutdown_event()

### convert local workflow loop to service
app = FastAPI(
    title="AgentScope deepresearch agent x AI Agent A2Z",
    description="AgentScope deepresearch agent FastAPI Service Online",
    version="0.1.0",
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

async def startup_event() -> None:
    """Initialization of agent 实例."""
    global tavily_search_client, agent

    """The main entry point for the Deep Research agent example."""
    logger.setLevel("DEBUG")

    tavily_search_client = StdIOStatefulClient(
        name="tavily_mcp",
        command="npx",
        args=["-y", "tavily-mcp@latest"],
        env={"TAVILY_API_KEY": os.getenv("TAVILY_API_KEY", "")},
    )

    default_working_dir = os.path.join(
        os.path.dirname(__file__),
        "deepresearch_agent_demo_env",
    )
    agent_working_dir = os.getenv(
        "AGENT_OPERATION_DIR",
        default_working_dir,
    )
    os.makedirs(agent_working_dir, exist_ok=True)

    try:
        await tavily_search_client.connect()
        agent = DeepResearchAgent(
            name="Friday",
            sys_prompt="You are a helpful assistant named Friday.",
            model=DashScopeChatModel(
                api_key=os.environ.get("DASHSCOPE_API_KEY"),
                model_name="qwen3-max",
                enable_thinking=False,
                stream=True,
            ),
            formatter=DashScopeChatFormatter(),
            memory=InMemoryMemory(),
            search_mcp_client=tavily_search_client,
            tmp_file_storage_dir=agent_working_dir,
            max_tool_results_words=1000,
            max_iters=1,
            max_depth=1
        )

    except Exception as err:
        logger.exception(err)
    finally:
        print (f"Lifecycle closed at the end...")

async def shutdown_event() -> None:
    """

    """
    global tavily_search_client, agent
    try:
        await tavily_search_client.close()
    except Exception as err:
        print (f"Shutting Down Event {err}")

class ChatRequest(BaseModel):
    """
        General Chat Request
    """
    messages: List[Dict[str, str]] = Field(..., description="Input Messages")
    model: Optional[str] = Field(default="qwen3-max", description="model used")

class ChatResponse(BaseModel):
    """Response as Dict of result"""
    response: Dict[str, Any] = Field(..., description="")

async def stream_generator(agent, msg):
    """
    Generator for Chat Messages Assemble AgentScope Response

    message_type: "user", "assistant"
    output_format: "text", "html"
    content_type: "text/markdown", mime-type

    SECTION_THINK = "think"
    SECTION_ANSWER = "answer"
    SECTION_TOOL = "tool"
    SECTION_SYSTEM_MSG = "system_msg"
    SECTION_CONTEXT = "context"

    TEMPLATE_REASONING_HTML = "reason_html"
    TEMPLATE_STREAMING_CONTENT_TYPE = "streaming_content_type"
    """
    message_type = "assistant"
    output_format = "text"
    content_type = "text/markdown"
    section = "answer"
    streaming_separator = "\n"
    TEMPLATE_STREAMING_CONTENT_TYPE = "streaming_content_type"

    ## Initial Chunk
    initial_chunk = json.dumps(assembly_message(message_type, output_format, "DeepResearch Task Starting...", content_type=content_type, section=section, message_id= str(uuid.uuid4()), template=TEMPLATE_STREAMING_CONTENT_TYPE) )
    yield initial_chunk + streaming_separator

    ## result is a message class Msg
    response_msg = await agent.reply(msg)
    print (f"Agent Reply: response {response_msg}")
    response_content = response_msg.content
    print (f"Agent Reply: response response_content {response_content}")

    output_message_id = response_msg.id
    content_type_chunk = json.dumps(assembly_message(message_type, output_format, response_content, content_type=content_type, section=section, message_id=output_message_id, template=TEMPLATE_STREAMING_CONTENT_TYPE) )

    print (f"stream_generator response Result: {response_msg}")
    yield content_type_chunk + streaming_separator

def assembly_message(type, format, content, **kwargs):
    """
        content_type: html,pdf,etc
        {
            "type": "assistant",
            "format": "html",  // html直接展示,markdown处理,text,image
            "content": "xxxxx",
            "content_type": "xxxxx",  //区分 html下: application/code(展示框), game, widget(Dom), image, video, 前端穿xxxx
            "section": "tool", // card section (html branch )
            “template”:
            "message_id": "xxxxx"
        }
        type: role
        format: text/img
        section: reason/tool/response

        content:
            str,
            dict
    """
    try:
        output_message = {"type": type, "format": format, "content": content}

        keys = ["section", "message_id", "content_type", "template", "task_ids", "tab_message_ids", "tab_id"]
        for key in keys:
            value = kwargs[key] if key in kwargs else ""
            output_message[key] = value

        return output_message

        ## add key: c
    except Exception as e:
        print(f"DEBUG: processing error with {e}")
        return {"type": type, "format": format, "content": content}

@app.post("/chat")
async def chat(request: ChatRequest) -> StreamingResponse:
    """ Convert the DeepResearch Agent to Live Service."""
    global tavily_search_client, agent
    if agent is None:
        raise HTTPException(status_code=503, detail="Agent not initialized")

    try:
        messages = request.messages
        user_query = ""
        try:
            user_query = messages[-1]["content"] if len(messages) > 0 else "hello"
        except Exception as e1:
            print (f"Failed to process input messages: {e1}")
        print (f"DEBUG: user: {user_query}")
        user_name = "USER_"
        ## set to 1 iteration for example
        msg = Msg(
            user_name,
            content=user_query,
            role="user"
        )

        return StreamingResponse(
            stream_generator(agent, msg),
            media_type="application/json",
        )

    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to chat: {str(e)}") from e

if __name__ == "__main__":
    query = (
        "If Eliud Kipchoge could maintain his record-making "
        "marathon pace indefinitely, how many thousand hours "
        "would it take him to run the distance between the "
        "Earth and the Moon its closest approach? Please use "
        "the minimum perigee value on the Wikipedia page for "
        "the Moon when carrying out your calculation. Round "
        "your result to the nearest 1000 hours and do not use "
        "any comma separators if necessary."
    )
    try:
        asyncio.run(main(query))
    except Exception as e:
        logger.exception(e)
