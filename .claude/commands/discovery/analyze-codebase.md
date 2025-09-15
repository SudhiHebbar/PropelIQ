# Codebase Analysis Command

---
allowed-tools: Bash, Read, Glob, Task
---

## Purpose
Entry point for comprehensive codebase analysis. Validates input and delegates complex analysis to the code-analyzer agent.

## Input Parameters: $ARGUMENTS (Optional)
**Accepts:** Repository URL | Folder Path | Root path | Technology stack | Business domain | Analysis depth

**Default Parameters:**
- `repo_url`: Current directory or provided Git URL
- 'Folder_path': Source code directory
- `root_path`: "." (current directory)
- `primary_stack`: Auto-detected from codebase
- `business_domain`: "General business application"
- `analysis_depth`: "comprehensive" (or "standard", "quick")
- `time_budget_minutes`: 60
- `priority_areas`: "architecture, security, performance, data model, integrations"

## Execution Flow

### 1. Parameter Validation
- Validate repository access and permissions
- Set default values for missing parameters
- Verify basic repository accessibility

### 2. Agent Delegation
- Invoke **code-analyzer** agent with validated parameters
- Pass structured context including:
  - User-specified preferences and constraints
  - Analysis scope and time budget
  - Repository path and access permissions

### 3. Summary Presentation
- Present executive summary from agent analysis
- Highlight critical findings and recommendations
- Provide link to full detailed report in `Context/Docs/CodeAnalysis.md`

## Usage Examples

```bash
# Analyze current directory with comprehensive depth
/analyze-codebase

# Analyze specific repository with business context
/analyze-codebase https://github.com/user/repo --domain="E-commerce platform"

# Quick analysis with specific focus areas
/analyze-codebase --depth=quick --priority="security,performance"
```

## Integration Notes

- This command acts as the **guided user-facing entry point**
- All complex analysis, research, and codebase traversal are handled by the **code-analyzer** agent
- The agent leverages both Context7 and sequential-thinking MCP servers for optimal performance
- Results are aggregated and presented in both summary and detailed formats

## Alternative: Direct Agent Access

**For power users:** You can also invoke the analysis agent directly for full parameter control:

```bash
# Direct agent invocation with advanced parameters
@code-analyzer repo-path --depth=comprehensive --parallel-tasks=8 --time-budget=120

# Direct invocation with minimal parameters (uses smart defaults)  
@code-analyzer . --depth=quick --focus="security,performance"
```

**Choose your approach:**
- **`/analyze-codebase`** - Guided experience with validation and user-friendly interface
- **`@code-analyzer`** - Direct access with full parameter control for experts

---

*Optimized for scalability and hybrid processing through agent delegation.*