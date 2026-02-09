# Agent MCP Deployment Platform - AI Agent A2Z Middleware
AI Agent and MCP Server Hosting and Deployment Service

## Agent and MCP Deployment Middleware and Hosting Infrastructure - DeepNLP x AI Agent A2Z

[Website](https://www.deepnlp.org/workspace/deploy) | [GitHub](https://github.com/aiagenta2z/agent_mcp_deployment) | [AI Agent Marketplace](https://www.deepnlp.org/store/ai-agent) | [AI Agent A2Z](https://www.aiagenta2z.com)

DeepNLP x AI Agent A2Z (aiagenta2z.com) provide public hosting service of AI Agent and MCP Deployment. Users can get a unique live subdomain endpoint for their agent/mcp project, which can be distributed and used in ChatGPT Apps Store, Cursor, etc to connect and use
, e.g. Live URL: `${owner_name}.aiagenta2z.com/${repo_name}/mcp`

[Visit Deployment Panel](https://www.deepnlp.org/workspace/deploy)

### **Features**

1. Various Deployment methods: template, github_repo, and source code
2. GitHub/Source Code: Support both Python/Typescript, which is just like how you start your Agent locally, you can deploy in our cloud container and save money of without the heavy cost of renting a cloud server or get a domain name by yourself.
3. Templates: We provides 20+ templates in various business models, such as `selling product` and `digital resources` e-commerce products agent/mcps as resources, vendors and content creators can expose their physical goods, digital resources (documents,files,online courses) etc to ChatGPT/Cursor.
4. SubDomain URL: Each user can have a unique subdomain URL for your agents, able to verification and hosting services.
5. Domain Verification: We support subdomain verification for various platforms, such as OpenAI, WeCom, WeChat, DingTalk, etc.
6. API Monitor and Credit Rewards: You can visit the [Deployed Agent API Dashboard](https://deepnlp.org/workspace/api_dashboard) to see the metric of your Deploy Agent & MCP and [Billing Credits](https://deepnlp.org/workspace/billing) earned.


#### Examples of demo projects deployed
| Deployment Type          | Deployed SubDomain URL                              | Intro                                                                                                                                       |
|--------------------------|-----------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------|
| Source Code              | https://jjjmc.aiagenta2z.com/perplexity_agent/mcp   | Perplexity API Deep Search Agent <br> [Github](https://github.com/jjjmc/perplexity_agent)                                                   |
| GitHub                   | https://derek.aiagenta2z.com/solar-system_server_python/mcp | ChatGPT App with MCP ans Assets <br>  [ChatGPT Apps SDK](https://github.com/openai/openai-apps-sdk-examples)                                |
| GitHub                   | https://agentscope.aiagenta2z.com/deep_research_agent/chat  | AgentScope, Qwen3 + Tavily Live Chat Endpoint and expose chat [Playground](https://agent.deepnlp.org/?agent=agentscope/deep_research_agent) |
| Template-Selling Product | -                                                   | -                                                                                                                                           |


### Support SDK and Packages
| Deployment Type   | Intro                                                                                           |
|-------------------|-------------------------------------------------------------------------------------------------|
| Support Agent SDK | [langchain](https://www.langchain.com/agents) [agentscope](https://doc.agentscope.io/tutorial/) |

## Quickstart

### Deploy From Source Code

#### User Case - Hosting a Perplexity Deep Research Agent MCP
<img src="https://raw.githubusercontent.com/aiagenta2z/agent_mcp_deployment/refs/heads/main/docs/agent_mcp_deployment_panel.png" style="height:400px;" alt="AI Agent Marketplace Category">

Lets' say you want to implement a Google Customized Search API based MCP server and
want to expose a tool  `perplexity_research_agent(messages: List[Dict[str, str]])` `perplexity_search_agent(question: str)` for users to use.

And you have already prepared below information:

Requirements
```angular2html
## Create a new project and Register AI Service
unique_id: jjjmc/perplexity_agent

## archived source code
perplexity_agent_code.zip

## Starting Command
uvicorn server:app

## pip requirement files in the archived source code perplexity_agent_code.zip
requirements.txt
```

Step 1. Goto `Workspace->Agent Deployment` and visit the [Deployment Workspace](https://www.deepnlp.org/workspace/deploy)

Select the project to deploy 'jjjmc/perplexity_agent'

Step 2. Switch Tab: Custom Python/JS

Drag and drop the source code archive file `perplexity_agent_code.zip` to upload

Step 3. Choose Config and Deploy

`Deploy Region`: `global` for avoid most ip restriction)  
`Entry Point`: Input `uvicorn server:app`, this is the command that you use to start MCP/Agent server locally, 
for example we have a server.py file and an app class, and we use `uvicorn` to start the mcp, please avoid specifying any `ports`
and we use assign dynamically.  
`Environment Variables`: We put `PERPLEXITY_API_KEY` and `DEEPNLP_ONEKEY_ROUTER_ACCESS` as key-value pairs in this field. Note that your access key is safe and we will
use pass the keys as variables in the requests to start your service in the container. It's equivalent to `.env` files in your uploaded sources.

Step 4. Deploy
Click deploy button and please wait a while for the deployment to complete and you will find your subdomain live url ready!

MCP SERVER URL: `https://jjjmc.aiagenta2z.com/perplexity_agent/mcp `


### Deploy From GitHub Repo

<img src="https://raw.githubusercontent.com/aiagenta2z/agent_mcp_deployment/refs/heads/main/docs/agent_deployment_github.jpg" style="height:400px;" alt="AI Agent Marketplace Category">

Deployment from Github Repo is as easy as you `git clone` project from web start the mcp/agent server locally. 
Imagine you are tenants on a shared hosting cloud service, and you just need to prepare a multi-line `entry_point.sh` shell script to let us know how you want to run the server.

| mode | url |
|----- | ------ |
| public |  example: https://github.com/openai/openai-apps-sdk-examples | build static into /assets and start server uvicorn |
| private |  Connect GitHub & Load Private Repos, Allow app 'ai agent a2z' to connect and clone your code | build static into /assets and start server uvicorn |

#### ChatGPT App Example

Step 1. Switch Tab to GitHub

Choose `Public URL` or `Private Repository` to allow us to connect to your private GitHub repos.

`GitHub Repository URL`: https://github.com/openai/openai-apps-sdk-examples   
`Deploy Region`: Global or region for your plans applicable

Step 2. Prepare Your Entry Command
`Entry Point (Startup Scripts)`:
This part is important and you might need to try various command.
Hints:
1. Enter one command per line. For multi-process Agent/MCP Deployment (like ChatGPT Apps Solar System), Include both the build and run commands. 
2. The last line should be the main MCP/Agent server running command starting with `uvicorn,python,pnpm,npm` etc. Don't include any --port flags, the ports will be assigned automatically.
3. Dependency Installation: Don't add `node or pnpm install`, cloud platform will handle it by reading your package.json, file.
4. Static File Build and Serve: ChatGPT App will build static resources (Html/Css/Js) from the 'src' folder, and we have cached the prebuild example also.
and you can also put the build command yourself.
5. Static File Serving: The example in the chatgpt app example started two web services: 'pnpm run serve' serve prebuild static file on port 4444, and `uvicorn solar-system_server_python.main:app`
is the main MCP server starting endpoint. Successfully deployed logs include `Using BASE_URL http://localhost:4444 for generated HTML` and `Uvicorn running on http://0.0.0.0:8000`. You have to make sure your command 'pnpm run serve &' add trailing '&' to run in the backend and prevent blocking the scripts. 
6. Any Unknown Failures: Please remember to contact us via raising issues on [GitHub](https://github.com/aiagenta2z/agent_mcp_deployment) and we will help you resolve the issues immediately.

```angular2html
pnpm run build
pnpm run serve &
uvicorn solar-system_server_python.main:app
```

or another app "kitchen-sink-mcp-node"

```angular2html
pnpm run build
pnpm run serve &
pnpm --filter kitchen-sink-mcp-node start
```

`Environment Variables`: If Applicable

Step 3. Deploy
Click deploy button and please wait a while for the deployment process to complete and you will find your subdomain live url ready!

And wait for server to finish and once it's done, you can copy and paste the server url in MCP client such as 'cursor',

MCP SERVER URL: `https://derekzz.aiagenta2z.com/solar-system_server_python/mcp

And you can see if it's deployed successfully!

Copy and Paste into your Client
```json
{
  "chatgpt-solar-system-mcp": {
    "url": "https://derekzz.aiagenta2z.com/solar-system_server_python/mcp"
  }
}
```

#### AgentScope Chat Example

Example GitHub: https://github.com/aiagenta2z/agent-mcp-deployment-templates

We will implement and deploy a agentscope based deep-research agent, converting the original [deep research example](https://github.com/agentscope-ai/agentscope/tree/main/examples/agent/deep_research_agent) to
an FastAPI Server and expose the "/chat" API endpoint so that users can call the deep research agent by parameters `messages` and 
get the deep research reports

| Item          | Description                                               |
|---------------|-----------------------------------------------------------|
| unique id | agentscope/deep_research_agent                       |
| Live Chat URL | https://agentscope.aiagenta2z.com/deep_research_agent/chat |
| Playground | https://agent.deepnlp.org/?agent=agentscope/deep_research_agent |


You can also use the Agent Router playground (WebUI) to start chatting with your live agents.
Visit the URL https://agent.deepnlp.org/?agent=${unique_id}. Note that the returned streaming chunks
should follow specific formats to work with the Agent Router Web UI. See [Doc](https://github.com/aiagenta2z/agent-mcp-deployment-templates/blob/main/agentscope/deep_research_agent/main_server.py) #assembly_message function for more details

Step 1: Choose Deploy From Tab GitHub Source
Step 2: Choose Public URL: https://github.com/aiagenta2z/agent-mcp-deployment-templates/tree/main/agentscope
Step 3: Entry Point

```
uvicorn main_server:app
```

The main server python will expose http://localhost:8000/chat endpoint in the container

Step 4: Add Environment Variable

The examples take two examples key as input for demo to run.
```bash
DASHSCOPE_API_KEY=xxxxx
TAVILY_API_KEY=xxxxx
```

Test the results locally before deploying live

```
curl -X POST "http://localhost:8000/chat" \
-H "Content-Type: application/json" \
-d '{"messages":[{"role":"user","content":"What is difference between MCPs and skills?"}]}'

```
Deep Research Results
``` 
{"type": "assistant", "format": "text", "content": "{\n  \"type\": \"text\",\n  \"text\": \"Create and write ./agentscope/examples/agent/deep_research_agent/deepresearch_agent_demo_env/Friday260209165138_detailed_report.md successfully.\"\n}", "section": "answer", "message_id": "5d878be8-82df-4c23-8fa6-564bf745775b", "content_type": "text/markdown", "template": "streaming_content_type", "task_ids": "", "tab_message_ids": "", "tab_id": ""}
```

Step 5: Click 'Deploy'
Then you can just wait for the server to finish and check the urls after it's ready.


### Deploy From Template (Beta)

#### Use Case 1 Selling products



### Domain Verification

The AI Agent A2Z Agent & MCP platform provides subdomain verification services to help you submit your deploy agents
to various Apps Store and verify that you own the domains, such as ChatGPT App Store, MCP Official Registry, WeCom (Tencent), WeChat, DingTalk, etc.

Go to Deployment -> Deployment Configuration -> Domain Verification tab

You can choose your sites that need to verify for your customized subdomain: https://{username}.aiagenta2z.com
Switch the tab, fill in the filename and content value, the just one click "Verify Domain".

| App                 | Verification URL                                                     |
|---------------------|----------------------------------------------------------------------|
| ChatGPT App Store   | https://{username}.aiagenta2z.com/.well-known/openai-apps-challenge  |
| MCP Official Registry | https://{username}.aiagenta2z.com/.well-known/mcp-register-challenge |
| WeCom (Tencent)     | https://{username}.aiagenta2z.com/WW_verify_xxxxxx.txt               |
| WeChat              | https://{username}.aiagenta2z.com/MP_verify_xxxxxx.txt               |
| DingTalk            | https://{username}.aiagenta2z.com/verify_xxxxxx.txt                  |

<img src="https://raw.githubusercontent.com/aiagenta2z/ai-agent-marketplace/refs/heads/main/docs/verified_domain_list.jpg" style="height:400px;" alt="AI Agent Marketplace Category">

#### ChatGPT App Submission and Domain Verification

On the ChatGPT App Manage Page (https://platform.openai.com/apps-manage), you can submit your AI Agent by filling the form.
You need to prepare a MCP Server URL (e.g. https://derekzz.aiagenta2z.com/fortune-compass-agent/mcp) and copy and paste the
verification code under the file path (https://derekzz.aiagenta2z.com/.well-known/openai-apps-challenge).

<img src="https://raw.githubusercontent.com/aiagenta2z/ai-agent-marketplace/refs/heads/main/docs/domain_verification_before.png" style="height:400px;" alt="AI Agent Marketplace Category">

You can go to the `Domain Verification` tab of AI Agent A2Z Deployment (https://deepnlp.org/workspace/deploy) platform.

Fill the form of `openai-apps-challenge` with the code on the platform. Then click `Verify Domain` to add a record.
Please wait a while for the record to work. If you want to change the content, just add a new record and the content will be overridden.

<img src="https://raw.githubusercontent.com/aiagenta2z/ai-agent-marketplace/refs/heads/main/docs/domain_verification_after.png" style="height:400px;" alt="AI Agent Marketplace Category">


### 5. Agent API Dashboard and Credits Account

After you have deployed your AI Agent (e.g. https://derekzz.aiagenta2z.com/fortune-compass-agent/mcp). The [Deployed Agent API Dashboard](https://deepnlp.org/workspace/api_dashboard) will monitor the incoming traffic to the endpoint.

You can also visit the detail page to set API credit per call and you can start earn credits from your hard work.
Visit the [Billing Credits](https://deepnlp.org/workspace/billing) for detail reports.

<img src="https://raw.githubusercontent.com/AI-Hub-Admin/fortune-compass-agent/refs/heads/main/docs/fortune_compass_traffic_monitor.png" style="height:400px;" alt="AI Agent Marketplace Category">




### Related

[AI Agent Marketplace Registry](https://github.com/aiagenta2z/ai-agent-marketplace)     

[Open AI Agent Marketplace](https://www.deepnlp.org/store/ai-agent)     

[MCP Marketplace](https://www.deepnlp.org/store/ai-agent/mcp-server)    

[OneKey Router AI Agent & MCP Ranking](https://www.deepnlp.org/agent/rankings)    

[OneKey Agent MCP Router](https://www.deepnlp.org/agent/onekey-mcp-router)     

[OneKey AGent MCP Router Doc](https://deepnlp.org/doc/onekey_mcp_router)     

[AI Agent Dataset](https://www.deepnlp.org/store/dataset)     

[Gemini Nano Banana Agent](https://agent.deepnlp.org/agent/mcp_tool_use?server=aiagenta2z%2Fgemini_mcp_onekey)     





