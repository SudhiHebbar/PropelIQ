# PropelIQ Template Configuration

This file documents the template repository setup for PropelIQ.

## Template Repository Status

This repository is configured as a GitHub template repository, enabling the "Use this template" button functionality.

### Features Included

✅ **GitHub Template Configuration**
- Issue templates for bugs and features
- Pull request template
- Contributing guidelines
- Template usage guide

✅ **Project Structure**
- Complete PropelIQ framework structure
- AI agents and commands
- Best practices documentation
- Output templates

✅ **Environment Setup**
- Environment variables template (`.env.example`)
- MCP server configuration (`.mcp.json`)
- Technology stack configurations

✅ **Documentation**
- Comprehensive README with template instructions
- Setup guides for different technology stacks
- Best practices and gotchas

### How to Use This Template

1. **For Repository Owners (Enabling Template):**
   - Go to Repository Settings → Template repository
   - Check "Template repository" 
   - The "Use this template" button will appear

2. **For Users (Creating from Template):**
   - Click "Use this template" button
   - Create new repository
   - Follow the [Template Guide](./.github/TEMPLATE_GUIDE.md)

### Template Maintenance

When updating this template repository:

1. **Test Template Creation:**
   ```bash
   # Create test repository from template
   # Verify all files are copied correctly
   # Test setup process end-to-end
   ```

2. **Update Template Guide:**
   - Keep `.github/TEMPLATE_GUIDE.md` current
   - Update environment variable examples
   - Verify all links and references

3. **Version Template Files:**
   - Update configuration files for new dependencies
   - Refresh best practices documentation
   - Test with latest Claude Code versions

### Files Specific to Template Setup

```
.github/
├── ISSUE_TEMPLATE/
│   ├── config.yml           # Issue template configuration
│   ├── bug_report.md        # Bug report template
│   └── feature_request.md   # Feature request template
├── CONTRIBUTING.md          # Contribution guidelines
├── TEMPLATE_GUIDE.md        # Template usage guide
└── pull_request_template.md # PR template

.env.example                 # Environment variables template
TEMPLATE_CONFIG.md          # This file
```

### Customization for Template Users

Template users should:

1. **Replace template content:**
   - Update README.md with project-specific information
   - Modify .env.example with project variables
   - Customize References/Gotchas/ for their tech stack

2. **Add project-specific content:**
   - Source code directories
   - Project documentation
   - CI/CD configurations
   - Deployment scripts

3. **Configure integrations:**
   - Set up MCP servers with actual API keys
   - Configure GitHub integrations
   - Set up project-specific tooling

### Template Repository Best Practices

- Keep the template generic and customizable
- Provide comprehensive documentation
- Include practical examples
- Maintain backward compatibility
- Test template creation process regularly

---

For questions about template setup, see the [Contributing Guide](./.github/CONTRIBUTING.md) or create an issue.