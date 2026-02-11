# -*- coding: utf-8 -*-
"""The main entry point of the Deep Research agent example."""

## Starting the server
npx -y tavily-mcp@latest
export DASHSCOPE_API_KEY="your_dashscope_api_key_here"
export TAVILY_API_KEY="your_tavily_api_key_here"
export AGENT_OPERATION_DIR="your_own_direction_here"

## cd to root folder
uvicorn agentscope_examples.deep_research_agent.main_server:app --host 0.0.0.0 --port 8000 --reload

### endpoint: http://localhost:8000/chat

curl -X POST "http://localhost:8000/chat" \
  -H "Content-Type: application/json" \
  -d '{"messages":[{"role":"user","content":"What is difference between MCPs and skills?"}]}'

## Expected Result
```
{"type": "assistant", "format": "text", "content": "{\n  \"type\": \"text\",\n  \"text\": \"Create and write ./agentscope/examples/agent/deep_research_agent/deepresearch_agent_demo_env/Friday260209165138_detailed_report.md successfully.\"\n}", "section": "answer", "message_id": "5d878be8-82df-4c23-8fa6-564bf745775b", "content_type": "text/markdown", "template": "streaming_content_type", "task_ids": "", "tab_message_ids": "", "tab_id": ""}
```

curl -X POST "http://localhost:8000/chat" \
  -H "Content-Type: application/json" \
  -d '{"messages":[{"role":"user","content":"Calculate 1+1 result"}]}'


Returned Streaming Chunks
```
{"type": "assistant", "format": "text", "content": "DeepResearch Task Starting...", "section": "answer", "message_id": "ccf617e2-8ac3-421f-a5e9-5193ccb677e6", "content_type": "text/markdown", "template": "streaming_content_type", "task_ids": "", "tab_message_ids": "", "tab_id": ""}
{"type": "assistant", "format": "text", "content": "{\n  \"type\": \"text\",\n  \"text\": \"Create and write /Users/rockingdingo/Desktop/workspace/github/aiagenta2z/agent-mcp-deployment-templates/agentscope_examples/deep_research_agent/deepresearch_agent_demo_env/Friday260211115213_detailed_report.md successfully.\\n# Introduction:\\nThis report addresses the fundamental arithmetic calculation of 1 + 1 within the standard base-10 numeral system. While seemingly trivial, this operation serves as a foundational element in mathematics, computer science, and logic. The purpose of this analysis is to rigorously confirm the result through established mathematical principles, eliminate any ambiguity regarding numeral systems or operational definitions, and validate the outcome using authoritative sources. Despite its simplicity, ensuring precision in even the most basic operations reinforces reliability in more complex computational and theoretical frameworks.\\n\\n# Confirmation of Arithmetic Context:\\n## Base-10 Numeral System and Standard Addition\\nThe expression \\\"1 + 1\\\" is interpreted within the context of the decimal (base-10) numeral system, which is the standard system for denoting integer and non-integer numbers in everyday human use and most scientific applications. In this system, the digit \\\"1\\\" represents the smallest positive integer greater than zero, and the \\\"+\\\" symbol denotes the binary operation of addition as defined in elementary arithmetic.\\n\\nAddition in the base-10 system follows the Peano axioms, which provide a formal foundation for the natural numbers. According to these axioms:\\n- 0 is a natural number.\\n- Every natural number has a successor.\\n- 1 is defined as the successor of 0.\\n- 2 is defined as the successor of 1.\\n\\nThe operation of addition is recursively defined such that:\\n- For any natural number *a*, *a* + 0 = *a*.\\n- For any natural numbers *a* and *b*, *a* + S(*b*) = S(*a* + *b*), where S(*n*) denotes the successor of *n*.\\n\\nApplying this to 1 + 1:\\n- Since 1 = S(0), then 1 + 1 = 1 + S(0) = S(1 + 0) = S(1) = 2.\\n\\nThus, under the Peano axiomatic system, 1 + 1 = 2 is not merely an empirical observation but a logical consequence of the definitions of natural numbers and addition.\\n\\n## Elimination of Alternative Interpretations\\nTo address potential knowledge gaps, we consider whether alternative interpretations could yield different results:\\n\\n1. **Different Numeral Systems**:  \\n   - In binary (base-2), \\\"1 + 1\\\" equals \\\"10\\\", which represents the decimal value 2. However, the result is still numerically equivalent to 2; only the representation differs.\\n   - In unary, \\\"1 + 1\\\" would be represented as \\\"11\\\", again corresponding to the quantity two.\\n   - No standard numeral system assigns a different *value* to the sum of one and one; differences are purely notational.\\n\\n2. **Non-Standard Arithmetic**:  \\n   - In modular arithmetic (e.g., modulo 2), 1 + 1 \u2261 0 (mod 2). However, this is a specialized algebraic structure with a defined modulus, not standard integer arithmetic.\\n   - Boolean logic uses \\\"1 + 1 = 1\\\" in OR operations or \\\"1 + 1 = 0\\\" in XOR under GF(2), but these are logical or field-specific operations, not standard addition.\\n\\n3. **Linguistic or Philosophical Ambiguity**:  \\n   - Phrases like \u201c1 + 1 = 3\u201d in contexts such as teamwork or synergy are metaphorical and do not reflect mathematical computation.\\n\\nGiven the task specifies a standard arithmetic calculation without additional context, we operate under conventional base-10 integer addition.\\n\\n# Execution and Validation of Calculation:\\n## Direct Computation\\nPerforming the addition:\\n1 + 1 = 2\\n\\nThis result is consistent across all standard mathematical references, educational curricula, and computational tools.\\n\\n## Cross-Verification Using Trusted Sources\\nMultiple authoritative sources confirm this result:\\n\\n- **Principia Mathematica** by Whitehead and Russell (1910): In a famously rigorous derivation, the authors prove that 1 + 1 = 2 on page 379 of Volume I (first edition), after establishing foundational logic and set theory. This historical milestone underscores the non-trivial logical basis of even simple arithmetic.\\n\\n- **Elementary Mathematics Textbooks**: Standard K\u201312 curricula universally teach that 1 + 1 = 2 as the first example of addition.\\n\\n- **Computational Verification**:  \\n  - Python: `print(1 + 1)` outputs `2`.  \\n  - Calculator (physical or digital): Entering \\\"1 + 1 =\\\" yields \\\"2\\\".  \\n  - Wolfram Alpha: Querying \\\"1+1\\\" returns \\\"2\\\".\\n\\n- **Formal Proof Systems**:  \\n  In the Coq proof assistant, defining natural numbers via Peano axioms and proving `1 + 1 = 2` is a standard exercise, confirming the result constructively.\\n\\n# Conclusion:\\nThe calculation of 1 + 1 in the standard base-10 numeral system unequivocally results in 2. This conclusion is supported by axiomatic foundations (Peano arithmetic), empirical verification through computational tools, historical mathematical rigor (as in *Principia Mathematica*), and universal educational consensus. Alternative interpretations either preserve the numerical equivalence (e.g., different bases) or operate under non-standard frameworks explicitly outside the scope of basic arithmetic. Therefore, the result is validated beyond reasonable doubt.\\n\\n**Final Answer: 2**\"\n}", "section": "answer", "message_id": "fZ4w9gWr9TEvwkvwaH7Xid", "content_type": "text/markdown", "template": "streaming_content_type", "task_ids": "", "tab_message_ids": "", "tab_id": ""}
```

Logs
```
Friday: I'll work through the checklist items systematically, starting with the basic arithmetic verification of 1+1 in the standard decimal system.

{
    "type": "tool_use",
    "id": "call_de80e7c49f8c4f3890deebae",
    "name": "write_text_file",
    "input": {
        "file_path": "./agent-mcp-deployment-templates/agentscope_examples/deep_research_agent/deepresearch_agent_demo_env/1plus1_basic_arithmetic.md",
        "content": "# Basic Arithmetic Verification of 1+1\n\nIn the standard decimal number system, 1+1 equals 2.\n\nThis is a fundamental arithmetic operation based on the Peano axioms and the definition of addition in natural numbers. The result is universally accepted in standard mathematics."
    },
    "raw_input": "{\"file_path\": \"./agent-mcp-deployment-templates/agentscope_examples/deep_research_agent/deepresearch_agent_demo_env/1plus1_basic_arithmetic.md\", \"content\": \"# Basic Arithmetic Verification of 1+1\\n\\nIn the standard decimal number system, 1+1 equals 2.\\n\\nThis is a fundamental arithmetic operation based on the Peano axioms and the definition of addition in natural numbers. The result is universally accepted in standard mathematics.\"}"
}
system: {
    "type": "tool_result",
    "id": "call_de80e7c49f8c4f3890deebae",
    "name": "write_text_file",
    "output": [
        {
            "type": "text",
            "text": "Create and write ./agent-mcp-deployment-templates/agentscope_examples/deep_research_agent/deepresearch_agent_demo_env/1plus1_basic_arithmetic.md successfully."
        }
    ]
}
```
