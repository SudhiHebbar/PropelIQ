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
│   ├── 🔍 discovery/            # Codebase analysis & requirements
│   ├── ⚙️ task/                 # Task execution & management  
│   ├── 🎨 design/               # System design & architecture
│   ├── 🧪 test/                 # Advanced Playwright automation & validation
│   ├── 🔄 gitops/               # Git operations & PR reviews
│   └── 💻 ux/                   # User experience & interface
├── 📂 Context/                   # Project requirements & specifications
├── 📂 References/               # Best practices & configuration templates
│   ├── 🏗️ Build/               # Technology stack configurations
│   ├── ⚠️ Gotchas/             # Best practices & anti-patterns
│   └── 🎨 Figma/               # Design system references
├── 📂 Templates/                # Base templates for analysis & automation
└── 📂 test-automation/         # Playwright test frameworks & automation utilities
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
The framework includes specialized Claude Code commands:

```bash
# Analyze existing codebases
/analyze-codebase

# Execute tasks systematically  
/execute-task <task-file>

# Generate requirements from specifications
/generate-requirements

# Create system designs and architecture
/generate-design

# Generate comprehensive test automation
/generate-automation-test
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

## 📋 Example: Creating Complete Test Automation

1. **Generate Test Workflows from Requirements**:
   ```bash
   /generate-automation-test Context/requirements.md
   ```

2. **Generate Executable Playwright Scripts**:
   ```bash
   /generate-playwright-scripts
   ```

3. **Run Generated Tests**:
   ```bash
   cd test-automation
   npm install
   npm test                        # Run all tests
   npm run test:headed            # Run with browser UI
   npm run test:debug             # Debug mode
   ```

4. **Test Suite Output**:
   - **Complete test coverage** from user stories to executable scripts
   - **Cross-browser compatibility** testing
   - **Stable selectors** using role-based locators
   - **Comprehensive reporting** with screenshots and traces

## 🎯 Custom Claude Commands

### `/analyze-codebase`
Comprehensive codebase analysis with:
- Architecture discovery and documentation
- Security vulnerability assessment  
- Performance bottleneck identification
- Code quality metrics and recommendations

### `/execute-task`  
Systematic task execution featuring:
- TodoWrite integration for progress tracking
- Quality validation at each step
- Technology-specific validation patterns
- Comprehensive error handling and rollback

### `/generate-requirements`
Requirements analysis and documentation:
- User story generation with acceptance criteria
- Use case analysis with Mermaid diagrams
- Actor identification and system boundaries
- Business rule extraction and validation

### `/generate-automation-test`
Advanced test automation workflow generation:
- Requirements-driven test scenario creation
- Complete user workflow mapping with validation points
- Edge case and error scenario coverage
- Test data planning and management strategies
- Integration with `/generate-playwright-scripts` for full automation pipeline

### `/generate-playwright-scripts`
Production-ready Playwright automation generation:
- Executable TypeScript test scripts with proper wait strategies
- Page Object Model implementation with stable selectors
- Cross-browser test configuration and parallel execution
- Comprehensive error handling and retry strategies
- Built-in best practices and anti-pattern prevention

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
- **[CLAUDE.md](CLAUDE.md)** - Claude Code integration guide
- **[Context/requirements.md](Context/requirements.md)** - Project requirements specification
- **[References/Gotchas/](References/Gotchas/)** - Comprehensive best practices library

### Technology-Specific Guides
- **[Frontend Best Practices](References/Gotchas/frontend_best_practices.md)**
- **[Backend Best Practices](References/Gotchas/backend_best_practices.md)**
- **[Database Best Practices](References/Gotchas/database_best_practices.md)**
- **[DevOps Best Practices](References/Gotchas/devops_best_practices.md)**
- **[Automation Testing Gotchas](References/Gotchas/automation_testing_gotchas.md)** - Critical Playwright patterns and anti-patterns

### Architecture & Design
- **[Architecture Patterns](References/Gotchas/architecture_patterns.md)**
- **[Design Principles](References/Gotchas/design-principles.md)**  
- **[Anti-Patterns](References/Gotchas/anti_patterns.md)**

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
```bash
# Code Quality Validation
npm run lint                    # Frontend linting
dotnet format                   # .NET formatting  
rg "pattern" --type typescript  # Use ripgrep instead of grep

# Testing
npm test                        # Frontend testing
dotnet test                     # .NET testing
pytest --cov=app              # Python testing

# Build & Deploy
npm run build                   # Frontend build
dotnet publish -c Release       # .NET production build

# Test Automation
/generate-automation-test       # Create test workflows from requirements
/generate-playwright-scripts    # Generate executable Playwright scripts
npm test                        # Run Playwright tests
npm run test:headed            # Run tests with browser UI
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