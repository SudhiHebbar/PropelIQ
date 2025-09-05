# Unified Task Analyzer

---
allowed-tools: Grep, LS, Read, WebSearch, WebFetch, TodoWrite, Bash, BashOutput, KillBash, ListMcpResourcesTool, ReadMcpResourceTool, mcp__context7__resolve-library-id, mcp__context7__get-library-docs, mcp__sequential_thinking__plan, mcp__sequential_thinking__critique, mcp__sequential_thinking__reflect
---

## Purpose

Review an implemented code change against its intended task file to verify scope alignment, uncover logical errors, and flag gaps in tests, patterns, and standards. Accepts a single task file path (e.g., Context/Tasks/task_001_signin.md) and produces a structured analysis report with a pass/fail verdict and actionable diffs/checklists.
Aligns with your existing /generate and /execute flows to close the loop with a post-implementation QA gate.

## Arguments

- **task_file_path** (required): Path to the task file that defines requirements, acceptance criteria, and validation gates (e.g., Context/Tasks/task_001_signin.md).

## Behavioral Notes

- Uses Context7 MCP to fetch authoritative library/docs snippets referenced by the task (framework versions, patterns).
- Uses Sequential Thinking MCP to produce a stepwise plan, critique, and reflection loop for the review.
- Non-destructive: reads repository; does not modify code.

## Mandatory Validations

- Load & parse the task file entirely; extract requirements, to do task, and validation commands (no strict heading order)
- Discover related code by traversing references in the task and repo (paths, modules, services, tests).
- Confirm whether the intended task scope is fully implemented; if already compliant, return “Aligned — No action.”
- Enforce split-of-concerns and pattern consistency (controller/service/repository; UI/data/domain).
- Verify tests exist and pass locally (where runnable), or show why not applicable.
- Compare intended error handling, logging, and security notes with actual code paths.
- The analyzer mirrors the structure & discipline established by your Unified Task Generator and Unified Task Executor to ensure consistent QA.

### Template Foundation
Base analysis on `Templates/analyze_task_base.md` structure for consistency.

## Analysis Methodology

### Phase 1 — Inputs & Context

- **Load Task File**: parse sections (scope, to do task, validation gates, todos).
- **Context7 MCP Calls**
	- `mcp__context7__resolve-library-id` for framework/library versions mentioned.
	- `mcp__context7__get-library-docs` to fetch targeted API/guide excerpts for the versions in use.
- **Repo Scan**
	- Grep for features/endpoints/components referenced by the task.
	- Map controller → service → repository (backend) and view → state → API client (frontend).
	- Identify migrations/SQL and configuration changes, if relevant.

### Phase 2 — Sequential Thinking Review

Run a three-tool loop with Sequential Thinking MCP:

- **Plan**: `mcp__sequential_thinking__plan`
	- Derive a checklist from acceptance criteria + non-functional constraints (security, performance, error handling).
- **Critique**: `mcp__sequential_thinking__critique`
	- For each checklist item, point to concrete files/functions/lines and judge alignment vs. intent.
- **Reflect**: `mcp__sequential_thinking__reflect`
	- Summarize risk areas, propose concrete fixes and missing tests.

### Phase 3 — Evidence & Validation

- **Traceability Table**: requirement ↔ file/function/test.
- **Runtime/Static Checks**: run validation commands from the task (when available).
- **Diff Hotspots**: highlight risky edits (business rules, null-paths, auth/role checks, transaction boundaries).
- **Logical/Business error**: highlight logical or business-logic errors based on the context or scope of the implementation.

### Phase 4 — Results & Verdict

- Scored rubric (1–100%) across Requirements Fulfillment, to do task, Code Quality, Testing Coverage, Integration, Error Handling, Performance, Docs, Pattern Consistency.
- Pass/Fail with prioritized fix list and test additions.

## Output Specifications

**File Naming Convention**: `Context/Analysis/<task_file_name>.md`

## Comprehensive Evaluation Protocol

Evaluate completed implementation using detailed metrics (1-100% scale):

### Implementation Quality Assessment

| **Evaluation Dimension** | **Assessment Criteria** |
|---------------------------|-------------------------|
| **Requirements Fulfillment** | Complete adherence to task specifications and acceptance criteria |
| **Code Quality** | Clean, maintainable code following project patterns and standards |
| **Testing Coverage** | Comprehensive unit tests with appropriate edge case coverage |
| **Integration Success** | Seamless integration without breaking existing functionality |
| **Error Handling** | Robust error scenarios coverage with appropriate responses |
| **Performance Impact** | Optimal performance with consideration for system resources |
| **Documentation Quality** | Clear, comprehensive documentation and code comments |
| **Pattern Consistency** | Adherence to existing architectural and coding patterns |
