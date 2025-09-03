# Codegen Framework 🚀

A comprehensive, enterprise-grade framework for generating high-quality applications across multiple technology stacks using Claude Code (https://www.anthropic.com/claude-code). This repository provides structured templates, best practices, custom Claude Code commands, and quality validation patterns to accelerate development while maintaining professional standards.

## 🎯 What This Project Does

The **Codegen Framework** is a structured approach to generating code, artefacts, and performing code analysis, combining:

- **Multi-stack Templates** for React, .NET, Python, and more
- **Advanced Test Automation** with comprehensive Playwright automation and best practices
- **Quality-First Patterns** with built-in validation and testing strategies  
- **Enterprise Architecture** following SOLID principles and clean code practices
- **Custom Claude Commands** for automated analysis, requirements generation, and task execution
- **Comprehensive Best Practices** covering security, performance, and maintainability

### Key Benefits

✅ **Accelerated Development** - Pre-configured templates and patterns reduce setup time  
✅ **Advanced Test Automation** - Complete Playwright test generation from requirements to executable scripts
✅ **Consistent Quality** - Built-in validation ensures code standards compliance
✅ **Enterprise Ready** - Architecture patterns proven in production environments  
✅ **Multi-Technology** - Support for modern tech stacks and frameworks  
✅ **AI-Enhanced** - Custom Claude Code commands for intelligent assistance


## 🏗️ Repository Architecture

```
📁 Codegen Framework/
├── 📂 .claude/commands/          # Custom Claude Code commands
│   ├── 🔍 discovery/            # analyze-codebase, generate-requirements
│   ├── ⚙️ task/                 # execute-task, generate-task
│   ├── 🎨 design/               # generate-design  
│   ├── 🧪 test/                 # generate-automation-test, generate-playwright-scripts
│   ├── 🔄 gitops/               # review-pr, resolve-review-comment
│   └── 💻 ux/                   # review-user-interface
│   └── settings.local.json      # Local Claude Code settings (never committed)
├── 📂 Context/                   # Generated project analysis & specifications
│   ├── 📄 code-analysis.md      # Output from /analyze-codebase
│   ├── 📄 design.md             # Output from /generate-design
│   ├── 📄 requirements.md       # Output from /generate-requirements
│   ├── 📂 Tasks/                # Task plans and logs (output from /generate-task)
│   └── 📂 Test/                 # Test workflows from /generate-automation-test
├── 📂 References/               # Best practices & configuration libraries
│   ├── 🏗️ Build/               # Technology configurations (react_config.yaml, dotnet_config.yaml)
│   ├── ⚠️ Gotchas/             # Comprehensive best practices documentation
│   └── � Figma/               # Figma design artefacts (optional)
├── 📂 Templates/                # Base templates for command outputs
│   ├── 📄 analyze_code_base.md  # Template for codebase analysis
│   ├── 📄 automation_test_base.md # Template for test workflows
│   ├── 📄 design_base.md        # Template for system design
│   ├── 📄 requirement_base.md   # Template for requirements
│   └── 📄 task_base.md          # Template for task execution
├── 📂 test-automation/         # Generated Playwright test suites
│   ├── 📂 tests/               # Executable test specifications
│   ├── 📂 pages/               # Page Object Model classes
│   ├── 📂 data/                # Test data management
│   ├── 📂 utils/               # Test utilities and helpers
│   └── 📄 playwright.config.ts # Test execution configuration
│   └── 📄 package.json         # Test dependencies and scripts (add as needed)
├── 📄 .env                     # API keys and secrets (never committed)
├── 📄 .mcp.json                # MCP server configuration
├── 📄 .gitignore               # Git ignore rules
└── 📄 README.md                # Project documentation
```

## 🛠️ Supported Technology Stacks

### Frontend
- **React 19** + TypeScript + Vite
  - CSS Modules, SCSS, Path aliases
  - Jest + React Testing Library
  - ESLint + Prettier integration

### Backend  
- **.NET 8** + ASP.NET Core
  - Clean Architecture with layered separation
  - Entity Framework Core + AutoMapper
  - xUnit + Moq + TestContainers

### Additional Stacks
 - **Python FastAPI** with modern async patterns
 - **Python Django** for robust web applications
 - **Node.js Express** with TypeScript
 - **Angular** with Angular CLI
 - **Vue 3** with Composition API
 - **GoLang** with Gin or Echo frameworks
 - **Java** with Spring Boot or Quarkus

## 🌟 Why Choose Codegen Framework?

The Codegen Framework isn't just another template collection—it's a comprehensive system designed for professional software development:

- **🎯 Proven Patterns** - Architecture patterns tested in production environments
- **🚀 AI-Enhanced** - Custom Claude commands for intelligent development assistance  
- **📊 Quality-Focused** - Built-in validation and testing ensure professional standards
- **🔧 Multi-Stack** - Support for modern technology stacks and frameworks
- **📚 Knowledge Base** - Extensive documentation covering best practices and gotchas
- **⚡ Rapid Development** - Reduce setup time while maintaining quality and consistency

Start building better applications faster with the Codegen Framework! 🚀

## 🛠️ How Codegen Works

Codegen Framework orchestrates intelligent generation of code, artefacts, and code analysis through a combination of:

- **Command-Driven Workflow:** All actions are initiated via custom Claude Code commands (see `.claude/commands/`). These commands automate code analysis, requirements, design, testing, and artefact generation (such as documentation, test plans, and more).
- **Best Practices & Standards:** Every command leverages the standards, principles, and anti-patterns documented in the `References/` folder. This ensures generated code is robust, maintainable, and enterprise-grade.
- **MCP Server Integration:** Commands can invoke one or more MCP servers (configured in `.mcp.json`) for advanced context, code analysis, or automation. For example, Playwright MCP for browser automation, Context7 for requirements and analysis, etc.
- **Template-Driven Outcomes:** Structural outputs (requirements, designs, tests, etc.) are generated using templates from the `Templates/` folder. This guarantees consistency and clarity in all deliverables.
- **Context-Aware Generation:** Commands use project context, standards, and MCP server responses to produce outcomes tailored to your technology stack and business needs.

**Workflow Example:**
1. A user runs a command (e.g., `/generate-automation-test Context/requirements.md`).
2. The command references best practices from `References/Gotchas/automation_testing_gotchas.md` and validation rules.
3. If needed, the command queries MCP servers for additional analysis or codegen.
4. The output is structured using a template from `Templates/automation_test_base.md` and saved in the appropriate folder.
5. All generated artifacts follow the standards and patterns defined in the repository.

This approach ensures every generated outcome is:
- Standards-compliant
- Context-aware
- Consistent in structure
- Ready for enterprise use

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <repository-url>
cd "Codegen Framework"
```

### 2. Install MCP Servers
Install both Playwright and Context7 MCP servers for full functionality:

```bash
# Install Playwright MCP server
claude mcp add playwright npx @playwright/mcp@latest

# Install Context7 MCP server
claude mcp add context7 https://mcp.context7.com/mcp
```

After installation, restart Claude Code or reload the configuration to activate the MCP servers.

### 3. Explore Custom Commands
The framework includes specialized Claude Code commands organized by category:

#### 🔍 Discovery & Analysis
```bash
# Analyze existing codebases with comprehensive reverse engineering
/analyze-codebase [repo_url] [analysis_depth] [priority_areas]
# Output: Context/code-analysis.md

# Generate requirements from specifications
/generate-requirements [requirements-source]
# Output: Context/requirements.md
```
#### 🎨 Design & Architecture
```bash
# Create system designs and architecture diagrams
/generate-design [design-specification]
# Output: Context/design.md
```

#### ⚙️ Task Management 
```bash
# Execute tasks systematically with TodoWrite integration
# Generate structured task plans
/generate-task [user-story | task-description]
# Output: Context/Tasks/task_<name>.md (example)

/execute-task [task-file-path]
# Output: technology-specific project file (example)

```

#### 🧪 Test Automation
```bash
# Generate comprehensive test workflows from requirements
/generate-automation-test [requirements-file|use-case|user-story]
# Output: Context/Test/test_workflow_*.md

# Convert test workflows into executable Playwright scripts
/generate-playwright-scripts [workflow-file-path] # Auto-detects from Context/Test/ if empty
# Output: test-automation/tests/, test-automation/pages/, test-automation/data/, test-automation/utils/
```

#### 🔄 GitOps & Code Review
```bash
# Review pull requests with comprehensive analysis
/review-pr [pr-url|pr-number]
# Output: Context/review-pr.md

# Resolve specific review comments
/resolve-review-comment [comment-reference]
# Output: Context/review-comment-resolution.md
```

#### 💻 User Experience
```bash
# Review and analyze user interfaces
/review-user-interface [ui-specification|screenshot-path]
# Output: Context/ui-review.md
```

## 📘 How to use Codegen

Follow these steps to use the Codegen Framework in your project:

1. **Clone the framework to the root folder of your project**
   ```bash
   git clone <repository-url> <your-project-root>
   ```
2. **Launch Claude Code**
   - Use the Claude Code terminal, or integrate Claude Code into VS Code or Cursor.
3. **Install the necessary MCP Servers for Claude Code**
   - Use the provided commands (see MCP Server Configuration section) to add and configure MCP servers.
4. **Execute commands in the Claude Code terminal or write panel**
   - Use the documented commands (e.g., `/generate-requirements`, `/analyze-codebase`, `/generate-automation-test`, etc.).
5. **Artefacts and code outcomes**
   - Artefacts (requirements, analysis, workflows) are stored in the `Context` folder.
   - Code-related outcomes (tests, pages, utils, etc.) are stored in the appropriate project folders.

### Recommended Workflows

#### Green-field Development
- `/generate-requirements` → `/generate-design` (optional) → `/generate-task` → `/execute-task`

#### Brown-field Development
- `/analyze-codebase` → `/generate-requirements` (for new features, optional) → `/generate-task` (using user stories if previous step is skipped) → `/execute-task`

#### Bug-fixing
- `/generate-task` (using bug description) → `/execute-task`

#### Code Review (GitHub only)
- `/review-pr`
- `/review-user-interface` (pixel-perfect design review using Playwright MCP)
- `/resolve-review-comment` (resolve specific review comment)

#### Test Flow
- `/generate-automation-test` → `/generate-playwright-scripts`

## ⚡ MCP Server Configuration

MCP servers are configured project-wide in the root `.mcp.json` file. API keys and secrets must be stored in a `.env` file (which is ignored by git).
 
 **Example `.mcp.json`:**
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
          "args": ["@playwright/mcp@latest"],
          "env": {}
       }
    }
 }
 ```
 
 **Example `.env`:**
 ```
 CONTEXT7_API_KEY=your-api-key-here
 ```
 
 **Security:**  
 The `.env` file is listed in `.gitignore` and should never be committed to the repository.
 
 **Setup Steps:**
 1. Copy `.mcp.json` from the repository root.
 2. Create a `.env` file in the root and add your API key.
 3. Run `claude mcp list` to verify MCP server setup.

- Architecture patterns and design principles
- Technology-specific best practices
- Anti-patterns and common pitfalls
- Validation commands and quality gates

## 🎯 Custom Claude Commands

### 🔍 Discovery Commands

#### `/analyze-codebase`
**Purpose:** Unified codebase analyzer and reverse engineering specialist

**Parameters:**
- `repo_url`: Repository URL or current directory (default: ".")
- `primary_stack`: Auto-detected or specified technology stack
- `analysis_depth`: "comprehensive" | "standard" | "quick" (default: "comprehensive")
- `priority_areas`: "architecture, security, performance, data model, integrations" (default)
- `time_budget_minutes`: Analysis time limit (default: 60)

**Capabilities:**
- **11-Phase Analysis Process**: From repository intelligence to modernization roadmap
- **C4 Architecture Diagrams**: Context, Container, Component, and Deployment views
- **Security Assessment**: OWASP Top 10 compliance and vulnerability scanning
- **Business Logic Documentation**: Reverse-engineered use cases and actor analysis
- **Risk Register**: Prioritized risks with mitigation strategies
- **Output**: Comprehensive analysis report in `Context/code-analysis.md`

#### `/generate-requirements`
**Purpose:** Requirements analysis and documentation from various sources

**Capabilities:**
- User story generation with acceptance criteria
- Use case analysis with Mermaid diagrams
- Actor identification and system boundaries
- Business rule extraction and validation
- **Output**: Structured requirements in `Context/requirements.md`

### ⚙️ Task Management Commands

#### `/execute-task`
**Purpose:** Systematic task execution with comprehensive tracking

**Features:**
- **TodoWrite Integration**: Real-time progress tracking
- **Quality Validation**: Technology-specific validation at each step
- **Error Handling**: Comprehensive rollback and recovery strategies
- **Template-Based**: Uses `Templates/task_base.md` structure

#### `/generate-task`
**Purpose:** Generate structured task plans from descriptions

**Features:**
- Break down complex tasks into manageable steps
- Include validation checkpoints
- Estimate effort and dependencies

### 🎨 Design Commands

#### `/generate-design`
**Purpose:** Create system designs and architecture documentation

**Features:**
- C4 model architecture diagrams
- System design patterns and anti-patterns
- Technology stack recommendations
- **Output**: Design documentation using `Templates/design_base.md`

### 🧪 Advanced Test Automation Pipeline

#### `/generate-automation-test`
**Purpose:** Generate comprehensive test workflows from requirements

**Input Types:**
- **Requirements File**: `Context/requirements.md` (primary source)
- **Specific Use Case**: Targeted workflow for specific scenario
- **User Story Reference**: Story-driven test workflow
- **Feature Specification**: Complete feature validation workflow

**Capabilities:**
- **Process Workflow Design**: Step-by-step user journey automation
- **Playwright Integration Planning**: Selector strategies and page object design
- **Scenario Coverage**: Happy path, edge cases, and error handling
- **Best Practice Compliance**: Follows `References/Gotchas/automation_testing_gotchas.md`
- **Output**: Workflow specifications in `Context/Test/test_workflow_*.md`

#### `/generate-playwright-scripts`
**Purpose:** Convert test workflows into executable Playwright automation

**Integration Pattern:**
```bash
# Complete automation pipeline
/generate-automation-test Context/requirements.md  # → Creates workflows
/generate-playwright-scripts                       # → Auto-detects & processes workflows
```

**Input Modes:**
- **Auto-Discovery** (Default): Scans `Context/Test/` for workflow files
- **Specific File**: Process individual workflow file
- **Directory Scan**: Process all workflows in specified directory
- **Name Pattern**: Find workflows by feature name

**Generated Output Structure:**
```
test-automation/
├── tests/                    # Executable Playwright test files
├── pages/                    # Page Object Model classes
├── data/                     # Test data management
├── utils/                    # Helper functions and setup
├── playwright.config.ts      # Browser and execution configuration
└── package.json             # Dependencies and test scripts
```

**Quality Standards:**
- **Stable Selectors**: Role-based locators and test-ids
- **Proper Wait Strategies**: Web-first assertions, no hard-coded timeouts
- **Test Isolation**: Independent test execution with cleanup
- **Cross-Browser Support**: Chrome, Firefox, Safari testing
- **Anti-Pattern Prevention**: Built-in gotchas compliance

### 🔄 GitOps Commands

#### `/review-pr`
**Purpose:** Comprehensive pull request analysis and review

**Features:**
- Code quality assessment
- Security vulnerability detection
- Architecture impact analysis
- Test coverage evaluation

#### `/resolve-review-comment`
**Purpose:** Address specific pull request review comments

**Features:**
- Targeted code fixes
- Explanation of changes
- Verification of resolution

### 💻 User Experience Commands

#### `/review-user-interface`
**Purpose:** Analyze and improve user interface designs

**Features:**
- Accessibility compliance checking
- UX best practices validation
- Design system consistency
- Usability recommendations

## 📚 Key Features

### Quality Standards
- **Maximum 500 lines** per source file
- **80% minimum test coverage** across all layers  
- **SOLID principles compliance** with architectural validation
- **Comprehensive documentation** for all public APIs
- **Security-first approach** with vulnerability scanning

### Validation Patterns
```bash
# Universal code quality validation
rg "function.*\{[\s\S]{3000,}" --type typescript  # Function size check
find src -name "*.ts" | while read file; do testfile=$(echo $file | sed 's/src/tests/' | sed 's/\.ts/.test.ts/'); [ ! -f "$testfile" ] && echo "MISSING TEST: $testfile"; done

# Technology-specific validation
npm run lint && npm test && npm run build        # React
dotnet format && dotnet test && dotnet build     # .NET
```

### Best Practices Integration
- **Anti-pattern detection** and prevention
- **Performance optimization** patterns
- **Security vulnerability** scanning and remediation
- **Database optimization** and query analysis
- **DevOps best practices** and CI/CD patterns

## 🤝 Contributing

### Development Workflow
1. Follow existing patterns in the codebase
2. Reference `References/Gotchas/` for technology-specific guidance
3. Use validation commands before committing
4. Ensure comprehensive test coverage

### Adding New Technology Stacks
1. Create configuration in `References/Build/`
2. Add best practices to `References/Gotchas/`
3. Update validation commands
4. Include example implementations

### Custom Command Development
1. Follow patterns in `.claude/commands/`
2. Include comprehensive documentation
3. Provide usage examples
4. Ensure quality validation integration

## 📖 Documentation

### Core Documentation
- **[Context/code-analysis.md](Context/code-analysis.md)** - Generated codebase analysis reports
- **[Context/requirements.md](Context/requirements.md)** - Generated project requirements  
- **[Context/Test/](Context/Test/)** - Generated test workflow specifications

### Command Templates
- **[Templates/analyze_code_base.md](Templates/analyze_code_base.md)** - Codebase analysis template
- **[Templates/automation_test_base.md](Templates/automation_test_base.md)** - Test workflow template
- **[Templates/design_base.md](Templates/design_base.md)** - System design template
- **[Templates/requirement_base.md](Templates/requirement_base.md)** - Requirements template
- **[Templates/task_base.md](Templates/task_base.md)** - Task execution template

### Best Practices Library
- **[References/Gotchas/automation_testing_gotchas.md](References/Gotchas/automation_testing_gotchas.md)** - Critical Playwright patterns and anti-patterns
- **[References/Gotchas/validation_commands.md](References/Gotchas/validation_commands.md)** - Quality validation commands for all stacks
- **[References/Gotchas/architecture_patterns.md](References/Gotchas/architecture_patterns.md)** - System design patterns guide
- **[References/Gotchas/design-principles.md](References/Gotchas/design-principles.md)** - Software design principles
- **[References/Gotchas/anti_patterns.md](References/Gotchas/anti_patterns.md)** - Common anti-patterns to avoid
- **[References/Gotchas/frontend_best_practices.md](References/Gotchas/frontend_best_practices.md)** - Frontend development standards
- **[References/Gotchas/backend_best_practices.md](References/Gotchas/backend_best_practices.md)** - Backend development patterns
- **[References/Gotchas/database_best_practices.md](References/Gotchas/database_best_practices.md)** - Database design and optimization
- **[References/Gotchas/devops_best_practices.md](References/Gotchas/devops_best_practices.md)** - CI/CD and deployment patterns

### Technology Configuration
- **[References/Build/react_config.yaml](References/Build/react_config.yaml)** - React + TypeScript + Vite setup
- **[References/Build/dotnet_config.yaml](References/Build/dotnet_config.yaml)** - .NET Core + Clean Architecture setup

## 🔧 Advanced Usage

### For Enterprise Projects
1. Use Clean Architecture templates for scalable applications
2. Implement comprehensive testing strategies
3. Follow security best practices and compliance requirements
4. Apply performance optimization patterns

### For AI-Assisted Development
1. Leverage custom Claude commands for intelligent assistance
2. Use structured templates for consistent code generation
3. Apply quality validation patterns throughout development
4. Reference best practices for technology-specific guidance

### For Team Collaboration
1. Establish consistent coding standards using validation commands
2. Use templates for consistent project structure
3. Reference gotchas documentation for knowledge sharing
4. Implement quality gates in CI/CD pipelines
