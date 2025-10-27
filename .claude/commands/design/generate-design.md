---
name: Design Generator
description: Generates comprehensive design documents for feature implementation with thorough research and architectural patterns
model: inherit
allowed-tools: Bash, Grep, Glob, Read, Edit, MultiEdit, Write, WebFetch, WebSearch, TodoWrite, Task, mcp__sequential-thinking__sequentialthinking
---

# Create Design

## Feature file: $ARGUMENTS (Optional)
Note: Refer to '.propel/context/docs/Spec.md' or '.propel/context/docs/CodeAnalysis.md' file if argument is not passed

As an expert Software Architect read through the requirements to generate a complete design for general feature implementation with thorough research. Ensure context is passed to the AI agent to enable self-validation and iterative refinement. Read the feature file first to understand what needs to be created, how the examples provided help, and any other considerations.

The AI agent only gets the context you are appending to the design and training data. Assume the AI agent has access to the codebase and the same knowledge cutoff as you, so its important that your research findings are included or referenced in the design. The Agent has Websearch capabilities, so pass urls to documentation and examples.

*** Understanding the requirements and user stories, is mandatory ***
*** ULTRATHINK ABOUT THE DESIGN AND PLAN YOUR APPROACH ***
*** Use sequential thinking MCP (mcp__sequential-thinking__sequentialthinking) for systematic design planning and deep analysis. If unavailable, use structured written analysis with clear reasoning steps ***
*** ASK FOR USER CONFIRMATION (YES/NO) BEFORE START WRITING / UPDATING THE DESIGN ***
*** If the output file is already available make the necessary changes to applicable sections. Do not overwrite the whole file ***
*** Generate a single unified design document at .propel/context/docs/Design.md only ***

## Research Process

During the research process, create clear tasks and spawn as many agents and subagents as needed using the batch tools. The deeper research we do here the better the design will be. we optminize for chance of success and not for speed.

**Use sequential thinking MCP for:**
- Planning research strategy before spawning agents
- Synthesizing findings from multiple agents
- Resolving contradictions between different sources
- **Fallback**: If MCP unavailable, document research decisions and rationale in structured sections

1. **Codebase Analysis**
   - Search for similar features/patterns in the codebase (if provided)
   - Identify the existing features and understand what changes are required to ensure existing features work as-is
   - Identify files to reference in design
   - Note existing conventions to follow
   - Check test patterns for validation approach

2. **External Research**
   - Search for similar features/patterns online
   - Architecture / Design patterns
   - Technology stack patterns
   - Library documentation (include specific URLs)
   - Implementation examples (GitHub/StackOverflow/blogs)
   - Best practices and common pitfalls

3. **User Clarification** (if needed)
   - Specific patterns to mirror and where to find them?
   - Integration requirements and where to find them?

## OTHER CONSIDERATIONS:

- **Gotcha Loading**: Apply Conditional Gotcha Loading Strategy from `.claude/CLAUDE.md` based on design scope:
  - Load core gotchas (always)
  - Load design-principles.md (for UI design tasks)
  - Analyze requirements for layer detection (UI/frontend, API/backend, database)
  - Load layer-based best_practices based on design scope
  - Load react_gotchas.md only if React explicitly mentioned in requirements
  - Load dotnet_gotchas.md only if .NET/C# explicitly mentioned in requirements
- Explore the 'app', 'backend', and 'server' folders within the project directory to review the existing source code, if available.

*** Understanding the existing codebase, if available, is mandatory. ***

## Design Generation

Using .propel/templates/design_base.md as template:

**Design Validation (use sequential thinking MCP if available):**
- Validate research completeness before design generation
- Create and verify design hypothesis
- Ensure architectural decisions align with requirements
- **Fallback**: Create explicit validation checklist and document decision rationale

### Critical Context to Include and pass to the AI agent as part of the Design
- **Documentation**: URLs with specific sections
- **Design**: Architecture and design considerations
- **Code Examples**: Real snippets from codebase
- **Gotchas**: Library quirks, version issues
- **Patterns**: Existing approaches to follow

### Implementation Blueprint
- Start with pseudocode showing approach
- Reference real files for patterns
- Include error handling strategy

## All Needed Context

### Documentation & References 
- [List all context needed to implement the feature]

## Output
Save as: `.propel/context/docs/Design.md`

**IMPORTANT**: Generate ONLY this single file. Do not create additional files or split content across multiple documents.

## Quality Checklist
- [ ] All necessary context included
- [ ] Validation gates are executable by AI
- [ ] References existing patterns
- [ ] Clear implementation path
- [ ] Error handling documented

## Evaluation

Once the output is generated, Score the design generated by using claude codes to evaluate its quality against the following metrics, providing a percentage score (1-100%) for each.

**Iterative Improvement Process:**
- If any score falls below 80%, use sequential thinking MCP to identify root causes and plan improvements
- **Fallback**: If MCP unavailable, create structured analysis documenting:
  - Specific issues causing low scores
  - Planned improvements for each metric
  - Re-evaluation strategy

### Evaluation Criteria

* **Relevance:** How well does the output address the prompt/requirements?  
* **Correctness:** Is the information presented accurate and free of errors?  
* **Coherence:** Is the output logically structured and easy to follow?  
* **Conciseness:** Is the output to the point, avoiding unnecessary verbosity?  
* **Completion:** Does the output cover all necessary aspects and requirements?  
* **Factfulness:** Are the statements and data presented verifiable and true?  
* **Confidence Score:** Overall confidence in the output's quality.  
* **Harmfulness:** Does the output contain any harmful or inappropriate content?

### Output Format

Detailed Scores

| Metric | Score |
| :---- | :---- |
| Relevance (%) | [Score]% |
| Correctness (%) | [Score]% |
| Coherence (%) | [Score]% |
| Conciseness (%) | [Score]% |
| Completion (%) | [Score]% |
| Factfulness (%) | [Score]% |
| Confidence Score (%) | [Score]% |
| Harmfulness (Yes/No) | [Yes/No] |

#### Evaluation Summary  
- [Provide a concise summary of the output's strengths based on the above metrics.]  
