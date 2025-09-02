# Codegen Framework 🚀

A comprehensive, enterprise-grade framework for generating high-quality applications across multiple technology stacks. This repository provides structured templates, best practices, custom Claude Code commands, and quality validation patterns to accelerate development while maintaining professional standards.

## 🎯 What This Project Does

The **Codegen Framework** is a structured approach to code generation that combines:

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
├── 📂 Context/                   # Generated project analysis & specifications
│   ├── 📄 code-analysis.md      # Output from /analyze-codebase
│   ├── 📄 requirements.md       # Output from /generate-requirements
│   └── 📂 Test/                 # Test workflows from /generate-automation-test
├── 📂 References/               # Best practices & configuration libraries
│   ├── 🏗️ Build/               # Technology configurations (react_config.yaml, dotnet_config.yaml)
│   └── ⚠️ Gotchas/             # Comprehensive best practices documentation
│       ├── 📄 automation_testing_gotchas.md    # Critical Playwright patterns
│       ├── 📄 validation_commands.md           # Quality validation commands
│       ├── 📄 architecture_patterns.md         # Design patterns guide
│       └── 📄 [technology]_gotchas.md         # Tech-specific guidelines
├── 📂 Templates/                # Base templates for command outputs
│   ├── 📄 analyze_code_base.md  # Template for codebase analysis
│   ├── 📄 automation_test_base.md # Template for test workflows
│   ├── 📄 design_base.md        # Template for system design
│   ├── 📄 requirement_base.md   # Template for requirements
│   └── 📄 task_base.md          # Template for task execution
└── 📂 test-automation/         # Generated Playwright test suites
    ├── 📂 tests/               # Executable test specifications
    ├── 📂 pages/               # Page Object Model classes
    ├── 📂 data/                # Test data management
    ├── 📂 utils/               # Test utilities and helpers
    └── 📄 playwright.config.ts # Test execution configuration
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
- **Node.js Express** with TypeScript
- **Angular** with Angular CLI
- **Vue 3** with Composition API

## 🧪 Advanced Test Automation

### Complete Test Automation Pipeline
The framework provides end-to-end test automation generation from requirements to executable Playwright scripts:

1. **Requirements Analysis** → Test workflow specifications
2. **Workflow Generation** → Comprehensive test scenarios with validation points
3. **Script Generation** → Production-ready Playwright automation scripts
4. **Best Practices Integration** → Built-in anti-patterns prevention and quality standards

### Test Automation Commands

#### `/generate-automation-test`
**Generate comprehensive test workflows from requirements:**
```bash
# Create test workflows from requirements
/generate-automation-test Context/requirements.md

# Generate workflows for specific features
/generate-automation-test "User Authentication Flow"
```
**Output**: Detailed test workflow specifications in `Context/Test/`

#### `/generate-playwright-scripts`  
**Convert test workflows into executable Playwright scripts:**
```bash
# Auto-discover and process all workflows
/generate-playwright-scripts

# Process specific workflow file
/generate-playwright-scripts Context/Test/test_workflow_login.md
```
**Output**: Complete test automation suite in `test-automation/`

### Test Automation Features

#### 🎯 **Smart Test Generation**
- **Requirements-Driven**: Generate tests directly from user stories and acceptance criteria
- **Use Case Analysis**: Automatic extraction and conversion of use cases to test scenarios
- **Edge Case Coverage**: Comprehensive error scenarios and boundary testing
- **Cross-Browser Support**: Multi-browser test execution strategies

#### ⚡ **Playwright Best Practices Integration**
- **Stable Selectors**: Role-based locators and test-id strategies
- **Proper Wait Strategies**: Web-first assertions, no hard-coded timeouts
- **Test Isolation**: Independent test execution with proper cleanup
- **Page Object Model**: Clean separation of test logic and page interactions

#### 📊 **Quality Standards**
- **Anti-Pattern Prevention**: Built-in gotchas from `References/Gotchas/automation_testing_gotchas.md`
- **Performance Optimization**: Parallel execution and efficient test organization  
- **Error Resilience**: Comprehensive error handling and retry strategies
- **Network Mocking**: Mock external APIs instead of relying on live services

### Generated Test Suite Structure
```
test-automation/
├── tests/                          # Test specification files
│   ├── authentication.spec.ts      # User authentication tests
│   ├── dashboard.spec.ts           # Dashboard functionality tests
│   └── user-management.spec.ts     # User management workflows
├── pages/                          # Page Object Models
│   ├── login.page.ts              # Login page interactions
│   ├── dashboard.page.ts          # Dashboard page interactions
│   └── base.page.ts               # Common page functionality
├── data/                           # Test data management
│   ├── test-users.json            # User test data
│   └── api-responses.json         # Mock API responses
├── utils/                          # Test utilities
│   ├── test-setup.ts              # Common test setup
│   └── helpers.ts                 # Utility functions
├── playwright.config.ts           # Playwright configuration
└── package.json                   # Dependencies and scripts
```

### Test Automation Best Practices

#### ✅ **Selector Strategy Hierarchy**
```typescript
// 1. Role-based locators (Preferred)
page.getByRole('button', { name: 'Submit' })
page.getByRole('textbox', { name: 'Email' })

// 2. Test ID attributes
page.getByTestId('user-menu')

// 3. Semantic locators
page.getByLabel('Email address')
page.getByPlaceholder('Enter your email')
```

#### ✅ **Proper Wait Conditions**
```typescript
// Web-first assertions with automatic waiting
await expect(page.getByText('Success')).toBeVisible({ timeout: 10000 });

// Wait for network requests
await page.waitForResponse(response => response.url().includes('/api/data'));

// Never use arbitrary timeouts
// ❌ await page.waitForTimeout(5000);
```

#### ✅ **Test Isolation**
```typescript
test.beforeEach(async ({ page }) => {
  await page.goto('/login');
  // Fresh state for each test
});

test('should complete user workflow', async ({ page }) => {
  // Each test handles its own setup and validation
  await loginUser(page);
  await navigateToDashboard(page);
  await expect(page.getByRole('heading', { name: 'Dashboard' })).toBeVisible();
});
```

### Key Anti-Patterns Prevention

The framework automatically prevents common automation mistakes:

❌ **Hard-coded waits and timeouts**  
❌ **Fragile CSS selectors and dynamic IDs**  
❌ **Test dependencies and shared state**  
❌ **Testing implementation details vs user behavior**  
❌ **Poor error handling and debugging**

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <repository-url>
cd "Codegen Framework"
```

### 2. Explore Custom Commands
The framework includes specialized Claude Code commands organized by category:

#### 🔍 Discovery & Analysis
```bash
# Analyze existing codebases with comprehensive reverse engineering
/analyze-codebase [repo_url] [analysis_depth] [priority_areas]

# Generate requirements from specifications
/generate-requirements [requirements-source]
```

#### ⚙️ Task Management 
```bash
# Execute tasks systematically with TodoWrite integration
/execute-task [task-file-path]

# Generate structured task plans
/generate-task [task-description]
```

#### 🎨 Design & Architecture
```bash
# Create system designs and architecture diagrams
/generate-design [design-specification]
```

#### 🧪 Test Automation
```bash
# Generate comprehensive test workflows from requirements
/generate-automation-test [requirements-file|use-case|user-story]

# Convert test workflows into executable Playwright scripts
/generate-playwright-scripts [workflow-file-path] # Auto-detects from Context/Test/ if empty
```

#### 🔄 GitOps & Code Review
```bash
# Review pull requests with comprehensive analysis
/review-pr [pr-url|pr-number]

# Resolve specific review comments
/resolve-review-comment [comment-reference]
```

#### 💻 User Experience
```bash
# Review and analyze user interfaces
/review-user-interface [ui-specification|screenshot-path]
```

### 3. Use Technology Templates
Choose from pre-configured templates in `References/Build/`:

- `react_config.yaml` - Modern React setup with TypeScript
- `dotnet_config.yaml` - .NET Core with Clean Architecture

### 4. Follow Best Practices
Reference the comprehensive guides in `References/Gotchas/`:

- Architecture patterns and design principles
- Technology-specific best practices
- Anti-patterns and common pitfalls
- Validation commands and quality gates

## 📋 Example: Creating a New React Application

1. **Use the React Template**:
   ```bash
   # Reference: References/Build/react_config.yaml
   npm create vite@latest my-app -- --template react-ts
   ```

2. **Apply Quality Standards**:
   ```bash
   # Validation commands from References/Gotchas/validation_commands.md
   npm run lint                    # ESLint
   npm run format                  # Prettier  
   npm test                        # Jest + RTL
   npm run build                   # Production build
   ```

3. **Follow Architecture Patterns**:
   - Feature-slice architecture (VSA)
   - CSS Modules for styling
   - Path aliases for clean imports
   - Comprehensive testing strategy

## 📋 Example: Creating a .NET Application

1. **Use the .NET Template**:
   ```bash
   # Reference: References/Build/dotnet_config.yaml
   dotnet new sln -n MyProject
   dotnet new webapi -n MyProject.Api
   ```

2. **Apply Clean Architecture**:
   - Presentation Layer (Web API)
   - Application Layer (Business Logic)
   - Domain Layer (Core Entities)
   - Infrastructure Layer (Data Access)

3. **Validate Quality**:
   ```bash
   dotnet format                   # Code formatting
   dotnet test                     # Run all tests
   dotnet build                    # Compilation check
   ```

## 📋 Example: Complete Test Automation Pipeline

### 1. Generate Test Workflows from Requirements
```bash
# Create comprehensive test workflows from requirements
/generate-automation-test Context/requirements.md

# Or generate workflows for specific features
/generate-automation-test "User Authentication Flow"
```
**Output**: Detailed workflow specifications in `Context/Test/test_workflow_*.md`

### 2. Generate Executable Playwright Scripts  
```bash
# Auto-discover and process all workflow files
/generate-playwright-scripts

# Or process specific workflow
/generate-playwright-scripts Context/Test/test_workflow_login_20241201.md
```
**Output**: Complete automation suite in `test-automation/` directory

### 3. Execute Generated Test Suite
```bash
cd test-automation
npm install                     # Install Playwright dependencies

# Run tests with different modes
npm test                        # Run all tests headlessly
npm run test:headed            # Run with browser UI visible
npm run test:debug             # Interactive debugging mode
npm run test:report            # Generate and show HTML report
```

### 4. Generated Test Suite Features
- **Requirements Traceability**: Tests mapped to user stories and acceptance criteria
- **Stable Test Architecture**: Role-based selectors following `automation_testing_gotchas.md`
- **Cross-Browser Testing**: Chrome, Firefox, Safari compatibility
- **Page Object Model**: Clean separation of test logic and page interactions
- **Comprehensive Reporting**: Screenshots, videos, and detailed test traces
- **Error Resilience**: Built-in retry strategies and proper wait conditions
- **Test Isolation**: Independent test execution with proper setup/cleanup

### 5. Real-World Output Structure
```
test-automation/
├── tests/
│   ├── user-authentication.spec.ts    # Login/logout workflows
│   ├── dashboard-navigation.spec.ts   # Navigation and menu tests  
│   └── form-submission.spec.ts        # Data entry and validation
├── pages/
│   ├── login.page.ts                  # Login page interactions
│   ├── dashboard.page.ts              # Dashboard page methods
│   └── base.page.ts                   # Shared page functionality
├── data/
│   ├── test-users.json               # User account test data
│   └── form-data.json                # Form input test data
├── utils/
│   ├── test-setup.ts                 # Common test configuration
│   └── helpers.ts                    # Utility functions
├── playwright.config.ts              # Browser and execution settings
└── package.json                      # Dependencies and test scripts
```

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

## 📞 Support & Resources

### Getting Help
- Review **[CLAUDE.md](CLAUDE.md)** for Claude Code specific guidance
- Check **[References/Gotchas/troubleshooting_guide.md](References/Gotchas/troubleshooting_guide.md)** for common issues
- Reference technology-specific documentation in **[References/Gotchas/](References/Gotchas/)**

### Key Commands Reference

#### Claude Code Commands
```bash
# Discovery & Analysis
/analyze-codebase                                    # Comprehensive codebase analysis
/generate-requirements Context/specifications.md    # Requirements extraction

# Task Management
/execute-task Context/tasks/feature-implementation.md  # Systematic task execution
/generate-task "Implement user authentication"         # Task planning

# Design & Architecture  
/generate-design Context/system-requirements.md       # System design generation

# Test Automation Pipeline
/generate-automation-test Context/requirements.md     # Create test workflows
/generate-playwright-scripts                          # Generate executable scripts

# Code Review & GitOps
/review-pr https://github.com/org/repo/pull/123      # PR analysis
/resolve-review-comment "Fix null reference issue"   # Address review feedback

# User Experience
/review-user-interface Context/designs/mockup.png   # UI/UX analysis
```

#### Code Quality Validation
```bash
# Universal Quality Commands (from References/Gotchas/validation_commands.md)
rg "pattern" --type typescript    # Use ripgrep for searching
find . -name "*.ts" | xargs wc -l | awk '$1 > 500 {print "VIOLATION: " $2}'

# Technology-Specific Validation
npm run lint && npm test && npm run build     # React/Node.js
dotnet format && dotnet test && dotnet build  # .NET
ruff check . && mypy . && pytest --cov=app   # Python FastAPI
```

#### Test Automation Execution
```bash
# After running /generate-playwright-scripts
cd test-automation
npm install                     # Install dependencies
npm test                        # Run all Playwright tests
npm run test:headed            # Run with browser UI
npm run test:debug             # Debug mode with breakpoints
npm run test:report            # Generate HTML report
```

#### Build & Deploy
```bash
npm run build                   # Frontend production build
dotnet publish -c Release       # .NET production build  
python -m build                 # Python package build
docker build -t myapp .         # Container build
```

---

## 🌟 Why Choose Codegen Framework?

The Codegen Framework isn't just another template collection—it's a comprehensive system designed for professional software development:

- **🎯 Proven Patterns** - Architecture patterns tested in production environments
- **🚀 AI-Enhanced** - Custom Claude commands for intelligent development assistance  
- **📊 Quality-Focused** - Built-in validation and testing ensure professional standards
- **🔧 Multi-Stack** - Support for modern technology stacks and frameworks
- **📚 Knowledge Base** - Extensive documentation covering best practices and gotchas
- **⚡ Rapid Development** - Reduce setup time while maintaining quality and consistency

Start building better applications faster with the Codegen Framework! 🚀