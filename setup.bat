@echo off
setlocal enabledelayedexpansion

REM PropelIQ Template Setup Script for Windows
REM This script helps you set up PropelIQ framework in your new project

echo 🚀 PropelIQ Template Setup
echo ==========================
echo.

REM Check if we're in the right directory
if not exist ".mcp.json" (
    echo ❌ Error: This doesn't appear to be a PropelIQ repository.
    echo    Make sure you're in the root directory of your PropelIQ project.
    pause
    exit /b 1
)

echo ✅ PropelIQ repository detected

REM Check for required tools
echo.
echo 🔍 Checking prerequisites...

REM Check for Claude Code
claude --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Claude Code is not installed or not in PATH
    echo    Please install Claude Code from: https://www.anthropic.com/claude-code
    pause
    exit /b 1
)
echo ✅ Claude Code found

REM Check for Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed
    echo    Please install Node.js 18.x or higher from: https://nodejs.org
    pause
    exit /b 1
)

for /f "tokens=1 delims=v" %%a in ('node --version') do set NODE_VERSION=%%a
set NODE_MAJOR=%NODE_VERSION:~1,2%
if %NODE_MAJOR% lss 18 (
    echo ❌ Node.js version %NODE_VERSION% is too old
    echo    Please upgrade to Node.js 18.x or higher
    pause
    exit /b 1
)
echo ✅ Node.js found

REM Check for Git
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git is not installed
    echo    Please install Git from: https://git-scm.com
    pause
    exit /b 1
)
echo ✅ Git found

REM Environment setup
echo.
echo ⚙️  Setting up environment...

if not exist ".env" (
    if exist ".env.example" (
        copy ".env.example" ".env" >nul
        echo ✅ Created .env file from template
        echo    📝 Please edit .env file with your API keys before continuing
    ) else (
        echo ❌ No .env.example file found
    )
) else (
    echo ✅ .env file already exists
)

REM MCP Server Setup
echo.
echo 🔌 Setting up MCP servers...

echo Installing core MCP servers...

REM Core servers
claude mcp add sequential-thinking stdio npx @modelcontextprotocol/server-sequential-thinking --scope project
echo ✅ Sequential-thinking MCP server installed

REM Optional servers
echo.
echo Installing optional MCP servers...

claude mcp add playwright stdio npx @playwright/mcp@latest --scope project
echo ✅ Playwright MCP server installed

claude mcp add shadcn stdio npx shadcn@latest mcp --scope project
echo ✅ shadcn MCP server installed

echo.
echo ⚠️  To complete setup:
echo 1. Edit your .env file with actual API keys
echo 2. Run these commands manually with your API keys:
echo.
echo    claude mcp add context7 http https://mcp.context7.com/mcp --header "CONTEXT7_API_KEY=your-key" --scope project
echo    claude mcp add github stdio npx -y @modelcontextprotocol/server-github@latest --env "GITHUB_PERSONAL_ACCESS_TOKEN=your-token" --scope project
echo    claude mcp add azure-devops stdio npx -y @azure-devops/mcp your-org --scope project
echo.

REM Verification
echo 🧪 Verifying setup...
claude mcp list

echo.
echo 🎉 Setup Complete!
echo.
echo Next steps:
echo 1. Edit your .env file with actual API keys
echo 2. Run the MCP server commands above with your credentials
echo 3. Restart Claude Code to activate MCP servers
echo 4. Try your first command: /generate-requirements "Your project description"
echo.
echo 📚 Documentation:
echo    - Template Guide: .github\TEMPLATE_GUIDE.md
echo    - Framework Usage: README.md
echo    - Best Practices: References\Gotchas\
echo.
echo Happy coding with PropelIQ! 🚀
pause