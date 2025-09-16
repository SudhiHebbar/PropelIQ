---
name: GitHub Pull Request Review
description: Perform comprehensive code review for GitHub Pull Requests using generic code-reviewer agent with Context7, sequential-thinking, and Playwright integration. Includes fallback strategies for MCP server failures.
model: inherit
allowed-tools: Task, mcp__github__get_pull_request, mcp__github__get_pull_request_comments, mcp__github__list_commits, mcp__github__get_pull_request_files, mcp__github__get_pull_request_status, Bash, Grep, Read, TodoWrite
argument-hint: <pr_id> [--owner=OWNER] [--repo=REPO] [--depth=comprehensive] [--ui-testing=auto]
---

# GitHub Pull Request Review

As a **Senior Software Architect**, orchestrate comprehensive pull request analysis for GitHub PRs by leveraging the generic code-reviewer agent with advanced MCP integrations.

## Command Parameters

```
/gitops/review-pr [pr_id] [options]

Optional:
  pr_id                   GitHub Pull Request number (if omitted, reviews local changes against main branch)

Options:
  --owner=NAME           Repository owner (default: auto-detect from git remote)
  --repo=NAME            Repository name (default: auto-detect from git remote)
  --base-branch=BRANCH   Base branch for comparison (default: main|master)
  --depth=LEVEL          Analysis depth: quick|standard|comprehensive (default: comprehensive)
  --ui-testing=MODE      UI testing: auto|enabled|disabled (default: auto)
  --focus=AREAS          Comma-separated focus areas (default: all)
                         Options: security,architecture,ui,performance,testing,business-logic
  --local-only           Force local analysis mode (default: auto-detect)
```

## Execution Flow

### Phase 1: Authentication & Mode Detection

```bash
# Check GitHub authentication status
function check_github_auth() {
  echo "🔐 Checking GitHub authentication..."
  
  # Test authentication by checking user status
  if ! gh auth status >/dev/null 2>&1; then
    echo "❌ GitHub CLI not authenticated"
    echo "Please run: gh auth login"
    return 1
  fi
  
  echo "✅ GitHub authentication verified"
  return 0
}

# Determine review mode: PR vs Local
REVIEW_MODE="local"
if [ -n "$ARGUMENTS_PR_ID" ] && [ "$ARGUMENTS_LOCAL_ONLY" != "true" ]; then
  REVIEW_MODE="pr"
  
  # For PR mode, ensure GitHub authentication
  if ! check_github_auth; then
    echo "❌ GitHub authentication required for PR review mode"
    echo "Switching to local review mode..."
    REVIEW_MODE="local"
  fi
fi

# Auto-detect base branch if not specified
BASE_BRANCH="${ARGUMENTS_BASE_BRANCH:-main}"
if ! git show-ref --verify --quiet refs/heads/$BASE_BRANCH; then
  BASE_BRANCH="master"
  if ! git show-ref --verify --quiet refs/heads/$BASE_BRANCH; then
    # Find default branch from remote
    BASE_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  fi
fi

echo "Review Mode: $REVIEW_MODE"
echo "Base Branch: $BASE_BRANCH"
```

### Phase 2: Context Retrieval (PR Mode)

```javascript
let reviewContext = {};

if (reviewMode === "pr") {
  try {
    // Auto-detect owner and repo from git remote if not provided
    const autoDetectOwner = async () => {
      if ($ARGUMENTS.owner) return $ARGUMENTS.owner;
      
      const remoteUrl = await Bash({ 
        command: "git config --get remote.origin.url",
        description: "Get git remote URL"
      });
      
      if (remoteUrl.includes("github.com")) {
        const match = remoteUrl.match(/github\.com[:/]([^/]+)/);
        return match ? match[1] : null;
      }
      return null;
    };

    const autoDetectRepo = async () => {
      if ($ARGUMENTS.repo) return $ARGUMENTS.repo;
      
      const remoteUrl = await Bash({ 
        command: "git config --get remote.origin.url",
        description: "Get git remote URL"
      });
      
      if (remoteUrl.includes("github.com")) {
        const match = remoteUrl.match(/github\.com[:/][^/]+\/([^/.]+)/);
        return match ? match[1] : null;
      }
      return null;
    };

    const owner = await autoDetectOwner();
    const repo = await autoDetectRepo();
    
    if (!owner || !repo) {
      throw new Error("Could not auto-detect repository owner/name from git remote");
    }

    // 1. Primary: Fetch PR details from GitHub MCP
    console.log("📋 Fetching PR details from GitHub...");
    const prDetails = await mcp__github__get_pull_request({
      owner: owner,
      repo: repo,
      pull_number: $ARGUMENTS.pr_id
    });

    reviewContext = {
      mode: "pr",
      prId: $ARGUMENTS.pr_id,
      title: prDetails.title,
      description: prDetails.body || "",
      sourceRef: prDetails.head.ref,
      targetRef: prDetails.base.ref,
      author: prDetails.user,
      state: prDetails.state,
      isDraft: prDetails.draft,
      repository: repo,
      owner: owner
    };

    // Get additional PR context
    reviewContext.existingComments = await mcp__github__get_pull_request_comments({
      owner: owner, repo: repo, pull_number: $ARGUMENTS.pr_id
    });
    
    reviewContext.changedFiles = await mcp__github__get_pull_request_files({
      owner: owner, repo: repo, pull_number: $ARGUMENTS.pr_id
    });
    
    reviewContext.commits = await mcp__github__list_commits({
      owner: owner,
      repo: repo,
      sha: prDetails.head.sha
    });

    // 6. Get CI/CD status
    console.log("🔄 Checking CI/CD status...");
    reviewContext.checks = await mcp__github__get_pull_request_status({
      owner: owner,
      repo: repo,
      pull_number: $ARGUMENTS.pr_id
    });

    console.log("✅ GitHub context retrieved successfully");

  } catch (error) {
    console.error("❌ GitHub MCP failed:", error.message);
    
    // Fallback: Use local git commands for PR analysis  
    console.log("⚠️  Falling back to local git analysis...");
    
    reviewContext = {
      mode: "fallback-local",
      prId: $ARGUMENTS.pr_id,
      title: "PR Review (Fallback Mode)",
      description: "GitHub integration unavailable - using local git analysis",
      sourceRef: await Bash("git rev-parse --abbrev-ref HEAD"),
      targetRef: $ARGUMENTS.base_branch || "main",
      author: await Bash("git config user.name"),
      repository: repo || await Bash("basename $(git rev-parse --show-toplevel)"),
      owner: owner || "local",
      warning: "Limited functionality - GitHub MCP integration unavailable",
      
      // Use git commands for file analysis
      changedFiles: await Bash(`git diff --name-only HEAD~1`).then(files => 
        files.split('\n').filter(f => f.trim()).map(file => ({
          filename: file,
          status: 'modified',
          patch: null // Will analyze files directly
        }))
      ),
      
      commits: await Bash(`git log --oneline -5`).then(logs =>
        logs.split('\n').filter(l => l.trim()).map(line => ({
          sha: line.split(' ')[0],
          message: line.substring(8)
        }))
      )
    };
  }
} else {
  // Local mode setup
  console.log("🏠 Setting up local repository analysis...");
  reviewContext = await setupLocalReviewContext();
}
```

### Phase 3: Local Review Context Setup

```bash
function setupLocalReviewContext() {
  # Get current branch and repository info
  CURRENT_BRANCH=$(git branch --show-current)
  REPO_ROOT=$(git rev-parse --show-toplevel)
  REPO_NAME=$(basename "$REPO_ROOT")
  
  # Auto-detect GitHub repo from remote
  REMOTE_URL=$(git config --get remote.origin.url)
  OWNER=""
  REPO=""
  if [[ "$REMOTE_URL" =~ github.com[:/]([^/]+)/([^/.]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO="${BASH_REMATCH[2]}"
  fi
  
  # Get uncommitted and committed changes
  UNCOMMITTED_CHANGES=$(git status --porcelain)
  COMMITTED_CHANGES=$(git diff --name-only $BASE_BRANCH..HEAD)
  
  # Combine all changes
  ALL_CHANGED_FILES=$(echo -e "$UNCOMMITTED_CHANGES\n$COMMITTED_CHANGES" | \
    awk '{print $NF}' | sort -u | grep -v '^$')
  
  cat << EOF
{
  "mode": "local",
  "currentBranch": "$CURRENT_BRANCH",
  "baseBranch": "$BASE_BRANCH",
  "repository": "$REPO_NAME",
  "owner": "$OWNER",
  "repo": "$REPO",
  "repoRoot": "$REPO_ROOT",
  "changedFiles": $(echo "$ALL_CHANGED_FILES" | jq -R . | jq -s .),
  "uncommittedChanges": $(echo "$UNCOMMITTED_CHANGES" | jq -R . | jq -s .),
  "committedChanges": $(echo "$COMMITTED_CHANGES" | jq -R . | jq -s .),
  "author": "$(git config user.name)",
  "email": "$(git config user.email)",
  "lastCommit": "$(git log -1 --pretty=format:'%H|%s|%an|%ad' --date=iso)"
}
EOF
}
```

### Phase 4: File Change Analysis & Git Diff Generation

```bash
function analyzeFileChanges() {
  if [ "$REVIEW_MODE" = "pr" ]; then
    # PR Mode: Use files from GitHub API
    echo "Analyzing PR files..."
    
    # Extract file names from PR files (assuming they're stored in a temp file)
    CHANGED_FILES=$(echo "$PR_CHANGED_FILES" | jq -r '.[].filename' 2>/dev/null || echo "")
    
    # Generate detailed diff for analysis
    gh pr diff $PR_ID > /tmp/pr-diff-$$.patch || {
      echo "Warning: Could not generate PR diff via gh CLI"
      touch /tmp/pr-diff-$$.patch
    }
    
  else
    # Local Mode: Use current working directory
    cd "$REPO_ROOT"
    
    # Get all changes (staged + unstaged + committed)
    STAGED_FILES=$(git diff --cached --name-only || true)
    UNSTAGED_FILES=$(git diff --name-only || true)
    COMMITTED_FILES=$(git diff --name-only $BASE_BRANCH..HEAD || true)
    
    # Combine all changed files
    CHANGED_FILES=$(echo -e "$STAGED_FILES\n$UNSTAGED_FILES\n$COMMITTED_FILES" | \
      sort -u | grep -v '^$' || true)
    
    # Generate comprehensive diff
    {
      echo "=== STAGED CHANGES ==="
      git diff --cached || true
      echo -e "\n=== UNSTAGED CHANGES ==="
      git diff || true
      echo -e "\n=== COMMITTED CHANGES ==="
      git diff $BASE_BRANCH..HEAD || true
    } > /tmp/local-diff-$$.patch
  fi
  
  # Categorize changes
  FRONTEND_CHANGES=$(echo "$CHANGED_FILES" | grep -E "\.(tsx?|jsx?|css|scss|vue|svelte)$" || true)
  BACKEND_CHANGES=$(echo "$CHANGED_FILES" | grep -E "\.(cs|py|java|go|rb)$" || true)
  CONFIG_CHANGES=$(echo "$CHANGED_FILES" | grep -E "\.(json|yaml|yml|xml|toml)$" || true)
  SQL_CHANGES=$(echo "$CHANGED_FILES" | grep -E "\.(sql|migration)$" || true)
  TEST_CHANGES=$(echo "$CHANGED_FILES" | grep -E "\.(test|spec)\.(tsx?|jsx?|cs|py|java|go|rb)$" || true)
  
  # Output analysis summary
  echo "Changed Files Analysis:"
  echo "- Total files changed: $(echo "$CHANGED_FILES" | wc -l)"
  echo "- Frontend files: $(echo "$FRONTEND_CHANGES" | wc -l)"
  echo "- Backend files: $(echo "$BACKEND_CHANGES" | wc -l)"
  echo "- Config files: $(echo "$CONFIG_CHANGES" | wc -l)"
  echo "- SQL/Migration files: $(echo "$SQL_CHANGES" | wc -l)"
  echo "- Test files: $(echo "$TEST_CHANGES" | wc -l)"
}

# Execute analysis
analyzeFileChanges
```

### Phase 5: Technology Stack Detection

```bash
# Auto-detect technology stack
TECH_STACK=""

# Frontend detection
[ -f "package.json" ] && TECH_STACK="$TECH_STACK,Node.js"
grep -q "\"react\"" package.json 2>/dev/null && TECH_STACK="$TECH_STACK,React"
grep -q "\"@angular/core\"" package.json 2>/dev/null && TECH_STACK="$TECH_STACK,Angular"
grep -q "\"vue\"" package.json 2>/dev/null && TECH_STACK="$TECH_STACK,Vue"

# Backend detection
ls *.csproj >/dev/null 2>&1 && TECH_STACK="$TECH_STACK,.NET"
[ -f "requirements.txt" ] || [ -f "pyproject.toml" ] && TECH_STACK="$TECH_STACK,Python"
[ -f "pom.xml" ] || [ -f "build.gradle" ] && TECH_STACK="$TECH_STACK,Java"
[ -f "go.mod" ] && TECH_STACK="$TECH_STACK,Go"

# Determine if UI testing is needed
UI_TESTING_NEEDED="false"
if [ -n "$FRONTEND_CHANGES" ] && [ "$UI_TESTING" != "disabled" ]; then
  UI_TESTING_NEEDED="true"
fi

echo "Technology Stack Detected: ${TECH_STACK#,}"
echo "UI Testing Needed: $UI_TESTING_NEEDED"
```

### Phase 6: Invoke Code-Reviewer Agent

```javascript
// Prepare comprehensive context for the code-reviewer agent
let agentContext = {
  source: reviewContext.mode === "pr" ? "github" : "local",
  changedFiles: changedFilesList,
  techStack: detectedTechStack,
  analysisConfig: {
    depth: $ARGUMENTS.depth || "comprehensive",
    focus: $ARGUMENTS.focus || "all",
    uiTesting: uiTestingNeeded,
    context7Lookups: 10,
    sequentialDepth: 15,
    timeBudget: 30
  }
};

if (reviewContext.mode === "pr") {
  // PR Mode context
  agentContext = {
    ...agentContext,
    prId: $ARGUMENTS.pr_id,
    repository: reviewContext.repository,
    owner: reviewContext.owner,
    prContext: {
      title: reviewContext.title,
      description: reviewContext.description,
      author: reviewContext.author.login,
      sourceRef: reviewContext.sourceRef,
      targetRef: reviewContext.targetRef,
      state: reviewContext.state,
      isDraft: reviewContext.isDraft,
      checks: reviewContext.checks
    },
    localRepoPath: repoRoot,
    diffFile: `/tmp/pr-diff-$$.patch`
  };
} else {
  // Local Mode context
  agentContext = {
    ...agentContext,
    repository: reviewContext.repository,
    owner: reviewContext.owner,
    localContext: {
      currentBranch: reviewContext.currentBranch,
      baseBranch: reviewContext.baseBranch,
      author: reviewContext.author,
      email: reviewContext.email,
      lastCommit: reviewContext.lastCommit,
      uncommittedChanges: reviewContext.uncommittedChanges,
      committedChanges: reviewContext.committedChanges
    },
    localRepoPath: reviewContext.repoRoot,
    diffFile: `/tmp/local-diff-$$.patch`
  };
}

// Invoke the specialized pr-code-reviewer agent
console.log("🔍 Invoking pr-code-reviewer agent for comprehensive analysis...");
const reviewResults = await Task({
  description: reviewContext.mode === "pr" ? "Deep GitHub PR analysis" : "Local changes analysis",
  prompt: `
    Perform comprehensive code review for ${reviewContext.mode === "pr" ? 'GitHub PR #' + prId : 'local changes against ' + reviewContext.baseBranch}.
    
    Context:
    ${JSON.stringify(agentContext, null, 2)}
    
    Requirements:
    1. Use Context7 to fetch best practices for detected technologies
    2. Use sequential-thinking for complex architectural analysis
    3. ${uiTestingNeeded ? 'Perform UI testing using Playwright MCP for frontend changes' : 'Skip UI testing'}
    4. Focus on: ${$ARGUMENTS.focus || 'security, architecture, UI/UX, performance, testing, business logic'}
    5. ${reviewContext.mode === "local" ? 'Analyze both committed changes against base branch AND uncommitted/staged changes' : ''}
    6. Apply validation commands from References/Gotchas/validation_commands.md
    7. Check against gotchas in References/Gotchas/ for detected technologies
    8. Return structured results in the defined format
    
    ${reviewContext.mode === "local" ? 
      'For local analysis, provide actionable feedback on work-in-progress changes before they are committed or pushed.' : 
      'The review should be thorough and actionable, with clear recommendations for the PR.'}
  `,
  subagent_type: "pr-code-reviewer"
});

console.log("✅ PR-code-reviewer agent analysis completed");
```

### Phase 7: Output Results (Local Only - No PR Posting)

```javascript
// Structure review results for local output
async function outputReviewResults(results) {
  // Ensure output directory exists
  await Bash({
    command: "mkdir -p Context/pr-reviews",
    description: "Create PR reviews output directory"
  });
  
  // Generate timestamp-based filename
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const reportPath = `Context/pr-reviews/pr-review-${timestamp}.md`;
  
  console.log(`\n🔍 ${reviewContext.mode === "pr" ? "GitHub PR" : "Local"} Code Review Completed`);
  console.log(`📊 Analysis Summary:`);
  console.log(`   - Risk Level: ${results.riskLevel}`);
  console.log(`   - Total Issues: ${results.findings.length}`);
  console.log(`   - Critical: ${results.findings.filter(f => f.severity === 'critical').length}`);
  console.log(`   - High: ${results.findings.filter(f => f.severity === 'high').length}`);
  console.log(`   - Medium: ${results.findings.filter(f => f.severity === 'medium').length}`);
  console.log(`   - Low: ${results.findings.filter(f => f.severity === 'low').length}`);
  
  if (results.playwrightTests) {
    console.log(`🎨 UI Testing:`);
    console.log(`   - Screenshots: ${results.playwrightTests.screenshots.length}`);
    console.log(`   - Accessibility Issues: ${results.playwrightTests.a11yIssues.length}`);
    console.log(`   - Performance Issues: ${results.playwrightTests.performanceIssues.length}`);
  }
  
  if (reviewContext.mode === "pr" && reviewContext.checks) {
    console.log(`🔄 CI/CD Status:`);
    console.log(`   - Status: ${reviewContext.checks.state}`);
    console.log(`   - Checks: ${reviewContext.checks.statuses?.length || 0} total`);
  }
  
  console.log(`\n📄 Detailed report saved to: ${reportPath}`);
  
  // Generate detailed markdown report
  const report = generateDetailedReport(results, reviewContext);
  
  // Save detailed report
  await Write({
    file_path: reportPath,
    content: report
  });
  
  // Show top priority items in console
  const criticalIssues = results.findings.filter(f => f.severity === 'critical');
  if (criticalIssues.length > 0) {
    console.log(`\n⚠️  Critical Issues to Address:`);
    criticalIssues.forEach((issue, idx) => {
      console.log(`   ${idx + 1}. ${issue.title} (${issue.file}:${issue.line})`);
    });
  }
  
  const highIssues = results.findings.filter(f => f.severity === 'high').slice(0, 3);
  if (highIssues.length > 0) {
    console.log(`\n🔥 Top High Priority Issues:`);
    highIssues.forEach((issue, idx) => {
      console.log(`   ${idx + 1}. ${issue.title} (${issue.file}:${issue.line})`);
    });
  }

  console.log(`\n💡 Next Steps:`);
  if (reviewContext.mode === "pr") {
    console.log(`   - Review findings in ${reportPath}`);
    console.log(`   - Address critical and high priority issues`);
    console.log(`   - Consider the PR recommendation: ${results.recommendation}`);
  } else {
    console.log(`   - Address findings before committing changes`);
    console.log(`   - Run tests and build after fixes`);
    console.log(`   - Consider creating a PR when ready`);
  }
}

function generateDetailedReport(results, context) {
  const reportDate = new Date().toISOString().split('T')[0];
  
  return `# GitHub ${context.mode === "pr" ? "PR" : "Local"} Review Report

Generated: ${reportDate}

## ${context.mode === "pr" ? "Pull Request" : "Local Changes"}: ${context.mode === "pr" ? context.title : context.currentBranch}
${context.mode === "pr" ? `- **PR ID**: #${context.prId}
- **Author**: ${context.author.login}
- **Source**: ${context.sourceRef}
- **Target**: ${context.targetRef}
- **State**: ${context.state}` : `- **Branch**: ${context.currentBranch}
- **Base**: ${context.baseBranch}
- **Author**: ${context.author}
- **Repository**: ${context.repository}`}

## Executive Summary
${results.executiveSummary}

## Risk Assessment
- **Overall Risk**: ${results.riskLevel}
- **Recommendation**: ${results.recommendation}
- **Estimated Fix Time**: ${results.estimatedFixTime}

## Detailed Findings

### 🔒 Security (${results.security?.length || 0} issues)
${formatSecurityFindings(results.security)}

### 🏗 Architecture & Design (${results.architecture?.length || 0} issues)
${formatArchitectureFindings(results.architecture)}

### 🎨 UI/Frontend (${results.ui?.length || 0} issues)
${formatUIFindings(results.ui)}
${results.playwrightTests ? formatPlaywrightResults(results.playwrightTests) : ''}

### ⚡ Performance (${results.performance?.length || 0} issues)
${formatPerformanceFindings(results.performance)}

### ✅ Testing Requirements
${formatTestingRequirements(results.testing)}

### 💼 Business Logic
${formatBusinessLogicAnalysis(results.businessLogic)}

## Context7 Insights
${formatContext7Recommendations(results.context7Insights)}

## Sequential Analysis
${formatSequentialThinkingInsights(results.sequentialAnalysis)}

## Action Items
${formatActionItems(results.actionItems)}

${context.mode === "pr" && context.checks ? `## CI/CD Status
${formatCIStatus(context.checks)}` : ''}

---
*Review completed using GitHub MCP integration with Context7, Sequential-thinking, and Playwright MCP capabilities*
`;
}

// Execute the review output
await outputReviewResults(reviewResults);
```

### Phase 8: Error Handling & Cleanup

```javascript
try {
  // Main execution flow
  await executeReviewFlow();
} catch (error) {
  console.error(`❌ Review failed: ${error.message}`);
  
  if (error.type === 'AGENT_TIMEOUT') {
    console.log("⏱️  Analysis timed out. Attempting quick analysis...");
    await performQuickAnalysis();
  } else if (error.type === 'MCP_CONNECTION_ERROR') {
    console.log("🔌 MCP connection failed. Falling back to local analysis...");
    await performLocalAnalysis();
  } else if (error.type === 'GITHUB_API_ERROR') {
    console.log("🐙 GitHub API error. Retrying...");
    await retryWithBackoff();
  }
  
  // Always provide some feedback
  await outputErrorSummary(error);
} finally {
  // Cleanup temporary files
  await Bash({
    command: "rm -f /tmp/pr-diff-$$.patch /tmp/local-diff-$$.patch",
    description: "Clean up temporary diff files"
  });
}

async function performQuickAnalysis() {
  // Fallback to basic linting and quick checks
  console.log("🚀 Performing quick analysis...");
  
  try {
    await Bash({
      command: "npm run lint",
      description: "Run linting checks"
    });
  } catch (e) {
    console.log("⚠️  Linting issues found");
  }
  
  try {
    await Bash({
      command: "npm test",
      description: "Run tests"
    });
  } catch (e) {
    console.log("⚠️  Test failures found");
  }
}

async function outputErrorSummary(error) {
  // Ensure output directory exists
  await Bash({
    command: "mkdir -p Context/pr-reviews",
    description: "Create PR reviews output directory"
  });
  
  // Generate timestamp-based error report filename
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const errorReportPath = `Context/pr-reviews/pr-review-error-${timestamp}.md`;
  
  const errorReport = `# Review Error Report

Error: ${error.message}
Time: ${new Date().toISOString()}
Mode: ${reviewContext.mode}

Please check:
- GitHub authentication: \`gh auth status\`
- Repository permissions
- Network connectivity
- MCP server status

Try running with --local-only for offline analysis.
`;

  await Write({
    file_path: errorReportPath,
    content: errorReport
  });
  
  console.log(`📄 Error details saved to ${errorReportPath}`);
}
```

## Advanced Features

### 1. Smart Focus Detection
Automatically adjusts review focus based on:
- File changes pattern (frontend vs backend)
- Commit message patterns
- PR title and description keywords
- Previous review feedback patterns

### 2. Incremental Review
For updated PRs:
- Compare with previous review results
- Focus on newly changed files since last review
- Track resolved vs new issues

### 3. Integration Points

#### GitHub Actions Integration
```yaml
# .github/workflows/ai-review.yml
name: AI Code Review
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  ai-review:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Run AI Review
      run: |
        claude-cli /gitops/review-pr ${{ github.event.pull_request.number }} \
          --owner=${{ github.repository_owner }} \
          --repo=${{ github.event.repository.name }} \
          --depth=comprehensive
```

### 4. Performance Optimization

1. **Parallel Execution**: Run Context7 lookups concurrently with file analysis
2. **Caching**: Store technology detection results between runs
3. **Incremental Analysis**: Only analyze changed files
4. **Time Boxing**: Enforce time limits per analysis phase
5. **Resource Management**: Clean up temporary files and close connections

## Error Handling

The command includes comprehensive error handling for:
- GitHub API rate limits and permissions
- Authentication failures
- Network connectivity issues
- Large repository timeouts
- MCP server connection failures

All errors are logged with actionable remediation steps, and the system gracefully falls back to local analysis when possible.

---

*This command orchestrates comprehensive PR review by leveraging the generic code-reviewer agent with GitHub native integration, providing deep, actionable insights for code quality improvement without posting findings back to the PR.*