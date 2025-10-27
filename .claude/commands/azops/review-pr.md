---
name: Azure DevOps Pull Request Review
description: Perform comprehensive code review for Azure DevOps Pull Requests using generic code-reviewer agent with Context7, sequential-thinking, and Playwright integration. Includes fallback strategies for MCP server failures.
model: inherit
allowed-tools: Task, mcp__azure-devops__repo_get_pull_request_by_id, mcp__azure-devops__repo_list_pull_request_threads, mcp__azure-devops__repo_create_pull_request_thread, mcp__azure-devops__repo_reply_to_comment, mcp__azure-devops__repo_list_pull_requests_by_repo, mcp__azure-devops__repo_get_branch_by_name, mcp__azure-devops__repo_search_commits, mcp__azure-devops__search_code, mcp__azure-devops__build_get_builds, mcp__azure-devops__build_get_log, Bash, Grep, Read, TodoWrite
argument-hint: <pr_id> [--project=PROJECT] [--repository=REPO] [--depth=comprehensive] [--ui-testing=auto]
---

# Azure DevOps Pull Request Review

As a **Senior Software Architect**, orchestrate comprehensive pull request analysis for Azure DevOps PRs by leveraging the generic code-reviewer agent with advanced MCP integrations.

## Command Parameters

```
/azops/review-pr [pr_id] [options]

Optional:
  pr_id                    Azure DevOps Pull Request ID (if omitted, reviews local changes against main branch)

Options:
  --project=NAME          Azure DevOps project name (default: auto-detect from context)
  --repository=NAME       Repository name (default: auto-detect from PR or git remote)
  --base-branch=BRANCH    Base branch for comparison (default: main|master)
  --depth=LEVEL          Analysis depth: quick|standard|comprehensive (default: comprehensive)
  --ui-testing=MODE      UI testing: auto|enabled|disabled (default: auto)
  --post-comments=BOOL   Post review comments to PR (default: true for PR, false for local)
  --focus=AREAS          Comma-separated focus areas (default: all)
                         Options: security,architecture,ui,performance,testing,business-logic
  --local-only           Force local analysis mode (default: auto-detect)
```

## Execution Flow

### Phase 1: Authentication & Mode Detection

```bash
# Check Azure DevOps authentication status
function check_azure_devops_auth() {
  echo "🔐 Checking Azure DevOps authentication..."
  
  # Test authentication by making a simple API call
  if ! az account show >/dev/null 2>&1; then
    echo "❌ Azure CLI not authenticated"
    echo "Please run: az login"
    return 1
  fi
  
  # Check if Azure DevOps extension is installed and authenticated
  if ! az devops project list >/dev/null 2>&1; then
    echo "⚠️  Azure DevOps authentication required"
    echo "Please authenticate with Azure DevOps:"
    echo "1. Set your organization: az devops configure --defaults organization=https://dev.azure.com/YourOrg"
    echo "2. Login to Azure DevOps: az devops login"
    echo ""
    echo "Or set a Personal Access Token:"
    echo "export AZURE_DEVOPS_EXT_PAT=your_pat_token"
    return 1
  fi
  
  echo "✅ Azure DevOps authentication verified"
  return 0
}

# Determine review mode: PR vs Local
REVIEW_MODE="local"
if [ -n "$ARGUMENTS_PR_ID" ] && [ "$ARGUMENTS_LOCAL_ONLY" != "true" ]; then
  REVIEW_MODE="pr"
  
  # For PR mode, ensure Azure DevOps authentication
  if ! check_azure_devops_auth; then
    echo "❌ Azure DevOps authentication required for PR review mode"
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

### Phase 2: Context Retrieval (PR Mode with Fallback)

```javascript
let reviewContext = {};

if (reviewMode === "pr") {
  try {
    // 1. Primary: Fetch PR details from Azure DevOps MCP
    console.log("📋 Fetching PR details from Azure DevOps...");
    const prDetails = await mcp__azure-devops__repo_get_pull_request_by_id({
      pullRequestId: $ARGUMENTS.pr_id,
      repositoryId: $ARGUMENTS.repository || await autoDetectRepository(),
      includeWorkItemRefs: true
    });

    reviewContext = {
      mode: "pr",
      prId: $ARGUMENTS.pr_id,
      title: prDetails.title,
      description: prDetails.description,
      sourceRef: prDetails.sourceRefName,
      targetRef: prDetails.targetRefName,
      author: prDetails.createdBy,
      reviewers: prDetails.reviewers,
      workItems: prDetails.workItemRefs,
      isDraft: prDetails.isDraft,
      repository: prDetails.repository
    };

    reviewContext.existingThreads = await mcp__azure-devops__repo_list_pull_request_threads({
      repositoryId: prDetails.repository.id,
      pullRequestId: $ARGUMENTS.pr_id,
      fullResponse: true
    });

  } catch (error) {
    console.log("⚠️ Azure DevOps MCP failed, falling back to local git analysis");
    
    // Fallback: Use local git commands
    reviewContext = {
      mode: "fallback-local",
      prId: $ARGUMENTS.pr_id,
      title: "PR Review (Fallback Mode)",
      description: "Azure DevOps integration unavailable - using local git analysis",
      sourceRef: await Bash("git rev-parse --abbrev-ref HEAD"),
      targetRef: $ARGUMENTS.base_branch || "main",
      author: await Bash("git config user.name"),
      repository: { name: await Bash("basename $(git rev-parse --show-toplevel)") },
      warning: "Limited functionality - Azure DevOps integration unavailable"
    };
  }

    // 4. Get changed files and commits (works in both modes)
    console.log("📁 Analyzing changed files and commits...");
    reviewContext.commits = await mcp__azure-devops__repo_search_commits({
      project: $ARGUMENTS.project,
      repository: prDetails.repository.name,
      version: prDetails.sourceRefName,
      versionType: "Branch"
    });

    console.log("✅ Azure DevOps context retrieved successfully");

  } catch (error) {
    console.error("❌ Failed to retrieve PR context from Azure DevOps:", error.message);
    
    if (error.message.includes("authentication") || error.message.includes("unauthorized")) {
      console.log("\n🔐 Authentication Error:");
      console.log("Please ensure you're authenticated with Azure DevOps:");
      console.log("1. Azure CLI: az login");
      console.log("2. Azure DevOps: az devops login");
      console.log("3. Or set PAT: export AZURE_DEVOPS_EXT_PAT=your_token");
      
      // Fall back to local mode
      console.log("\n⚠️  Falling back to local analysis mode...");
      reviewMode = "local";
      reviewContext = await setupLocalReviewContext();
    } else {
      throw error;
    }
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
  
  # Auto-detect Azure DevOps project from remote
  REMOTE_URL=$(git config --get remote.origin.url)
  if [[ "$REMOTE_URL" == *"dev.azure.com"* ]] || [[ "$REMOTE_URL" == *"visualstudio.com"* ]]; then
    # Extract project and repository from Azure DevOps URL
    if [[ "$REMOTE_URL" =~ dev\.azure\.com/([^/]+)/([^/]+)/_git/([^/]+) ]]; then
      ORG="${BASH_REMATCH[1]}"
      PROJECT="${BASH_REMATCH[2]}"
      REPO="${BASH_REMATCH[3]}"
    fi
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
  "project": "${PROJECT:-$ARGUMENTS_PROJECT}",
  "organization": "${ORG}",
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
    # PR Mode: Clone repository if needed
    REPO_URL=$(az repos show --repository $REPO_NAME --query remoteUrl -o tsv)
    TEMP_DIR="/tmp/azops-pr-review-$$"
    
    git clone $REPO_URL $TEMP_DIR
    cd $TEMP_DIR
    git fetch origin $SOURCE_BRANCH:$SOURCE_BRANCH
    git fetch origin $TARGET_BRANCH:$TARGET_BRANCH
    git checkout $SOURCE_BRANCH
    
    # Get list of changed files
    CHANGED_FILES=$(git diff --name-only $TARGET_BRANCH...$SOURCE_BRANCH)
    
    # Generate detailed diff for analysis
    git diff $TARGET_BRANCH...$SOURCE_BRANCH > /tmp/pr-diff-$$.patch
    
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

### Phase 3: Technology Stack Detection

```bash
# Auto-detect technology stack
TECH_STACK=""

# Frontend detection
[ -f "package.json" ] && TECH_STACK="$TECH_STACK,Node.js"
grep -q "\"react\"" package.json 2>/dev/null && TECH_STACK="$TECH_STACK,React"
grep -q "\"@angular/core\"" package.json 2>/dev/null && TECH_STACK="$TECH_STACK,Angular"
grep -q "\"vue\"" package.json 2>/dev/null && TECH_STACK="$TECH_STACK,Vue"

# Backend detection
[ -f "*.csproj" ] && TECH_STACK="$TECH_STACK,.NET"
[ -f "requirements.txt" ] || [ -f "pyproject.toml" ] && TECH_STACK="$TECH_STACK,Python"
[ -f "pom.xml" ] || [ -f "build.gradle" ] && TECH_STACK="$TECH_STACK,Java"
[ -f "go.mod" ] && TECH_STACK="$TECH_STACK,Go"

# Determine if UI testing is needed
UI_TESTING_NEEDED="false"
if [ -n "$FRONTEND_CHANGES" ] && [ "$UI_TESTING" != "disabled" ]; then
  UI_TESTING_NEEDED="true"
fi
```

### Phase 6: Spawn Code-Reviewer Agent

```javascript
// Prepare comprehensive context for the agent
let agentContext = {
  source: reviewContext.mode === "pr" ? "azuredevops" : "local",
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
    repository: reviewContext.repository.name,
    project: $ARGUMENTS.project,
    prContext: {
      title: reviewContext.title,
      description: reviewContext.description,
      author: reviewContext.author.displayName,
      sourceRef: reviewContext.sourceRef,
      targetRef: reviewContext.targetRef,
      workItems: reviewContext.workItems
    },
    localRepoPath: tempRepoPath,
    diffFile: `/tmp/pr-diff-$$.patch`
  };
} else {
  // Local Mode context
  agentContext = {
    ...agentContext,
    repository: reviewContext.repository,
    project: reviewContext.project,
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
const reviewResults = await Task({
  description: reviewContext.mode === "pr" ? "Deep PR analysis" : "Local changes analysis",
  prompt: `
    Perform comprehensive code review for ${reviewContext.mode === "pr" ? 'Azure DevOps PR #' + prId : 'local changes against ' + reviewContext.baseBranch}.
    
    Context:
    ${JSON.stringify(agentContext, null, 2)}
    
    Requirements:
    1. Use Context7 to fetch best practices for detected technologies
    2. Use sequential-thinking for complex architectural analysis
    3. ${uiTestingNeeded ? 'Perform UI testing using Playwright MCP for frontend changes' : 'Skip UI testing'}
    4. Focus on: ${$ARGUMENTS.focus || 'security, architecture, UI/UX, performance, testing, business logic'}
    5. ${reviewContext.mode === "local" ? 'Analyze both committed changes against base branch AND uncommitted/staged changes' : ''}
    6. Return structured results in the defined format
    
    ${reviewContext.mode === "local" ? 
      'For local analysis, provide actionable feedback on work-in-progress changes before they are committed or pushed.' : 
      'The review should be thorough and actionable, with clear recommendations for the PR.'}
  `,
  subagent_type: "pr-code-reviewer"
});
```

### Phase 5: Enhanced Analysis Features

#### 5.1 Context7 Integration for Framework Guidelines
The code-reviewer agent will:
- Detect all frameworks and libraries from changed files
- Fetch relevant documentation and best practices
- Apply framework-specific security and performance guidelines
- Include version-specific migration considerations

#### 5.2 Sequential-thinking for Architecture Analysis
The agent will use sequential reasoning for:
- Business impact assessment of changes
- Architectural pattern compliance verification
- Cross-cutting concern identification
- Risk evaluation chains

#### 5.3 Playwright UI Testing (for Frontend Changes)
When frontend changes are detected:
- Launch application in test environment
- Perform visual regression testing
- Check accessibility compliance
- Test responsive design breakpoints
- Measure performance metrics (LCP, FID, CLS)
- Validate interactive elements

### Phase 6: Build Validation

```javascript
// Check build status
const builds = await mcp__azure-devops__build_get_builds({
  project: $ARGUMENTS.project,
  branchName: prDetails.sourceRefName,
  top: 5,
  queryOrder: "QueueTimeDescending"
});

// Get build logs if build failed
if (builds[0]?.result === "failed") {
  const buildLog = await mcp__azure-devops__build_get_log({
    project: $ARGUMENTS.project,
    buildId: builds[0].id
  });
  
  // Include build failures in review
  reviewResults.buildStatus = {
    status: "failed",
    errors: parseBuildErrors(buildLog)
  };
}
```

### Phase 9: Format and Post Results

```javascript
// Structure review comments by category
const reviewThreads = {
  security: [],
  architecture: [],
  ui_frontend: [],
  performance: [],
  testing: [],
  business_logic: [],
  code_quality: []
};

// Parse agent results and categorize findings
for (const finding of reviewResults.findings) {
  const thread = {
    content: formatFinding(finding),
    status: mapSeverityToStatus(finding.severity),
    filePath: finding.file,
    rightFileStartLine: finding.line,
    rightFileEndLine: finding.endLine
  };
  
  reviewThreads[finding.category].push(thread);
}

// Determine if we should post comments to Azure DevOps
const shouldPostToAzureDevOps = reviewContext.mode === "pr" && 
                               $ARGUMENTS.postComments !== "false";

const shouldPostLocal = reviewContext.mode === "local" && 
                       $ARGUMENTS.postComments === "true";

if (shouldPostToAzureDevOps) {
  // Post to Azure DevOps PR
  await postToAzureDevOpsPR(reviewThreads, reviewResults);
} else if (shouldPostLocal && reviewContext.project) {
  // Create work item for local review findings
  await createReviewWorkItem(reviewResults);
} else {
  // Output to console/file for local review
  await outputLocalReview(reviewResults);
}

async function postToAzureDevOpsPR(threads, results) {
  // Post summary comment
  await mcp__azure-devops__repo_create_pull_request_thread({
    repositoryId: reviewContext.repository.id,
    pullRequestId: $ARGUMENTS.pr_id,
    content: generateExecutiveSummary(results),
    status: "Active"
  });
  
  // Post categorized findings
  for (const [category, threads] of Object.entries(reviewThreads)) {
    if (threads.length > 0) {
      const categoryThread = await mcp__azure-devops__repo_create_pull_request_thread({
        repositoryId: reviewContext.repository.id,
        pullRequestId: $ARGUMENTS.pr_id,
        content: `## ${formatCategoryName(category)} Issues (${threads.length})`,
        status: "Active"
      });
      
      // Add individual findings as replies
      for (const finding of threads) {
        if (finding.filePath) {
          // File-specific comment
          await mcp__azure-devops__repo_create_pull_request_thread({
            repositoryId: reviewContext.repository.id,
            pullRequestId: $ARGUMENTS.pr_id,
            content: finding.content,
            filePath: finding.filePath,
            rightFileStartLine: finding.rightFileStartLine,
            rightFileEndLine: finding.rightFileEndLine,
            status: finding.status
          });
        } else {
          // General comment as reply
          await mcp__azure-devops__repo_reply_to_comment({
            repositoryId: reviewContext.repository.id,
            pullRequestId: $ARGUMENTS.pr_id,
            threadId: categoryThread.id,
            content: finding.content
          });
        }
      }
    }
  }
}

async function outputLocalReview(results) {
  // Ensure output directory exists
  await Bash({
    command: "mkdir -p .propel/context/pr-reviews",
    description: "Create PR reviews output directory"
  });
  
  // Generate timestamp-based filename
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const reportPath = `.propel/context/pr-reviews/pr-review-${timestamp}.md`;
  
  console.log(`\n🔍 Local Code Review Completed`);
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
  
  console.log(`\n📄 Detailed report saved to: ${reportPath}`);
  
  // Save detailed report
  await Write({
    file_path: reportPath,
    content: generateDetailedReport(results)
  });
  
  // Show top priority items
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
}
```

### Phase 8: Generate Comprehensive Report

```markdown
# Azure DevOps PR Review Report

## Pull Request: ${prDetails.title}
- **PR ID**: #${$ARGUMENTS.pr_id}
- **Author**: ${prDetails.createdBy.displayName}
- **Source**: ${prDetails.sourceRefName}
- **Target**: ${prDetails.targetRefName}
- **Work Items**: ${prDetails.workItemRefs.map(wi => wi.id).join(', ')}

## Executive Summary
${reviewResults.executiveSummary}

## Risk Assessment
- **Overall Risk**: ${reviewResults.riskLevel}
- **Recommendation**: ${reviewResults.recommendation}
- **Estimated Fix Time**: ${reviewResults.estimatedFixTime}

## Detailed Findings

### 🔒 Security (${reviewResults.security.length} issues)
${formatSecurityFindings(reviewResults.security)}

### 🏗 Architecture & Design (${reviewResults.architecture.length} issues)
${formatArchitectureFindings(reviewResults.architecture)}

### 🎨 UI/Frontend (${reviewResults.ui.length} issues)
${formatUIFindings(reviewResults.ui)}
${uiTestingNeeded ? formatPlaywrightResults(reviewResults.playwrightTests) : ''}

### ⚡ Performance (${reviewResults.performance.length} issues)
${formatPerformanceFindings(reviewResults.performance)}

### ✅ Testing Requirements
${formatTestingRequirements(reviewResults.testing)}

### 💼 Business Logic
${formatBusinessLogicAnalysis(reviewResults.businessLogic)}

## Context7 Insights
${formatContext7Recommendations(reviewResults.context7Insights)}

## Sequential Analysis
${formatSequentialThinkingInsights(reviewResults.sequentialAnalysis)}

## Action Items
${formatActionItems(reviewResults.actionItems)}

## Build Status
${formatBuildStatus(reviewResults.buildStatus)}

---
*Review completed in ${reviewResults.executionTime}ms using Context7, Sequential-thinking, and Playwright integrations*
```

## Advanced Features

### 1. Smart Focus Detection
Automatically adjusts review focus based on:
- File changes pattern
- Commit messages
- Work item types
- Previous review feedback

### 2. Incremental Review
For updated PRs:
- Compare with previous review
- Focus on newly changed files
- Track resolved vs new issues

### 3. Work Item Integration
- Link findings to Azure DevOps work items
- Create follow-up tasks for critical issues
- Update work item status based on review

### 4. Team Notifications
- Notify relevant team members based on findings
- Escalate critical security issues
- Tag subject matter experts for complex areas

## Error Handling

```javascript
try {
  // Main execution flow
} catch (error) {
  if (error.type === 'AGENT_TIMEOUT') {
    // Fallback to quick analysis
    performQuickAnalysis();
  } else if (error.type === 'MCP_CONNECTION_ERROR') {
    // Use local analysis tools
    performLocalAnalysis();
  } else if (error.type === 'AZUREDEVOPS_API_ERROR') {
    // Retry with exponential backoff
    retryWithBackoff();
  }
  
  // Always provide some feedback
  await postErrorSummary(error);
}

async function performQuickAnalysis() {
  // Fallback to basic linting and quick checks
  console.log("🚀 Performing quick analysis...");
  
  try {
    await Bash({
      command: "npm run lint || echo 'Linting not available'",
      description: "Run linting checks"
    });
  } catch (e) {
    console.log("⚠️  Linting issues found or not available");
  }
  
  try {
    await Bash({
      command: "npm test || echo 'Tests not available'",
      description: "Run tests"
    });
  } catch (e) {
    console.log("⚠️  Test failures found or not available");
  }
}

async function performLocalAnalysis() {
  // Use local git commands for basic analysis
  console.log("🏠 Performing local git analysis...");
  
  try {
    const changedFiles = await Bash({
      command: "git diff --name-only HEAD~1",
      description: "Get changed files"
    });
    console.log(`📁 Changed files: ${changedFiles.split('\n').length}`);
    
    const commitMessage = await Bash({
      command: "git log -1 --pretty=format:'%s'",
      description: "Get latest commit message"
    });
    console.log(`💬 Latest commit: ${commitMessage}`);
  } catch (e) {
    console.log("⚠️  Could not perform local git analysis");
  }
}

async function retryWithBackoff() {
  // Implement exponential backoff retry logic
  console.log("🔄 Retrying with exponential backoff...");
  
  for (let attempt = 1; attempt <= 3; attempt++) {
    try {
      console.log(`   Attempt ${attempt}/3...`);
      
      // Wait with exponential backoff
      const delay = Math.pow(2, attempt) * 1000; // 2s, 4s, 8s
      await new Promise(resolve => setTimeout(resolve, delay));
      
      // Retry the main operation (this would be replaced with actual retry logic)
      console.log("   Retry logic would be implemented here");
      break;
      
    } catch (retryError) {
      if (attempt === 3) {
        console.log("❌ All retry attempts failed");
        throw retryError;
      }
      console.log(`   Attempt ${attempt} failed, retrying...`);
    }
  }
}

async function postErrorSummary(error) {
  // Ensure output directory exists
  await Bash({
    command: "mkdir -p .propel/context/pr-reviews",
    description: "Create PR reviews output directory"
  });
  
  // Generate timestamp-based error report filename
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const errorReportPath = `.propel/context/pr-reviews/pr-review-error-${timestamp}.md`;
  
  const errorReport = `# Azure DevOps Review Error Report

Error: ${error.message}
Time: ${new Date().toISOString()}
Type: ${error.type || 'Unknown'}

Please check:
- Azure authentication: \`az login\` and \`az devops login\`
- PAT token: \`AZURE_DEVOPS_EXT_PAT\` environment variable
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

## Integration Points

### 1. Azure DevOps Webhooks
Can be triggered by:
- PR created/updated events
- Build completion events
- Work item state changes

### 2. CI/CD Pipeline Integration
```yaml
# azure-pipelines.yml
- task: CmdLine@2
  displayName: 'AI Code Review'
  inputs:
    script: |
      claude-cli /azops/review-pr $(System.PullRequest.PullRequestId) \
        --project=$(System.TeamProject) \
        --repository=$(Build.Repository.Name) \
        --depth=comprehensive
```

### 3. Policy Gates
Configure as PR policy:
- Required reviewer based on risk level
- Block merge on critical findings
- Require resolution of high-priority issues

## Performance Optimization

1. **Parallel Execution**: Run Context7 lookups concurrently
2. **Caching**: Store technology detection results
3. **Incremental Analysis**: Only analyze changed files
4. **Time Boxing**: Enforce time limits per analysis phase
5. **Resource Management**: Clean up temporary files and close connections

---

*This command orchestrates comprehensive PR review by leveraging the generic code-reviewer agent with Azure DevOps native integration, providing deep, actionable insights for code quality improvement.*