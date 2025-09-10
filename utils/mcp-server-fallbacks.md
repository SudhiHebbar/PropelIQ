# MCP Server Fallback Strategies - Simplified

This guide provides simple, agent-level fallback strategies when MCP servers fail. No external utilities required - just reactive error handling within agent prompts.

### 🌐 Context7 (Documentation Research)
**Priority:** CRITICAL
**Failure Impact:** High - affects all framework research and best practices

#### Fallback Strategy:
```markdown
1. **Primary Fallback:** WebSearch tool for documentation
   - Search for "[framework] documentation [topic]"
   - Look for official docs, GitHub repos, Stack Overflow
   - Focus on recent/authoritative sources

2. **Secondary Fallback:** Local documentation analysis
   - Read README files in project
   - Check package.json for dependency clues
   - Look for existing patterns in codebase

3. **Tertiary Fallback:** Generic best practices
   - Apply common patterns for the language/framework
   - Use industry standard approaches
   - Reference well-known architectural patterns
```

#### Example Implementation:
```markdown
**When Context7 fails:**
- Instead of: `mcp__context7__get-library-docs`
- Use: `WebSearch` with query: "React hooks best practices 2024"
- Then: `Read` existing project files for patterns
- Finally: Apply generic React/Vue/Angular patterns
```

---

### 🧠 Sequential-Thinking (Complex Reasoning)
**Priority:** CRITICAL  
**Failure Impact:** High - affects complex analysis and reasoning chains

#### Fallback Strategy:
```markdown
1. **Primary Fallback:** Manual step-by-step analysis
   - Break complex problems into smaller parts
   - Use structured reasoning approach manually
   - Document each step of analysis clearly

2. **Secondary Fallback:** Direct analysis
   - Skip complex reasoning chains
   - Provide immediate insights based on available data
   - Focus on practical recommendations over deep analysis

3. **Tertiary Fallback:** Simplified logic
   - Use basic if-then reasoning
   - Apply straightforward analysis patterns
   - Reduce analysis depth but maintain accuracy
```

#### Example Implementation:
```markdown
**When Sequential-Thinking fails:**
- Instead of: Complex multi-step reasoning chains
- Use: "Step 1: Analyze X, Step 2: Consider Y, Step 3: Conclude Z"
- Focus on: Clear, logical progression without MCP assistance
- Maintain: Quality insights through structured approach
```

---

### 🎭 Playwright (Browser Automation)
**Priority:** OPTIONAL (Agent-dependent)
**Failure Impact:** Medium for design-analyzer, Low for others

#### Fallback Strategy:
```markdown
1. **Primary Fallback:** Static UI code analysis
   - Read CSS/SCSS files for styling patterns
   - Analyze HTML/JSX structure manually
   - Review accessibility attributes in code

2. **Secondary Fallback:** Manual design review
   - Provide UI recommendations based on code review
   - Use existing design principles and best practices  
   - Skip automated testing, provide manual test plans

3. **Tertiary Fallback:** Skip UI automation
   - Focus on code quality and logic review
   - Provide design recommendations without testing
   - Document manual testing requirements
```

#### Agent-Specific Handling:
```markdown
**design-analyzer:** CRITICAL degradation - core functionality lost
**pr-code-reviewer:** Minor impact - skip UI automation
**mvp-builder:** Medium impact - use manual UI planning
```

---

### 🐙 GitHub (Repository Integration)  
**Priority:** HIGH
**Failure Impact:** Medium - affects PR integration and repository analysis

#### Fallback Strategy:
```markdown
1. **Primary Fallback:** Local git commands via Bash
   - `git status`, `git diff`, `git log` for repository info
   - `git show` for specific commit details
   - Local file analysis using Read tool

2. **Secondary Fallback:** Direct file analysis
   - Read changed files directly from local filesystem
   - Use Grep to find patterns and dependencies
   - Manual analysis of project structure

3. **Tertiary Fallback:** Manual code review
   - Focus on code quality without PR context
   - Provide general recommendations
   - Skip PR-specific metadata and integration
```

#### Example Implementation:
```markdown
**When GitHub MCP fails:**
- Instead of: `mcp__github__get_pull_request_files`
- Use: `Bash: git diff --name-only HEAD~1`
- Then: `Read` each changed file individually
- Focus on: Code quality without PR integration
```

---

### 🎨 Shadcn (UI Components)
**Priority:** CONTEXTUAL (Essential for mvp-builder, Optional elsewhere)
**Failure Impact:** High for UI-focused agents, Low for others

#### Fallback Strategy:
```markdown
1. **Primary Fallback:** Generic UI component patterns
   - Use common React/Vue/Angular component patterns
   - Reference standard UI library conventions
   - Apply Material Design or similar principles

2. **Secondary Fallback:** Framework-specific defaults
   - Use built-in components of the target framework
   - Reference official framework component libraries
   - Apply established design system patterns

3. **Tertiary Fallback:** Manual UI planning
   - Provide component structure recommendations
   - Skip specific shadcn component discovery
   - Focus on functional UI design principles
```

#### Context-Specific Handling:
```markdown
**mvp-builder:** Use generic React components, manual UI planning
**pr-code-reviewer:** Skip component analysis, focus on code quality
**design-analyzer:** Use manual design review principles
```

---

### ⚙️ Azure DevOps (Project Integration)
**Priority:** OPTIONAL
**Failure Impact:** Low - affects project templates and DevOps integration

#### Fallback Strategy:
```markdown
1. **Primary Fallback:** Generic DevOps templates
   - Use standard CI/CD pipeline patterns
   - Apply common project structure templates
   - Reference industry-standard DevOps practices

2. **Secondary Fallback:** Manual setup instructions
   - Provide step-by-step setup guidance
   - Focus on generic tooling (GitHub Actions, etc.)
   - Skip Azure-specific integrations

3. **Tertiary Fallback:** Skip DevOps integration
   - Focus on core functionality development
   - Provide manual deployment guidance
   - Skip automated pipeline setup
```

---

## Fallback Decision Matrix

| Server | mvp-builder | pr-code-reviewer | task-analyzer | design-analyzer |
|--------|-------------|------------------|---------------|----------------|
| context7 | **CRITICAL** - Use WebSearch | **CRITICAL** - Use WebSearch | **CRITICAL** - Use WebSearch | **HIGH** - Use WebSearch |
| sequential-thinking | **CRITICAL** - Manual reasoning | **HIGH** - Simplified analysis | **CRITICAL** - Step-by-step | **MEDIUM** - Direct analysis |
| playwright | **MEDIUM** - Manual UI | **LOW** - Skip UI tests | **LOW** - Skip automation | **CRITICAL** - Static analysis |
| github | **MEDIUM** - Git commands | **HIGH** - Git commands | **MEDIUM** - Local analysis | **LOW** - Skip PR context |
| shadcn | **HIGH** - Generic components | **LOW** - Skip components | **LOW** - Skip components | **MEDIUM** - Generic patterns |
| azure-devops | **LOW** - Generic templates | **LOW** - Skip integration | **LOW** - Skip integration | **LOW** - Skip integration |

## Simple Implementation

### MCP Failure Tracking (Optional)
```bash
# Log failures for circuit breaker logic (optional)
echo "$(date +%s) context7 failed" >> .cache/mcp-failures.log

# Check recent failures
tail -5 .cache/mcp-failures.log | grep -c context7
# If >= 3, use fallback for rest of session
```

## Agent Integration Pattern

### Simple Reactive Fallback
```markdown
## MCP Error Handling in Agents

1. **Primary Attempt:**
   [MCP server call - e.g., mcp__context7__get-library-docs]

2. **On Error/Failure:**
   Apply fallback strategy immediately:
   - Context7 failure → WebSearch for documentation
   - Sequential-thinking failure → Manual step-by-step analysis
   - Playwright failure → Static UI code analysis
   - GitHub failure → Local git commands via Bash
   - Shadcn failure → Generic UI component patterns
   - Azure DevOps failure → Skip integration, use generic templates

3. **Continue execution** with fallback data

**No complex health checking - just immediate reactive fallbacks when MCP tools fail.**
```