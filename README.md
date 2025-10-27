# PropelIQ 🚀

> **AI-driven velocity from idea to deploy**

An enterprise-grade framework that combines **Claude Code**, **specialized AI agents**, and **proven templates** to accelerate high-quality software development across multiple technology stacks.

## 📋 Table of Contents

### 🚀 **Getting Started**
[Quick Start](#-quick-start) • [How It Works](#️-how-propeliq-works) • [Architecture](#️-architecture) • [Technology Stacks](#️-supported-technology-stacks)

### 🛠️ **Development**  
[Commands & Workflows](#-commands--workflows) • [Specialized Agents](#-specialized-agents) • [Examples](#-examples--use-cases) • [Quality Standards](#-quality-standards)

### 📚 **Resources**
[Documentation](#-documentation--resources) • [FAQ](#-frequently-asked-questions) • [Contributing](#-contributing) • [Support](#-support--community)

## 🎯 Why Choose PropelIQ?

**From idea to production in minutes, not hours:**

| Traditional Development | PropelIQ | Time Saved |
|------------------------|-------------------|------------|
| Manual project setup | `/generate-task` + `/execute-task` | **70%** |
| Writing test plans | `/generate-automation-test` | **60%** |
| Code reviews | `/review-pr` with AI analysis | **70%** |
| Requirements analysis | `/analyze-codebase` + `/generate-requirements` | **75%** |

### 🚀 Core Value Propositions

**🎯 Rapid Prototyping** - Go from user story to working prototype in few hours  
**🔍 Intelligent Analysis** - Deep codebase understanding with C4 architecture diagrams  
**🧪 Test-First Development** - Automated Playwright test generation from requirements  
**⚡ Production Ready** - Enterprise patterns with SOLID principles and security best practices  
**🤖 AI-Enhanced Workflows** - 5 specialized agents for targeted development assistance

## 📋 Prerequisites

### Required Tools
- **Claude Code**: Latest version (https://www.anthropic.com/claude-code)
- **Git**: Version 2.25 or higher

### Technology-Specific Requirements
- **Node.js**: Version 18.x or higher

### Optional Tools
- **Azure CLI**: For Azure DevOps integration (if using azops commands)
- **GitHub CLI**: For GitHub integration (if using gitops commands)
- **VS Code or Cursor**: Optional IDEs for integration with Claude Code

## 🔒 Claude Code Security Configuration

This PropelIQ uses Claude Code security hooks to restrict access to sensitive files and prevent accidental exposure of production data.

### Setup Instructions

1. Create or update your `.claude/settings.local.json` file with the following configuration:

```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Read|Write|Edit|MultiEdit",
      "hooks": [{
        "type": "command",
        "command": "python .claude/hooks/file-access-validator.py"
      }]
    }]
  }
}
```

2. The hooks will automatically validate file access based on patterns defined in `.claude/hooks/restricted-patterns.json`

3. You can customize the restricted patterns by editing `.claude/hooks/restricted-patterns.json` to match your security requirements.

**Note**: `.claude/settings.local.json` is gitignored and will not be committed to the repository. This ensures your personal security configurations remain private while allowing team collaboration.

## 🏗️ Architecture

![Alt text](./.propel/media/architecture.png "PropelIQ Architecture")


### 📁 PropelIQ Structure

```
PropelIQ/
├── .claude/                    # Claude Code configuration
│   ├── agents/                 # AI agents (5 specialized agents)
│   │   ├── code-analyzer.md
│   │   ├── design-analyzer.md
│   │   ├── mvp-builder.md
│   │   ├── pr-code-reviewer.md
│   │   └── task-analyzer.md
│   ├── commands/               # Custom commands
│   │   ├── azops/              # Azure DevOps commands
│   │   ├── design/             # Design generation commands
│   │   ├── discovery/          # Analysis & requirements commands
│   │   ├── gitops/             # GitHub operations commands
│   │   ├── task/               # Task management commands
│   │   ├── test/               # Test generation commands
│   │   └── ux/                 # UI/UX review commands
│   └── CLAUDE.md               # Development guidelines
├── .propel/context/            # Generated project artifacts
│   ├── tasks/                  # Generated task plans and user stories
│   │   ├── us_001/            # User story folder
│   │   │   ├── us_001.md      # User story document
│   │   │   ├── task_001_*.md  # Implementation tasks
│   │   │   └── task_002_*.md  # More tasks for this story
│   │   ├── us_002/            # Additional user story folder
│   │   └── task_001_*.md      # General tasks (non-story)
│   ├── test/                   # Generated test workflows
│   ├── figma/                  # Design references
│   ├── docs/                   # Documentation files
│   │   ├── spec.md             # Generated requirements with epics
│   │   ├── design.md           # System design documents
│   │   └── codeanalysis.md     # Codebase analysis results
├── .propel/                    # Best practices library
│   ├── build/                  # Technology configurations
│   ├── gotchas/                # Best practices (15+ docs)
│   ├── templates/              # Output templates
│   └── analyze_code_base.md
│   ├── analyze_task_base.md
│   ├── automation_test_base.md
│   ├── design_base.md
│   ├── requirement_base.md
│   ├── task_base.md
│   └── triage_base.md
├── .env                        # Environment variables (gitignored)
├── .env.example                # Environment variables template
├── .gitattributes              # Git export attributes for template
├── .gitignore                  # Git ignore rules
├── .mcp.json                   # MCP server configuration
├── LICENSE                     # MIT License
└── README.md                   # This file
```

### 📂 Key Directories

<details>
<summary><strong>.claude/</strong> - Claude Code configuration and AI agents</summary>

| Directory | Purpose | Key Files |
|-----------|---------|-----------|
| `agents/` | 5 specialized AI agents | code-analyzer, design-analyzer, mvp-builder, pr-code-reviewer, task-analyzer |
| `commands/` | Custom Claude Code commands | discovery/, task/, design/, test/, gitops/, ux/ |
| `CLAUDE.md` | Development context | Additional instructions for command development |

</details>

<details>
<summary><strong>.propel/context/</strong> - Generated analysis and specifications</summary>

| File/Folder | Generated By | Contains |
|-------------|--------------|----------|
| `docs/codeanalysis.md` | `/analyze-codebase` | Architecture diagrams, security analysis, technical debt |
| `docs/spec.md` | `/generate-requirements` | Epics with mapped requirements, business context |
| `tasks/us_XXX/us_XXX.md` | `/generate-userstory` | Individual user stories with acceptance criteria |
| `tasks/us_XXX/task_*.md` | `/generate-task` | Implementation tasks organized by user story |
| `tasks/task_*.md` | `/generate-task` | General tasks (non-user story) |
| `test/` | `/generate-automation-test` | Test workflow specifications |

</details>

<details>
<summary><strong>.propel/</strong> - Best practices and configuration library</summary>

| Directory | Purpose | Coverage |
|-----------|---------|----------|
| `build/` | Technology configurations | React, .NET, Python, Node.js setups |
| `gotchas/` | Comprehensive best practices | 15+ documentation files covering all aspects |
| `templates/` | Structured output templates | Analysis reports • Requirements • Design • Tasks • Tests |

</details>

<details>
<summary><strong>test-automation/</strong> - Generated Playwright test suites</summary>

| Directory | Purpose |
|-----------|---------|
| `tests/` | Executable Playwright test files |
| `pages/` | Page Object Model classes |
| `data/` | Test data and fixtures |
| `utils/` | Test utilities and helpers |

</details>

## 🚀 Enhanced Workflow Benefits

### 📊 Epic → User Story → Task Hierarchy

**PropelIQ's structured approach delivers measurable improvements:**

| **Traditional Approach** | **PropelIQ Approach** | **Improvement** |
|---------------------------|------------------------|-----------------|
| Manual requirement analysis | Auto-generated epics with mapped requirements | **75% faster** requirement processing |
| Ad-hoc user story creation | Structured us_XXX stories with acceptance criteria | **60% better** story quality and consistency |
| Scattered task management | Organized us_XXX/task_*.md hierarchy | **80% better** traceability and organization |
| Reactive quality assurance | Built-in INVEST principles and story validation | **70% fewer** requirement changes during development |

### 🎯 Key Workflow Advantages

**1. **Automatic Story Generation****
- **Epic-driven**: Stories generated from epics with proper requirement mapping
- **INVEST Compliance**: All stories follow Independent, Negotiable, Valuable, Estimable, Small, Testable principles
- **Effort Estimation**: Automatic story point calculation (1 point = 6 hours) with breakdown for large stories

**2. **Hierarchical Organization****
- **Clear Traceability**: Epic → User Story → Task → Implementation
- **Folder Structure**: `.propel/context/tasks/us_XXX/` organization for easy navigation
- **Sequential IDs**: Consistent us_001, us_002, task_001, task_002 numbering

**3. **Quality Assurance Integration****
- **Template Compliance**: All outputs follow userstory-base.md and task_base.md templates
- **Validation Gates**: Built-in quality checks at each level
- **Acceptance Criteria**: Given/When/Then format for all user stories

**4. **Flexible Story Management****
- **Selective Generation**: Generate stories for specific epics or entire scope files
- **Manual Override**: Use `/generate-userstory` for additional story creation
- **Multi-input Support**: Accept scope files, epic IDs, URLs, or direct text

## ⚙️ Supported Technology Stacks

| Stack | Framework/Version | Features | Best Practices Doc |
|-------|------------------|----------|--------------------|
| **Frontend** | React 19 + TypeScript + Vite | CSS Modules, Jest, ESLint | [React Gotchas](.propel/gotchas/react_gotchas.md) |
| **Backend** | .NET 8 + ASP.NET Core | Clean Architecture, EF Core, xUnit | [.NET Gotchas](.propel/gotchas/dotnet_gotchas.md) |
| **API** | Python FastAPI | Async patterns, Pydantic, pytest | [Backend Best Practices](.propel/gotchas/backend_best_practices.md) |
| **Web** | Python Django | ORM, Admin, Testing | [Backend Best Practices](.propel/gotchas/backend_best_practices.md) |
| **Server** | Node.js Express + TypeScript | RESTful APIs, Middleware | [Backend Best Practices](.propel/gotchas/backend_best_practices.md) |
| **SPA** | Angular + CLI | Components, Services, Guards | [Frontend Best Practices](.propel/gotchas/frontend_best_practices.md) |
| **Progressive** | Vue 3 + Composition API | Reactive, Composables | [Frontend Best Practices](.propel/gotchas/frontend_best_practices.md) |
| **Cloud** | GoLang + Gin/Echo | High performance, Microservices | [General Coding Standards](.propel/gotchas/general_coding_standards.md) |
| **Enterprise** | Java Spring Boot | Enterprise patterns, JPA | [General Coding Standards](.propel/gotchas/general_coding_standards.md) |

> **📚 Comprehensive Coverage**: Each stack is supported by extensive documentation in `.propel/gotchas/` covering architecture patterns, security, performance, and testing strategies.

## 🛠️ How PropelIQ Works

**The power of AI-driven development automation in 4 simple steps:**

![Alt text](./.propel/media/systemoverview.png "PropelIQ Workflow")

### 🔄 Core Workflow Components

| Component | Role | Example |
|-----------|------|---------|
| **🎯 Commands** | Entry points for all operations | `/analyze-codebase`, `/generate-task`, `/execute-task` |
| **🤖 Specialized Agents** | Domain-specific AI processing | Code analysis, task planning, code review, quick prototype |
| **📋 Templates** | Consistent output structure | Requirements, designs, test plans, analysis reports |
| **📚 Best Practices** | Quality assurance & standards | SOLID principles, security patterns, anti-patterns |
| **🔌 MCP Servers** | External integrations | Context7, Playwright, GitHub, Azure DevOps |

### 💡 Real-World Example: From User Story to Running Tests

```bash
# 1. Start with a user story
echo "Develop a web based onboarding digital platform that supports registration, renewal, and lifecycle management of institutional and
individual memberships. The goal is to simplify the user experience, streamline internal workflows, and enable process automation across membership types and levels." > scope.md

# 2. Generate structured requirements with epics
/generate-requirements scope.md
# → Creates .propel/context/docs/spec.md with epics and acceptance criteria

# 3. Generate user stories from epics
/generate-userstory
# → Creates .propel/context/tasks/us_XXX/us_XXX.md for all epics

# 3a. (Optional) Generate user stories for specific epic
/generate-userstory EP-001
# → Creates .propel/context/tasks/us_XXX/us_XXX.md for EP-001

# 4. Break down user stories into executable tasks
/generate-task .propel/context/tasks/us_001/us_001.md
# → Creates .propel/context/tasks/us_001/task_001_*.md

# 5. Generate comprehensive tests
/generate-automation-test .propel/context/tasks/us_001/us_001.md
# → Creates .propel/context/test/us_001_test_workflow.md

# 6. Convert to executable Playwright scripts
/generate-playwright-scripts
# → Creates test-automation/tests/us_001_*.spec.ts with Page Objects

# 7. Execute the task
/execute-task .propel/context/tasks/us_001/task_001_*.md
# → Implements the task with TodoWrite tracking

# Total time: 5-10 minutes vs 2-4 hours manually
```

### 🎯 Quality Assurance Built-In

Every generated artifact automatically includes:

- **🔒 Security Best Practices** - OWASP Top 10 compliance, input validation
- **⚡ Performance Patterns** - Caching strategies, optimization techniques  
- **🧪 Test Coverage** - Unit, integration, and E2E test generation
- **📖 Documentation** - Code comments, API docs, architecture diagrams
- **🔍 Code Review** - Automated quality checks and validation

## 🤖 Specialized Agents

PropelIQ includes **5 AI agents** that provide targeted expertise for different aspects of software development:

| Agent | Purpose | When to Use | Key Capabilities |
|-------|---------|-------------|------------------|
| **🔍 Code Analyzer** | Deep codebase analysis | Legacy code, technical debt, architecture review | C4 diagrams, security analysis, dependency mapping |
| **👀 PR Code Reviewer** | Comprehensive code review | Pull requests, quality assurance | SOLID principles, vulnerability detection, compliance |
| **🎨 Design Analyzer** | Architecture & design patterns | System design, modernization | Pattern recommendations, scalability assessment |
| **🚀 MVP Builder** ⭐ | General rapid prototyping | Proof of concepts, standard prototyping | Quick prototyping, shadcn UI, lean validation |
| **⚙️ Task Analyzer** | Post-implementation quality review | Quality assurance | Detec task implementation, gate review |

### Agent Integration Patterns

```bash
# Agent invocation through commands
/analyze-codebase # → internally call agent=code-analyzer 
/generate-design # → internally call agent=design-analyzer
/review-pr # → internally call agent=pr-code-reviewer
/analyze-task # → internally call agent=task-analyzer

# Direct agent invocation
@mvp-builder "Scope Description"
@mvp-builder scope-document.md
```

## 🚀 Quick Start

### 1. Get PropelIQ Framework

**Option 1: Direct Clone**
```bash
git clone <repository-url>
cd "PropelIQ"
```

**Option 2: Use GitHub Template (Recommended)**
1. Visit the [PropelIQ GitHub repository](https://github.com/your-org/PropelIQ)
2. Click **"Use this template"** button
3. Name your new repository
4. Clone your new repository:
   ```bash
   git clone <your-new-repo-url>
   cd <your-project-name>
   ```

### 2. Install MCP Servers

**🔧 Environment Variables Setup (Required):**

Set these environment variables before installing MCP servers:

```bash
# Required for Context7 (documentation lookup)
export CONTEXT7_API_KEY="your-context7-api-key"

# Required for GitHub integration
export GITHUB_PAT="your-github-personal-access-token"

# Required for Azure DevOps integration
export AZ_DEVOPS_ORG="your-azure-devops-organization"
```

**📦 Complete MCP Server Setup:**

```bash
# Core MCP servers (Required)
claude mcp add context7 http https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY=${CONTEXT7_API_KEY}" --scope project
claude mcp add sequential-thinking stdio npx @modelcontextprotocol/server-sequential-thinking --scope project

# Development & Testing
claude mcp add playwright stdio npx @playwright/mcp@latest --scope project

# Platform Integrations (Choose based on your needs)
claude mcp add github stdio npx -y @modelcontextprotocol/server-github@latest --env "GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PAT}" --scope project
claude mcp add azure-devops stdio npx -y @azure-devops/mcp ${AZ_DEVOPS_ORG} --scope project

# UI Development (Required for MVP Builder)
claude mcp add shadcn stdio npx shadcn@latest mcp --scope project
```

**🎯 MCP Server Requirements by Use Case:**

| Use Case | Required MCP Servers | Purpose |
|----------|---------------------|---------|
| **Basic Development** | Context7, sequential-thinking | Core framework functionality |
| **Test Automation** | + Playwright | Automated testing capabilities |
| **GitHub Integration** | + GitHub | Pull request reviews, repository operations |
| **Azure DevOps** | + Azure DevOps | Azure DevOps integration |
| **MVP Development** | + shadcn | UI component generation with shadcn |
| **Complete Setup** | All of the above | Full framework capabilities |

After installation, restart Claude Code or reload the configuration to activate the MCP servers.

### 3. Try Your First Command

**🎯 Get started in under 2 minutes:**

```bash
# Analyze an existing project by running the command from the root folder of the existing source code
/analyze-codebase
# → Generates comprehensive analysis in .propel/context/docs/codeanalysis.md

# Create user story for business needs
/generate-requirements [BRD file | Plain text]
# → Generates comprehensive user stories in .propel/context/docs/spec.md
```

**✅ Success indicators:**
- New files appear in `.propel/context/` folder
- Commands complete without errors
- Generated content follows framework templates

## 📋 Commands & Workflows

### 🔄 Common Development Workflows

**🤔 Which workflow should you use?**

![Alt text](./.propel/media/flowdiagram.png "PropelIQ Flow Diagram")

<details>
<summary><strong>🌱 Green-field Development</strong> - Building from scratch</summary>

```bash
# 1. Create requirements with epics
/generate-requirements brd.md
# → .propel/context/docs/spec.md (with epics)

# 2. Generate user stories from epics
/generate-userstory
# → .propel/context/tasks/us_XXX/us_XXX.md (all epics)

# 2a. Or generate stories for specific epic (optional)
/generate-userstory EP-001
# → .propel/context/tasks/us_XXX/us_XXX.md (specific epic)

# 3. Generate system design (optional)
/generate-design .propel/context/docs/spec.md
# → .propel/context/docs/design.md

# 4. Break down user stories into implementation tasks
/generate-task .propel/context/tasks/us_001/us_001.md
# → .propel/context/tasks/us_001/task_001_implement_feature.md

# 5. Execute tasks systematically for code generation
/execute-task .propel/context/tasks/us_001/task_001_implement_feature.md
# → Logic Implementation with TodoWrite tracking

# 6. Quality review (optional)
/analyze-task .propel/context/tasks/us_001/task_001_implement_feature.md
# → Quality assessment and recommendations for the implemented logic
```

</details>

<details>
<summary><strong>🏗️ Brown-field Development</strong> - Working with existing code</summary>

```bash
# 1. Understand the codebase
/analyze-codebase <repo url path | code-base directory | root-path>
# → .propel/context/docs/codeanalysis.md

# 2. Generate requirements with epics
/generate-requirements new-feature-spec.md
# → .propel/context/docs/spec.md (with epics)

# 3. Generate user stories from epics
/generate-userstory
# → .propel/context/tasks/us_XXX/us_XXX.md (all epics)

# 3a. Or generate stories for specific epic (optional)
/generate-userstory EP-002
# → .propel/context/tasks/us_XXX/us_XXX.md (specific epic)

# 4. Break down user stories into implementation tasks
/generate-task .propel/context/tasks/us_005/us_005.md
# → .propel/context/tasks/us_005/task_001_integrate_feature.md

# 5. Execute with existing code integration
/execute-task .propel/context/tasks/us_005/task_001_integrate_feature.md
# → Updated codebase with new functionality
```

</details>

<details>
<summary><strong>🧪 Test-Driven Development</strong> - Tests first approach</summary>

```bash
# 1. Generate comprehensive test workflows
/generate-automation-test .propel/context/docs/spec.md
# → .propel/context/test/test_workflow_*.md

# 2. Create executable Playwright scripts
/generate-playwright-scripts
# → test-automation/tests/, pages/, data/, utils/

# 3. Implement features to pass tests
/execute-task .propel/context/tasks/feature.md
# → Implementation guided by tests
```

</details>

<details>
<summary><strong>🐛 Bug-fixing Workflow</strong> - Systematic issue resolution</summary>

```bash
# 1. Triage bug and create fix task with root cause analysis
/generate-bugfix-task "Bug: Login fails with 500 error on special characters | bug url"
# → Performs comprehensive triage protocol
# → Identifies root cause and impact
# → .propel/context/tasks/task_001_fix_login_special_chars.md

# 2. Execute the generated fix task
/execute-task .propel/context/tasks/task_001_fix_login_special_chars.md
# → Implements fix with regression prevention
# → Guided debugging with TodoWrite tracking

# 3. Verify fix completeness and quality
/analyze-task .propel/context/tasks/task_001_fix_login_special_chars.md
# → Validates bug resolution and test coverage
# → Ensures no regression introduced
```

</details>

<details>
<summary><strong>🚀 MVP Validation</strong> - Validate business hypotheses rapidly </summary>

```bash
# Direct agent invocation for MVP development (requires @mvp-builder)
@agent-mvp-builder "Build a prototype automated invoice tracking"

# Alternative: Provide scope document
@agent-mvp-builder scope-of-work.md

```

</details>

<details>
<summary><strong>🔍 Code Review & Quality</strong> - Maintain high quality standards</summary>

```bash
# Review pull requests
/review-pr [pr-url-or-number | local changes]
# → .propel/context/reviews/review-pr.md with comprehensive analysis

# Resolve specific review comments
/resolve-review-comment [comment-reference]
# → Implements the corrections to resolve the comment.

# UI/UX review with visual testing
/review-user-interface [ui-spec-or-screenshot]
# → Playwright/snapshot.jpg
```

</details>

### 📖 Command Reference

| Command | Purpose | Input | Output |
|---------|---------|-------|--------|
| `/analyze-codebase` | Deep codebase analysis | Repository path/URL | `.propel/context/docs/codeanalysis.md` |
| `/generate-requirements` | Create structured requirements | Specifications, user stories | `.propel/context/docs/spec.md` with epics |
| `/generate-userstory` | Generate user stories from epics | Epic ID, scope file, or text | `.propel/context/tasks/us_XXX/us_XXX.md` |
| `/generate-design` | System design & architecture | Requirements, specifications | `.propel/context/docs/design.md` |
| `/generate-task` | Break down into executable tasks | User stories, requirements | `.propel/context/tasks/us_XXX/task_*.md` or `.propel/context/tasks/task_*.md` |
| `/execute-task` | Implement tasks systematically | Task file path | Technology-specific code |
| `/analyze-task` | Post-implementation quality review | Task file path | Quality assessment report |
| `/generate-automation-test` | Create test workflows | Requirements, use cases | `.propel/context/test/workflow_*.md` |
| `/generate-playwright-scripts` | Convert to executable tests | Workflow files | `test-automation/` structure |
| `/review-pr` | Comprehensive PR analysis | PR URL/number | `.propel/context/reviews/review-pr.md` |
| `/resolve-review-comment` | Address review feedback | Comment reference | Resolution documentation |
| `/review-user-interface` | UI/UX analysis | UI specs, screenshots | `.propel/context/reviews/ui-review.md` |
| `@agent-mvp-builder` | Rapid MVP for hypothesis testing | Business hypothesis or scope doc | `mvp/` folder with working code |


## ⚡ MCP Server Configuration

MCP servers are configured project-wide in the root `.mcp.json` file. This configuration enables seamless integration with external tools and services.

**Complete `.mcp.json` Configuration:**
```json
{
  "mcpServers": {
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      }
    },
    "playwright": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "@playwright/mcp@latest"
      ],
      "env": {}
    },
    "sequential-thinking": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "@modelcontextprotocol/server-sequential-thinking"
      ],
      "env": {}
    },
    "azure-devops": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@azure-devops/mcp",
        "${AZ_DEVOPS_ORG}"
      ],
      "env": {}
    },
    "shadcn": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "shadcn@latest",
        "mcp"
      ],
      "env": {}
    },
    "github": {
      "type": "stdio",
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github@latest",
        "--env",
        "GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PAT}"
      ],
      "env": {}
    }
  }
}
```

**Complete `.env` Configuration:**
```
# Core APIs
CONTEXT7_API_KEY=your-context7-api-key-here

# Platform Integration
GITHUB_PAT=your-github-personal-access-token
AZ_DEVOPS_ORG=your-azure-devops-organization
```

**Security:**  
The `.env` file is listed in `.gitignore` and should never be committed to the repository.

**Setup Steps:**
1. Copy `.mcp.json` from the repository root.
2. Create a `.env` file in the root and add your API keys.
3. Run `claude mcp list` or `/mcp` to verify MCP server setup.
4. Run `/agent` to verify the available agents.
5. Use `@` (e.g. @agent-mvp-builder) to run the agents directly

## 🏆 Quality Standards

**Built-in enterprise-grade quality assurance:**

### 📊 Metrics & Standards
- **Maximum 500 lines** per source file for maintainability
- **80% minimum test coverage** across all application layers  
- **SOLID principles compliance** with automated validation
- **Comprehensive documentation** for all public APIs and components
- **Security-first approach** with OWASP Top 10 compliance

### ✅ Validation Commands
```bash
# Universal quality checks built into all generated code
npm run lint && npm test && npm build        # React/Node.js
dotnet format && dotnet test && dotnet build # .NET
pytest --cov=src tests/ --cov-report=term   # Python
```

### 🛡️ Built-in Protections
- **Anti-pattern detection** and prevention across all technology stacks
- **Performance optimization** patterns applied automatically  
- **Security vulnerability** scanning and remediation suggestions
- **Database optimization** with query analysis and indexing recommendations
- **DevOps best practices** integration for CI/CD pipelines

## ❓ Frequently Asked Questions

<details>
<summary><strong>🚀 Getting Started</strong></summary>

**Q: Do I need Claude Code to use PropelIQ?**
A: Yes, PropelIQ is specifically designed for Claude Code and requires it to function.

**Q: Which MCP servers do I need?**  
A: **Basic**: Context7 + sequential-thinking. **Testing**: Add Playwright. **Azure**: Add Azure DevOps MCP.

**Q: Can I use this with existing projects?**  
A: Absolutely! Use the brown-field workflow starting with `/analyze-codebase`.

</details>

<details>
<summary><strong>🛠️ Development</strong></summary>

**Q: Which technology stacks are fully supported?**  
A: It support most of the technology stack.

**Q: Can I add custom commands?**  
A: Yes! Follow patterns in `.claude/commands/`.

</details>

<details>
<summary><strong>⚡ Performance</strong></summary>

**Q: How much time does this save?**  
A: **70-80% reduction** in setup time, **60% faster** code reviews, **75% faster** requirements analysis.

**Q: What's the learning curve?**
A: **2 minutes** to first command, **30 minutes** to productive workflows, **1 hour** for advanced features.

</details>

<details>
<summary><strong>📋 Epics, User Stories & Tasks</strong></summary>

**Q: What's the difference between epics, user stories, and tasks?**
A: **Epics** are high-level features mapped to requirements. **User Stories** (us_XXX) break epics into user-focused deliverables. **Tasks** break stories into 4-hour implementation units.

</details>

## 🤝 Contributing

### Development Workflow
1. Follow existing patterns in the codebase
2. Reference `.propel/gotchas/` for technology-specific guidance
3. Use validation commands before committing
4. Ensure comprehensive test coverage

### Adding New Technology Stacks
1. Create configuration in `.propel/build/`
2. Add best practices to `.propel/gotchas/`
3. Update validation commands
4. Include example implementations

### Custom Command Development
1. Follow patterns in `.claude/commands/`
2. Commands are defined as Markdown files with specific structure
3. Include comprehensive documentation and usage examples
4. Ensure quality validation integration

### Agent Development
1. Create agent using /agent --> create new agent in the Claude code.
2. Define agent purpose, capabilities, and integration points
3. Include clear usage guidelines and examples
4. Ensure agents work seamlessly
5. Test agent functionality across different scenarios
6. Agents are defined as Markdown files with specific structure in `.claude/agents/`
7. Ensure quality validation integration

## 📚 Documentation & Resources

### 🎯 By User Journey

<details>
<summary><strong>🚀 Getting Started</strong> [New Users]</summary>

| Document | Purpose |
|----------|---------|
| [README.md](README.md) | Complete PropelIQ overview |
| [.propel/gotchas/framework_methodology.md](.propel/gotchas/framework_methodology.md) | Usage patterns and workflows |
| [.propel/gotchas/troubleshooting_guide.md](.propel/gotchas/troubleshooting_guide.md) | Common setup issues and solutions |

</details>

<details>
<summary><strong>🛠️ Development Reference</strong> [Active Development]</summary>

| Category | Document | Purpose |
|----------|----------|---------|
| **Commands** | `.claude/commands/*/` | All command implementations |
| **Templates** | `.propel/templates/*.md` | Output structure templates |
| **Generated** | `.propel/context/*.md` | Your project analysis and specs |

</details>

<details>
<summary><strong>📖 Best Practices</strong> [Quality Assurance]</summary>

| Focus Area | Document |
|------------|----------|
| **Architecture** | [architecture_patterns.md](.propel/gotchas/architecture_patterns.md) • [design-principles.md](.propel/gotchas/design-principles.md) |
| **Quality** | [anti_patterns.md](.propel/gotchas/anti_patterns.md) • [validation_commands.md](.propel/gotchas/validation_commands.md) |
| **Frontend** | [frontend_best_practices.md](.propel/gotchas/frontend_best_practices.md) • [react_gotchas.md](.propel/gotchas/react_gotchas.md) |
| **Backend** | [backend_best_practices.md](.propel/gotchas/backend_best_practices.md) • [dotnet_gotchas.md](.propel/gotchas/dotnet_gotchas.md) |
| **Database** | [database_best_practices.md](.propel/gotchas/database_best_practices.md) |
| **DevOps** | [devops_best_practices.md](.propel/gotchas/devops_best_practices.md) |
| **Testing** | [automation_testing_gotchas.md](.propel/gotchas/automation_testing_gotchas.md) • [testing_workflow_patterns.md](.propel/gotchas/testing_workflow_patterns.md) |
| **Standards** | [general_coding_standards.md](.propel/gotchas/general_coding_standards.md) • [anti_redundancy_rules.md](.propel/gotchas/anti_redundancy_rules.md) |

</details>

<details>
<summary><strong>⚙️ Advanced Configuration</strong> [Power Users]</summary>

| Component | Configuration |
|-----------|---------------|
| **AI Agents** | `.claude/agents/*.md` - 6 specialized agents (including MVP Builder) |
| **MCP Setup** | `.mcp.json` - Server integrations |

</details>

## 💡 Examples & Use Cases

### 🏪 E-commerce Platform (Brown-field)
```bash
# 1. Analyze codebase for insights
/analyze-codebase https://github.com/competitor/shop

# 2. Generate epics from requirements
/generate-requirements "Multi-vendor shopping cart with payment integration"
# → .propel/context/docs/spec.md (with epics)

# 3. Generate user stories from epics
/generate-userstory
# → .propel/context/tasks/us_XXX/us_XXX.md (all epics)

# 3a. Or generate stories for specific features (optional)
/generate-userstory EP-001
# → .propel/context/tasks/us_XXX/us_XXX.md (specific epic)

# 4. Create comprehensive test suite
/generate-automation-test .propel/context/docs/spec.md
/generate-playwright-scripts

# 5. Break down user stories into implementation tasks
/generate-task .propel/context/tasks/us_003/us_003.md
# → .propel/context/tasks/us_003/task_001_implement_cart.md

# 6. Implement with best practices
/execute-task .propel/context/tasks/us_003/task_001_implement_cart.md
```

### 🏢 Enterprise Dashboard (Green-field)
```bash
# 1. Quick prototype for client validation
@mvp-builder "Real-time analytics dashboard with role-based access for client validation" or <scope document>
# → mvp/ folder with working prototype for stakeholder feedback

# 2. Generate epics from requirements
/generate-requirements "Real-time analytics dashboard with role-based access"
# → .propel/context/docs/spec.md (with epics)

# 2a. Generate user stories from epics
/generate-userstory
# → .propel/context/tasks/us_XXX/us_XXX.md (all epics)

# 3. Design system architecture
/generate-design .propel/context/docs/spec.md

# 4. Break down user stories into implementation tasks
/generate-task .propel/context/tasks/us_001/us_001.md
# → .propel/context/tasks/us_001/task_001_implement_dashboard.md

# 5. Generate secure, scalable implementation
/execute-task .propel/context/tasks/us_001/task_001_implement_dashboard.md
```

### 🔄 App Modernization (Legacy to Modern)
```bash
# 1. Analyze existing codebase for insights (reverse-engineering)
/analyze-codebase https://github.com/legacy-app/monolith
# → .propel/context/docs/codeanalysis.md with C4 diagrams, technical debt, security analysis

# 2. Generate epics for modernization
/generate-requirements "Modernize legacy monolith to microservices with API-first architecture"
# → .propel/context/docs/spec.md with modernization epics

# 3. Generate user stories from modernization epics
/generate-userstory
# → .propel/context/tasks/us_XXX/us_XXX.md (all modernization epics)

# 3a. Or generate stories for specific modernization phases (optional)
/generate-userstory EP-002
# → .propel/context/tasks/us_XXX/us_XXX.md (specific epic)

# 4. Generate system architecture
/generate-design .propel/context/docs/spec.md
# → .propel/context/docs/design.md with modernized system architecture and migration strategy

# 5. Create comprehensive test suite
/generate-automation-test .propel/context/docs/spec.md
/generate-playwright-scripts
# → .propel/context/test/workflow_*.md and test-automation/ with migration validation tests

# 6. Break down modernization stories into implementation tasks
/generate-task .propel/context/tasks/us_005/us_005.md
# → .propel/context/tasks/us_005/task_001_modernize_auth.md (phased implementation tasks)

# 7. Generate secure, scalable implementation
/execute-task .propel/context/tasks/us_005/task_001_modernize_auth.md
# → Modern microservices implementation with security best practices
```

## 🤝 Contributing

**📝 How to Contribute**
1. **Fork the repository** and create a feature branch
2. **Follow existing patterns** in `.claude/commands/` and `.propel/`
3. **Test your changes** with the validation commands
4. **Update documentation** and add examples
5. **Submit a pull request** with clear description

**🔧 Development Guidelines**
- Commands or agents are Markdown files with specific structure. Refer to Claude code documentation for further details.
- Templates ensure consistent output format
- Best practices prevent common pitfalls
- All contributions must include comprehensive documentation

## 📞 Support & Community

- **🐛 Report Issues**: [GitHub Issues](https://github.com/anthropics/claude-code/issues)
- **💬 Discussions**: PropelIQ patterns and use cases
- **📖 Documentation**: Comprehensive guides in `.propel/`
- **🛠️ Troubleshooting**: [troubleshooting_guide.md](.propel/gotchas/troubleshooting_guide.md)

---

**🚀 Ready to transform your development workflow?**  

**[⬆️ Back to top](#propeliq-)** • **[📖 View Documentation](.propel/)** • **[🐛 Report Issues](https://github.com/anthropics/claude-code/issues)**

---

*Built for developers who value quality, speed, and intelligent automation.*
