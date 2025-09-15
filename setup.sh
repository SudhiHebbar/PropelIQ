#!/bin/bash

# PropelIQ Template Setup Script
# This script helps you set up PropelIQ framework in your new project

set -e  # Exit on any error

echo "🚀 PropelIQ Template Setup"
echo "=========================="
echo ""

# Check if we're in the right directory
if [ ! -f ".mcp.json" ]; then
    echo "❌ Error: This doesn't appear to be a PropelIQ repository."
    echo "   Make sure you're in the root directory of your PropelIQ project."
    exit 1
fi

echo "✅ PropelIQ repository detected"

# Check for required tools
echo ""
echo "🔍 Checking prerequisites..."

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo "❌ Claude Code is not installed or not in PATH"
    echo "   Please install Claude Code from: https://www.anthropic.com/claude-code"
    exit 1
fi
echo "✅ Claude Code found"

# Check for Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed"
    echo "   Please install Node.js 18.x or higher from: https://nodejs.org"
    exit 1
fi

NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "❌ Node.js version $NODE_VERSION is too old"
    echo "   Please upgrade to Node.js 18.x or higher"
    exit 1
fi
echo "✅ Node.js $(node --version) found"

# Check for Git
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed"
    echo "   Please install Git from: https://git-scm.com"
    exit 1
fi
echo "✅ Git found"

# Environment setup
echo ""
echo "⚙️  Setting up environment..."

if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo "✅ Created .env file from template"
        echo "   📝 Please edit .env file with your API keys before continuing"
    else
        echo "❌ No .env.example file found"
    fi
else
    echo "✅ .env file already exists"
fi

# Check for required environment variables
if [ -f ".env" ]; then
    source .env
    
    if [ -z "$CONTEXT7_API_KEY" ] || [ "$CONTEXT7_API_KEY" = "your-context7-api-key-here" ]; then
        echo "⚠️  Warning: CONTEXT7_API_KEY not set in .env"
        echo "   You'll need to get an API key from: https://context7.com"
    else
        echo "✅ CONTEXT7_API_KEY configured"
    fi
fi

# MCP Server Setup
echo ""
echo "🔌 Setting up MCP servers..."

echo "Installing core MCP servers..."

# Core servers
if [ -n "$CONTEXT7_API_KEY" ] && [ "$CONTEXT7_API_KEY" != "your-context7-api-key-here" ]; then
    claude mcp add context7 http https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY=${CONTEXT7_API_KEY}" --scope project
    echo "✅ Context7 MCP server installed"
else
    echo "⚠️  Skipping Context7 - API key not configured"
fi

claude mcp add sequential-thinking stdio npx @modelcontextprotocol/server-sequential-thinking --scope project
echo "✅ Sequential-thinking MCP server installed"

# Optional servers
echo ""
echo "Installing optional MCP servers..."

claude mcp add playwright stdio npx @playwright/mcp@latest --scope project
echo "✅ Playwright MCP server installed"

if [ -n "$GITHUB_PAT" ] && [ "$GITHUB_PAT" != "your-github-personal-access-token" ]; then
    claude mcp add github stdio npx -y @modelcontextprotocol/server-github@latest --env "GITHUB_PERSONAL_ACCESS_TOKEN=${GITHUB_PAT}" --scope project
    echo "✅ GitHub MCP server installed"
else
    echo "⚠️  Skipping GitHub MCP - token not configured"
fi

if [ -n "$AZ_DEVOPS_ORG" ] && [ "$AZ_DEVOPS_ORG" != "your-azure-devops-organization" ]; then
    claude mcp add azure-devops stdio npx -y @azure-devops/mcp ${AZ_DEVOPS_ORG} --scope project
    echo "✅ Azure DevOps MCP server installed"
else
    echo "⚠️  Skipping Azure DevOps MCP - organization not configured"
fi

claude mcp add shadcn stdio npx shadcn@latest mcp --scope project
echo "✅ shadcn MCP server installed"

# Verification
echo ""
echo "🧪 Verifying setup..."

echo "Listing installed MCP servers:"
claude mcp list

echo ""
echo "🎉 Setup Complete!"
echo ""
echo "Next steps:"
echo "1. Edit your .env file with actual API keys"
echo "2. Restart Claude Code to activate MCP servers"
echo "3. Try your first command: /generate-requirements \"Your project description\""
echo ""
echo "📚 Documentation:"
echo "   - Template Guide: .github/TEMPLATE_GUIDE.md"
echo "   - Framework Usage: README.md"
echo "   - Best Practices: References/Gotchas/"
echo ""
echo "Happy coding with PropelIQ! 🚀"