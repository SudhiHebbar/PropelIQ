# Using PropelIQ Template

This guide explains how to use PropelIQ as a template for your new project.

## 🚀 Getting Started with the Template

### 1. Create Your Repository from Template

1. **Click "Use this template"** button on the [PropelIQ repository](https://github.com/SudhiHebbar/PropelIQ)
2. **Choose repository settings:**
   - Repository name (e.g., `my-awesome-project`)
   - Description of your project
   - Public or Private visibility
   - Check "Include all branches" if you want development branches

3. **Create repository** - GitHub will copy all files to your new repository

### 2. Initial Setup

After creating your repository from the template:

```bash
# Clone your new repository
git clone https://github.com/your-username/your-repository-name
cd your-repository-name

# Set up environment variables
cp .env.example .env  # If exists
# Edit .env with your specific values
```

### 3. Customize the Framework

#### Update Project Information
```bash
# Update package.json (if exists)
# Update README.md with your project details
# Modify .mcp.json with your specific settings
```

#### Configure for Your Technology Stack
```bash
# Navigate to References/Build/ for technology-specific configs
ls References/Build/
# Customize the configuration files for your chosen stack
```

### 4. Install MCP Servers

Follow the setup guide for your specific needs:

```bash
# Core servers (required)
claude mcp add context7 http https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY=${CONTEXT7_API_KEY}" --scope project
claude mcp add sequential-thinking stdio npx @modelcontextprotocol/server-sequential-thinking --scope project

# Additional servers based on your needs
claude mcp add playwright stdio npx @playwright/mcp@latest --scope project
claude mcp add github stdio npx -y @modelcontextprotocol/server-github@latest --env "GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PAT}" --scope project
```

### 5. First Workflow Test

Test the framework with a simple workflow:

```bash
# Generate requirements for your project
/generate-requirements "Your project description here"

# Generate initial tasks
/generate-task Context/Docs/Spec.md

# Start development
/execute-task Context/Tasks/your-task.md
```

## 🔧 Customization Guide

### Project Structure Customization

```
your-project/
├── .claude/                  # Keep - AI configuration
├── References/               # Customize - Update best practices
│   ├── Gotchas/             # Add your tech stack specific gotchas
│   └── Templates/           # Modify output templates
├── Context/                 # Generated content - will be populated
├── your-source-code/        # Add - Your actual project code
├── docs/                    # Add - Project documentation
└── tests/                   # Add - Your test suites
```

### Configuration Files to Update

1. **`.mcp.json`** - Update MCP server configurations
2. **`README.md`** - Replace with your project description
3. **`References/Gotchas/`** - Add technology-specific best practices
4. **`References/Templates/`** - Customize output templates
5. **`.gitignore`** - Add project-specific ignore patterns

### Environment Variables

Create a `.env` file with your specific keys:
```bash
# Core APIs
CONTEXT7_API_KEY=your-context7-api-key

# Platform Integration
GITHUB_PAT=your-github-token
AZ_DEVOPS_ORG=your-azure-devops-org

# Project-specific variables
DATABASE_URL=your-database-url
API_BASE_URL=your-api-url
```

## 🎯 Common Use Cases

### 1. Green-field Web Application
```bash
# Set up for React/Node.js
cp References/Build/react_config.yaml .
cp References/Build/node_config.yaml .

# Generate requirements
/generate-requirements "E-commerce platform with user authentication"

# Follow the development workflow
/generate-design Context/Docs/Spec.md
/generate-task Context/Docs/Spec.md
/execute-task Context/Tasks/frontend-setup.md
```

### 2. Enterprise Dashboard
```bash
# Use MVP builder for rapid prototyping
@mvp-builder "Analytics dashboard with role-based access"

# Generate comprehensive requirements
/generate-requirements Context/Docs/mvp-scope.md

# Continue with full development cycle
```

### 3. Microservices Architecture
```bash
# Set up for .NET/Python
cp References/Build/dotnet_config.yaml .

# Generate service-specific requirements
/generate-requirements "User service for microservices architecture"
/generate-requirements "Product service for microservices architecture"
```

## 🧪 Testing Your Setup

### Verify Installation
```bash
# Test MCP server connections
claude mcp list

# Test framework commands
/help
```

### Run Sample Workflows
```bash
# Test requirement generation
/generate-requirements "Simple todo application"

# Test task generation
/generate-task Context/Docs/Spec.md

# Test automation testing
/generate-automation-test Context/Docs/Spec.md
```

## 🚨 Troubleshooting

### Common Issues

1. **MCP Server Connection Failed**
   ```bash
   # Check environment variables
   echo $CONTEXT7_API_KEY
   echo $GITHUB_PAT
   
   # Restart Claude Code
   # Reinstall MCP servers
   ```

2. **Command Not Found**
   ```bash
   # Verify .claude/commands/ directory exists
   ls .claude/commands/
   
   # Check MCP server status
   claude mcp list
   ```

3. **Template Generation Issues**
   ```bash
   # Verify References/Templates/ directory
   ls References/Templates/
   
   # Check file permissions
   chmod +r References/Templates/*.md
   ```

### Getting Help

- Check the [main README](../README.md) for detailed documentation
- Review [best practices](../References/Gotchas/) for your technology stack
- Create an issue if you encounter bugs
- Use GitHub Discussions for questions

## 📈 Next Steps

1. **Customize for Your Stack**: Update configurations and best practices
2. **Add Project Code**: Create your source code directories
3. **Set Up CI/CD**: Add GitHub Actions or Azure DevOps pipelines
4. **Document Your Project**: Update README with project-specific information
5. **Share Your Experience**: Contribute back to the PropelIQ community

---

Happy coding with PropelIQ! 🚀