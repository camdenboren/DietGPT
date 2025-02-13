// SPDX-FileCopyrightText: 2025 Camden Boren
// SPDX-License-Identifier: GPL-3.0-or-later

import { DuckDuckGoSearch } from "@langchain/community/tools/duckduckgo_search";
import { ChatOllama } from "@langchain/ollama";
import { HumanMessage } from "@langchain/core/messages";
import { createReactAgent } from "@langchain/langgraph/prebuilt";
import { z } from "zod";

// Define the structured response format
const CalorieResponseSchema = z.object({
  calories: z.string().describe("Number of calories"),
});

// Define the tools and model used by the agent
const agentTools = [new DuckDuckGoSearch({ maxResults: 1 })];
const agentModel = new ChatOllama({
  model: "mistral:latest",
  temperature: 0,
});

// Create the agent
const agent = createReactAgent({
  llm: agentModel,
  tools: agentTools,
  responseFormat: CalorieResponseSchema,
});

// Now it's time to use!
const agentFinalState = await agent.invoke(
  {
    messages: [
      new HumanMessage(
        "how many calories are in a cup of fat-free greek yogurt?",
      ),
    ],
  },
  { configurable: { thread_id: "42" } },
);

console.log(agentFinalState.structuredResponse);
