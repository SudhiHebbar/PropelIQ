# Contributing to PropelIQ

Thank you for your interest in contributing to PropelIQ! This document provides guidelines for contributing to the framework.

## 🚀 Ways to Contribute

### 1. Using PropelIQ as a Template
If you're using PropelIQ as a template for your project:
1. Click the **"Use this template"** button on GitHub
2. Create your new repository
3. Follow the [Quick Start Guide](./README.md#-quick-start)
4. Customize the framework for your needs

### 2. Contributing to the Framework
- **Bug Reports**: Use our [bug report template](./.github/ISSUE_TEMPLATE/bug_report.md)
- **Feature Requests**: Use our [feature request template](./.github/ISSUE_TEMPLATE/feature_request.md)
- **Documentation**: Improve guides and examples
- **Best Practices**: Add new gotchas and patterns to `References/Gotchas/`
- **Templates**: Enhance output templates in `References/Templates/`

## 🛠️ Development Setup

### Prerequisites
- Claude Code (latest version)
- Node.js 18.x or higher
- Git 2.25 or higher

### Local Development
1. Fork the repository
2. Clone your fork
3. Set up MCP servers following the [Quick Start Guide](./README.md#-quick-start)
4. Test your changes with real projects

## 📝 Code Standards

### File Structure
- Follow the existing directory structure
- Place best practices in `References/Gotchas/`
- Add templates to `References/Templates/`
- Document new commands in `.claude/commands/`

### Documentation Standards
- Use clear, concise language
- Include practical examples
- Follow existing markdown formatting
- Test all code examples

### Command Development
- Follow patterns in existing commands
- Include comprehensive error handling
- Add usage examples
- Update documentation

## 🧪 Testing Changes

### Template Testing
1. Create a test repository using the template
2. Follow the complete setup process
3. Test key workflows:
   - `/generate-requirements`
   - `/generate-task`
   - `/execute-task`
   - `/generate-automation-test`

### Framework Testing
1. Test with multiple technology stacks
2. Verify MCP server integration
3. Validate output templates
4. Check error handling

## 📋 Pull Request Process

1. **Fork & Branch**: Create a feature branch from `main`
2. **Make Changes**: Follow our coding standards
3. **Test Thoroughly**: Verify changes work as expected
4. **Update Documentation**: Include relevant documentation updates
5. **Submit PR**: Use a clear title and description

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Template enhancement
- [ ] Best practice addition

## Testing
- [ ] Tested with multiple tech stacks
- [ ] Verified template creation process
- [ ] Validated command functionality
- [ ] Updated documentation

## Checklist
- [ ] Code follows project standards
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] No breaking changes (or clearly documented)
```

## 🎯 Areas for Contribution

### High Priority
- **Technology Stack Support**: Add new frameworks and languages
- **Best Practices**: Expand the `References/Gotchas/` collection
- **Templates**: Improve output quality and consistency
- **Examples**: Add real-world use cases and scenarios

### Documentation Needs
- **Video Tutorials**: Setup and workflow demonstrations
- **Integration Guides**: IDE and tool integrations
- **Case Studies**: Real project implementations
- **Troubleshooting**: Common issues and solutions

### Feature Requests
- **New Commands**: Additional workflow automation
- **AI Agents**: Specialized agents for specific domains
- **MCP Integrations**: Additional service integrations
- **Quality Tools**: Enhanced analysis and validation

## 🏷️ Labels and Issues

### Issue Labels
- `bug`: Something isn't working
- `enhancement`: New feature or request
- `documentation`: Improvements to docs
- `good first issue`: Good for newcomers
- `help wanted`: Extra attention is needed
- `template`: Related to template repository setup

## 📞 Getting Help

- **Documentation**: Check the [README](./README.md) first
- **Discussions**: Use GitHub Discussions for questions
- **Issues**: Create an issue for bugs or feature requests

## 🤝 Community Guidelines

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow
- Focus on the project's goals
- Follow GitHub's community guidelines

## 📄 License

By contributing to PropelIQ, you agree that your contributions will be licensed under the MIT License.

---

Thank you for helping make PropelIQ better! 🚀