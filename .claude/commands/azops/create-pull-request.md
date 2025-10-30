---
name: Create Azure DevOps Pull Request
description: Create an Azure DevOps Pull Request with comprehensive change analysis, user confirmation workflow, and automated PR creation using Azure DevOps MCP integration
model: inherit
allowed-tools: Bash, Read, Write, TodoWrite, Grep, Glob, mcp__azure-devops__repo_create_pull_request, mcp__azure-devops__repo_get_pull_request_by_id, mcp__azure-devops__repo_update_pull_request_reviewers, mcp__azure-devops__repo_list_repos_by_project, mcp__azure-devops__core_get_identity_ids
argument-hint: [--title="PR Title"] [--base=BRANCH] [--draft] [--reviewers=user1,user2] [--no-push] [--work-items=123,456] [--project=PROJECT]
---

# Create Azure DevOps Pull Request

This command helps you create an Azure DevOps Pull Request by analyzing your changes, getting your confirmation, and handling all the Git and Azure DevOps operations automatically.

Refer to the PR creation template at `.propel/templates/pr_creation_base.md` for detailed workflow and best practices.

## Command Options

```
/azops/create-pull-request [options]

Options:
  --title="Your PR Title"       Custom PR title (default: auto-generated from commits)
  --base=main                   Target branch for PR (default: auto-detect main/master)
  --draft                       Create as draft PR (default: regular PR)
  --reviewers=user1,user2       Email addresses or display names for reviewers
  --no-push                     Dry-run mode - show what would happen without doing it
  --description="Description"   Custom PR description (default: uses template or auto-generates)
  --work-items=123,456          Comma-separated work item IDs to link
  --project=ProjectName         Azure DevOps project name (default: auto-detect)
  --repository=RepoName         Repository name (default: auto-detect)
```

## How It Works

### Step 1: Verify Your Repository and Authentication

We check that everything is set up correctly:

```bash
echo "🔍 Checking your repository setup and Azure DevOps authentication..."

# Check Azure DevOps authentication
if ! az account show >/dev/null 2>&1; then
  echo "❌ Azure CLI not authenticated"
  echo "   Please run: az login"
  exit 1
fi

if ! az devops project list >/dev/null 2>&1; then
  echo "❌ Azure DevOps authentication required"
  echo "   Please authenticate with Azure DevOps:"
  echo "   1. Set your organization: az devops configure --defaults organization=https://dev.azure.com/YourOrg"
  echo "   2. Login: az devops login"
  echo "   Or set PAT: export AZURE_DEVOPS_EXT_PAT=your_token"
  exit 1
fi

echo "✅ Azure DevOps authentication verified"

# Get your current branch
CURRENT_BRANCH=$(git branch --show-current)

if [ -z "$CURRENT_BRANCH" ]; then
  echo "❌ You're not on a branch. Please checkout a feature branch first:"
  echo "   git checkout -b feature/your-feature-name"
  exit 1
fi

# Extract Azure DevOps repository info from remote URL
REMOTE_URL=$(git config --get remote.origin.url)

if [[ "$REMOTE_URL" =~ dev\.azure\.com/([^/]+)/([^/]+)/_git/([^/]+) ]]; then
  ORGANIZATION="${BASH_REMATCH[1]}"
  PROJECT="${ARGUMENTS_PROJECT:-${BASH_REMATCH[2]}}"
  REPO="${ARGUMENTS_REPOSITORY:-${BASH_REMATCH[3]}}"
  echo "✅ Organization: $ORGANIZATION"
  echo "✅ Project: $PROJECT"
  echo "✅ Repository: $REPO"
elif [[ "$REMOTE_URL" =~ ([^/]+)\.visualstudio\.com/([^/]+)/_git/([^/]+) ]]; then
  ORGANIZATION="${BASH_REMATCH[1]}"
  PROJECT="${ARGUMENTS_PROJECT:-${BASH_REMATCH[2]}}"
  REPO="${ARGUMENTS_REPOSITORY:-${BASH_REMATCH[3]}}"
  echo "✅ Organization: $ORGANIZATION"
  echo "✅ Project: $PROJECT"
  echo "✅ Repository: $REPO"
else
  echo "❌ Couldn't find an Azure DevOps repository in your remote"
  echo "   Current remote: $REMOTE_URL"
  exit 1
fi

# Determine the base branch
BASE_BRANCH="${ARGUMENTS_BASE:-main}"
if ! git show-ref --verify --quiet refs/heads/$BASE_BRANCH; then
  BASE_BRANCH="master"
  if ! git show-ref --verify --quiet refs/heads/$BASE_BRANCH; then
    BASE_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  fi
fi

# Ensure you're not on the base branch
if [ "$CURRENT_BRANCH" = "$BASE_BRANCH" ]; then
  echo "❌ You can't create a PR from the base branch ($BASE_BRANCH)"
  echo "💡 Create a feature branch first:"
  echo "   git checkout -b feature/your-feature-name"
  exit 1
fi

echo "✅ Current Branch: $CURRENT_BRANCH"
echo "✅ Will create PR to: $BASE_BRANCH"
```

### Step 2: Analyze Your Changes

Look at everything you've changed:

```bash
echo ""
echo "📊 Analyzing your changes..."

# Count different types of changes
STAGED_COUNT=$(git diff --cached --name-only | wc -l)
UNSTAGED_COUNT=$(git diff --name-only | wc -l)
UNTRACKED_COUNT=$(git ls-files --others --exclude-standard | wc -l)

# Compare with base branch
ADDED_COUNT=$(git diff --name-status $BASE_BRANCH..HEAD | grep -c "^A" || echo 0)
MODIFIED_COUNT=$(git diff --name-status $BASE_BRANCH..HEAD | grep -c "^M" || echo 0)
DELETED_COUNT=$(git diff --name-status $BASE_BRANCH..HEAD | grep -c "^D" || echo 0)

# Get commit information
COMMIT_COUNT=$(git rev-list --count $BASE_BRANCH..HEAD)
COMMIT_MESSAGES=$(git log --oneline $BASE_BRANCH..HEAD | head -n 5)

# Calculate line changes
TOTAL_ADDITIONS=$(git diff --shortstat $BASE_BRANCH..HEAD | grep -oP '\d+(?= insertion)' || echo 0)
TOTAL_DELETIONS=$(git diff --shortstat $BASE_BRANCH..HEAD | grep -oP '\d+(?= deletion)' || echo 0)

# Display summary
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "                    CHANGE SUMMARY                          "
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📦 Organization: $ORGANIZATION"
echo "📁 Project: $PROJECT"
echo "📂 Repository: $REPO"
echo "🌲 Current Branch: $CURRENT_BRANCH → $BASE_BRANCH"
echo ""
echo "📝 Committed Changes:"
echo "   - Commits: $COMMIT_COUNT"
echo "   - Files Added: $ADDED_COUNT"
echo "   - Files Modified: $MODIFIED_COUNT"
echo "   - Files Deleted: $DELETED_COUNT"
echo "   - Lines Added: +$TOTAL_ADDITIONS"
echo "   - Lines Deleted: -$TOTAL_DELETIONS"
echo ""

if [ $STAGED_COUNT -gt 0 ] || [ $UNSTAGED_COUNT -gt 0 ] || [ $UNTRACKED_COUNT -gt 0 ]; then
  echo "⚠️  You also have uncommitted changes:"
  [ $STAGED_COUNT -gt 0 ] && echo "   - Staged files: $STAGED_COUNT"
  [ $UNSTAGED_COUNT -gt 0 ] && echo "   - Unstaged files: $UNSTAGED_COUNT"
  [ $UNTRACKED_COUNT -gt 0 ] && echo "   - Untracked files: $UNTRACKED_COUNT"
  echo ""
  echo "💡 These will be staged and committed before creating the PR"
  echo ""
fi

echo "📋 Recent Commits:"
echo "$COMMIT_MESSAGES"
if [ $COMMIT_COUNT -gt 5 ]; then
  echo "   ... and $((COMMIT_COUNT - 5)) more commits"
fi
echo ""
echo "═══════════════════════════════════════════════════════════"
```

### Step 3: Generate PR Title and Description

Create a good PR title and description (kept under 200 words):

```javascript
async function generatePRContent() {
  // Get all commit messages
  const commits = await Bash({
    command: `git log --pretty=format:'%s' ${BASE_BRANCH}..HEAD`,
    description: "Get commit messages"
  });

  const commitList = commits.split('\n').filter(c => c.trim()).slice(0, 10); // Limit to 10 commits

  // Generate PR title
  let prTitle = $ARGUMENTS.title;
  if (!prTitle) {
    if (commitList.length === 1) {
      prTitle = commitList[0];
    } else {
      // Convert branch name to readable title
      const branchName = CURRENT_BRANCH.replace(/^(feature|bugfix|hotfix)\//, '');
      prTitle = branchName
        .split('-')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
    }
  }

  // Generate PR description (under 200 words)
  let prDescription = $ARGUMENTS.description;
  if (!prDescription) {
    // Check for Azure DevOps PR template
    let templateFound = false;
    const templatePaths = [
      '.azuredevops/pull_request_template.md',
      'docs/pull_request_template.md'
    ];

    for (const templatePath of templatePaths) {
      try {
        const template = await Read({ file_path: templatePath });
        prDescription = template;
        templateFound = true;
        break;
      } catch (e) {
        // Template not found, continue
      }
    }

    if (!templateFound) {
      // No template, create concise description
      let description = `## Changes\n\n`;

      // Add commits (limit to 10)
      commitList.forEach(commit => {
        description += `- ${commit}\n`;
      });

      // Add file summary (limit to 20 files)
      description += `\n## Files Changed\n\n`;
      const changedFiles = await Bash({
        command: `git diff --name-status ${BASE_BRANCH}..HEAD | head -20`,
        description: "Get changed files"
      });

      changedFiles.split('\n').forEach(line => {
        if (line.trim()) {
          const [status, file] = line.split('\t');
          const icon = status === 'A' ? '✨' : status === 'M' ? '📝' : '🗑️';
          description += `${icon} ${file}\n`;
        }
      });

      // Add test plan
      description += `\n## Test Plan\n\n`;
      description += `- [ ] Manual testing completed\n`;
      description += `- [ ] Unit tests passing\n`;
      description += `- [ ] No breaking changes\n\n`;

      // Add attribution
      description += `🤖 Generated with [Claude Code](https://claude.com/claude-code)`;

      prDescription = description;
    }
  }

  return { prTitle, prDescription };
}

const { prTitle, prDescription } = await generatePRContent();

// Show preview (limit to 200 words / ~500 chars)
console.log("\n📝 PR Title:", prTitle);
console.log("\n📄 PR Description Preview:");
const preview = prDescription.substring(0, 500);
console.log(preview + (prDescription.length > 500 ? "..." : ""));
console.log("");
```

### Step 4: Check for Conflicts

Before creating the PR, check for potential issues:

```bash
echo "🔍 Checking for potential conflicts..."

# Fetch latest from Azure DevOps
git fetch origin $BASE_BRANCH --quiet 2>/dev/null

# Check if base branch has new commits
BEHIND_COUNT=$(git rev-list --count HEAD..origin/$BASE_BRANCH 2>/dev/null || echo 0)

if [ $BEHIND_COUNT -gt 0 ]; then
  echo "⚠️  The $BASE_BRANCH branch has $BEHIND_COUNT new commits since you branched off"
  echo "💡 You might want to rebase:"
  echo "   git pull origin $BASE_BRANCH --rebase"
  echo ""
  read -p "Continue with PR creation anyway? (y/N): " CONTINUE
  if [[ ! $CONTINUE =~ ^[Yy]$ ]]; then
    echo "❌ PR creation cancelled"
    exit 1
  fi
fi

# Check for merge conflicts
if ! git merge-tree $(git merge-base HEAD origin/$BASE_BRANCH) HEAD origin/$BASE_BRANCH > /dev/null 2>&1; then
  echo "⚠️  There might be merge conflicts when this PR is merged"
  echo ""
fi
```

### Step 5: Get Your Confirmation

You decide if you want to proceed:

```bash
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "                  CONFIRMATION REQUIRED                     "
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Here's what I'll do:"
echo ""

STEP=1
if [ $UNSTAGED_COUNT -gt 0 ] || [ $UNTRACKED_COUNT -gt 0 ]; then
  echo "$STEP. Stage all your uncommitted changes"
  STEP=$((STEP + 1))
  echo "$STEP. Create a commit with your changes"
  STEP=$((STEP + 1))
fi

echo "$STEP. Push '$CURRENT_BRANCH' to Azure DevOps"
STEP=$((STEP + 1))
echo "$STEP. Create Pull Request: $CURRENT_BRANCH → $BASE_BRANCH"
echo "   Title: $prTitle"
echo "   Draft: ${ARGUMENTS_DRAFT:-false}"

if [ -n "$ARGUMENTS_REVIEWERS" ]; then
  STEP=$((STEP + 1))
  echo "$STEP. Request reviews from: $ARGUMENTS_REVIEWERS"
fi

if [ -n "$ARGUMENTS_WORK_ITEMS" ]; then
  STEP=$((STEP + 1))
  echo "$STEP. Link work items: $ARGUMENTS_WORK_ITEMS"
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo ""

# Dry-run mode check
if [ "$ARGUMENTS_NO_PUSH" = "true" ]; then
  echo "🔍 DRY-RUN MODE - Nothing will actually be pushed"
  echo "   This was just a preview"
  echo ""
  exit 0
fi

# Get explicit confirmation
read -p "Type YES to proceed with PR creation: " CONFIRMATION
echo ""

if [[ ! $CONFIRMATION =~ ^(YES|yes|Yes)$ ]]; then
  echo "❌ PR creation cancelled"
  echo "   No changes were made"
  exit 1
fi
```

### Step 6: Stage, Commit, and Push

Once confirmed, handle all Git operations:

```bash
echo "🚀 Creating your pull request..."
echo ""

# Stage uncommitted changes if needed
if [ $UNSTAGED_COUNT -gt 0 ] || [ $UNTRACKED_COUNT -gt 0 ]; then
  echo "📦 Staging all changes..."
  git add -A
  echo "✅ Changes staged"
  echo ""
fi

# Create commit if there are staged changes
if [ $(git diff --cached --name-only | wc -l) -gt 0 ]; then
  echo "💾 Creating commit..."

  # Use PR title or generate commit message (under 200 words)
  COMMIT_MESSAGE="${ARGUMENTS_TITLE:-Update: $(date +'%Y-%m-%d %H:%M')}"

  git commit -m "$COMMIT_MESSAGE" \
    -m "🤖 Generated with Claude Code" \
    -m "Co-Authored-By: Claude <noreply@anthropic.com>"

  echo "✅ Commit created"
  echo ""
fi

# Push to Azure DevOps
echo "📤 Pushing to Azure DevOps..."

if git ls-remote --exit-code --heads origin $CURRENT_BRANCH > /dev/null 2>&1; then
  git push origin $CURRENT_BRANCH
else
  git push -u origin $CURRENT_BRANCH
fi

echo "✅ Pushed to origin/$CURRENT_BRANCH"
echo ""
```

### Step 7: Create the Pull Request on Azure DevOps

Use Azure DevOps MCP to create the PR:

```javascript
console.log("🔨 Creating pull request on Azure DevOps...");

try {
  // Get repository ID first
  console.log("📋 Getting repository information...");
  const repos = await mcp__azure-devops__repo_list_repos_by_project({
    project: PROJECT,
    repoNameFilter: REPO
  });

  const repository = repos.find(r => r.name === REPO);
  if (!repository) {
    throw new Error(`Repository ${REPO} not found in project ${PROJECT}`);
  }

  const repositoryId = repository.id;

  // Prepare source and target refs (Azure DevOps format)
  const sourceRefName = `refs/heads/${CURRENT_BRANCH}`;
  const targetRefName = `refs/heads/${BASE_BRANCH}`;

  // Create PR using Azure DevOps MCP
  const prResult = await mcp__azure-devops__repo_create_pull_request({
    repositoryId: repositoryId,
    sourceRefName: sourceRefName,
    targetRefName: targetRefName,
    title: prTitle,
    description: prDescription,
    isDraft: $ARGUMENTS.draft === 'true',
    workItems: $ARGUMENTS.work_items || undefined
  });

  const prId = prResult.pullRequestId;
  const prUrl = `https://dev.azure.com/${ORGANIZATION}/${PROJECT}/_git/${REPO}/pullrequest/${prId}`;

  console.log("\n✅ Pull Request Created Successfully!");
  console.log(`\n📋 PR #${prId}: ${prTitle}`);
  console.log(`🔗 ${prUrl}`);

  // Add reviewers if specified
  if ($ARGUMENTS.reviewers) {
    console.log("\n👥 Adding reviewers...");
    const reviewers = $ARGUMENTS.reviewers.split(',').map(r => r.trim());

    try {
      // Get identity IDs for reviewers
      const reviewerIds = [];
      for (const reviewer of reviewers) {
        try {
          const identities = await mcp__azure-devops__core_get_identity_ids({
            searchFilter: reviewer
          });
          if (identities && identities.length > 0) {
            reviewerIds.push(identities[0]);
          }
        } catch (e) {
          console.log(`⚠️  Couldn't find identity for: ${reviewer}`);
        }
      }

      if (reviewerIds.length > 0) {
        await mcp__azure-devops__repo_update_pull_request_reviewers({
          repositoryId: repositoryId,
          pullRequestId: prId,
          reviewerIds: reviewerIds,
          action: 'add'
        });
        console.log(`✅ Added ${reviewerIds.length} reviewer(s)`);
      }
    } catch (e) {
      console.log(`⚠️  Couldn't add reviewers automatically. Add them at: ${prUrl}`);
    }
  }

  // Get full PR details
  const prDetails = await mcp__azure-devops__repo_get_pull_request_by_id({
    repositoryId: repositoryId,
    pullRequestId: prId,
    includeWorkItemRefs: true
  });

  // Display summary
  console.log("\n═══════════════════════════════════════════════════════════");
  console.log("                    PR SUMMARY                              ");
  console.log("═══════════════════════════════════════════════════════════");
  console.log(`\n📊 Status: ${prDetails.status}`);
  console.log(`🏷️  Draft: ${prDetails.isDraft ? 'Yes' : 'No'}`);
  console.log(`👤 Author: ${prDetails.createdBy.displayName}`);
  console.log(`🌲 Branch: ${CURRENT_BRANCH} → ${BASE_BRANCH}`);

  if (prDetails.workItemRefs && prDetails.workItemRefs.length > 0) {
    console.log(`🔗 Work Items: ${prDetails.workItemRefs.map(wi => wi.id).join(', ')}`);
  }

  console.log(`\n🔗 View PR: ${prUrl}`);
  console.log("\n═══════════════════════════════════════════════════════════\n");

  // Save report to .propel/context/pullrequest/
  await Bash({
    command: "mkdir -p .propel/context/pullrequest",
    description: "Create pullrequest reports directory"
  });

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const reportPath = `.propel/context/pullrequest/pr-${prId}-${timestamp}.md`;

  // Generate concise report (under 200 words)
  const workItemsInfo = prDetails.workItemRefs && prDetails.workItemRefs.length > 0
    ? `\n- **Work Items**: ${prDetails.workItemRefs.map(wi => wi.id).join(', ')}`
    : '';

  const report = `# Pull Request Creation Report

**Created**: ${new Date().toLocaleString()}

## PR Details
- **PR ID**: #${prId}
- **Title**: ${prTitle}
- **URL**: ${prUrl}
- **Status**: ${prDetails.status}
- **Draft**: ${prDetails.isDraft}${workItemsInfo}

## Branch Information
- **Source**: ${CURRENT_BRANCH}
- **Target**: ${BASE_BRANCH}
- **Organization**: ${ORGANIZATION}
- **Project**: ${PROJECT}
- **Repository**: ${REPO}

## Changes Summary
- **Commits**: ${COMMIT_COUNT}
- **Files Added**: ${ADDED_COUNT}
- **Files Modified**: ${MODIFIED_COUNT}
- **Files Deleted**: ${DELETED_COUNT}
- **Lines Added**: +${TOTAL_ADDITIONS}
- **Lines Deleted**: -${TOTAL_DELETIONS}

## Recent Commits
${COMMIT_MESSAGES.split('\n').slice(0, 5).join('\n')}

## Next Steps
1. Request reviews if not already done
2. Address any review comments
3. Wait for policies to pass
4. Complete the PR when ready: az repos pr update --id ${prId} --status completed

---
*Created with Claude Code*
`;

  await Write({
    file_path: reportPath,
    content: report
  });

  console.log(`📄 Report saved to: ${reportPath}\n`);

  // Provide next steps
  console.log("💡 What to do next:");
  console.log("   1. Review the PR and make any needed edits");
  console.log("   2. Request reviews from team members");
  console.log("   3. Wait for build validation and policies");
  console.log("   4. Address any review comments");
  console.log(`   5. When ready, complete: az repos pr update --id ${prId} --status completed\n`);

} catch (error) {
  console.error(`\n❌ Failed to create PR: ${error.message}`);

  // Fallback to Azure CLI
  console.log("\n⚠️  Trying with Azure CLI...");

  try {
    const draftFlag = $ARGUMENTS.draft ? '--draft true' : '';
    const workItemsFlag = $ARGUMENTS.work_items ? `--work-items ${$ARGUMENTS.work_items}` : '';

    const azCommand = `az repos pr create --project "${PROJECT}" --repository "${REPO}" --title "${prTitle}" --description "${prDescription}" --source-branch ${CURRENT_BRANCH} --target-branch ${BASE_BRANCH} ${draftFlag} ${workItemsFlag}`;

    const azResult = await Bash({
      command: azCommand,
      description: "Create PR via Azure CLI"
    });

    console.log("\n✅ Pull Request created via Azure CLI");
    console.log(azResult);
  } catch (azError) {
    console.error("\n❌ Both Azure DevOps MCP and CLI failed");
    console.error("\nCreate the PR manually at:");
    console.error(`https://dev.azure.com/${ORGANIZATION}/${PROJECT}/_git/${REPO}/pullrequestcreate?sourceRef=${CURRENT_BRANCH}&targetRef=${BASE_BRANCH}`);
    console.error("\nOr check authentication:");
    console.error("  az login && az devops login");
  }
}
```

## Examples

### Basic Usage
```bash
# Auto-generate title and description
/azops/create-pull-request
```

### With Custom Title
```bash
/azops/create-pull-request --title="Add user authentication feature"
```

### Draft PR
```bash
/azops/create-pull-request --draft --title="WIP: New dashboard"
```

### With Reviewers and Work Items
```bash
/azops/create-pull-request --reviewers=john@company.com,sarah@company.com --work-items=12345,12346
```

### Specify Project and Repository
```bash
/azops/create-pull-request --project=MyProject --repository=MyRepo
```

### Dry Run
```bash
/azops/create-pull-request --no-push
```

### Full Options
```bash
/azops/create-pull-request \
  --title="Implement payment flow" \
  --base=develop \
  --reviewers=tech-lead@company.com \
  --work-items=12345,12346 \
  --project=ECommerce \
  --draft
```

## Common Scenarios

**"I have uncommitted changes"**: They'll be staged and committed automatically when you confirm.

**"I'm not sure what base branch to use"**: We auto-detect `main` or `master`.

**"I want to preview first"**: Use `--no-push` flag.

**"My repo has a PR template"**: We automatically check `.azuredevops/pull_request_template.md` and `docs/pull_request_template.md`.

**"I need to link work items"**: Use `--work-items=123,456` to automatically link them.

**"Something went wrong"**: We fall back to `az` CLI automatically.

## Azure DevOps Specific Features

### Work Item Linking
Link work items directly when creating the PR:
```bash
/azops/create-pull-request --work-items=12345,12346
```

### Project and Repository Detection
The command auto-detects from your git remote, but you can override:
```bash
/azops/create-pull-request --project=MyProject --repository=MyRepo
```

### Reviewer Management
Add reviewers by email or display name:
```bash
/azops/create-pull-request --reviewers=john.doe@company.com,sarah.smith@company.com
```

## Tips

- Work on feature branches, not `main` or `master`
- Make focused commits with clear messages
- Use `--draft` for work-in-progress
- Keep PR descriptions under 200 words
- Link related work items with `--work-items`
- Use team email addresses for reviewers

## Troubleshooting

**"Not authenticated"**:
```bash
az login
az devops login
```

**"Organization not configured"**:
```bash
az devops configure --defaults organization=https://dev.azure.com/YourOrg
```

**"PAT token required"**:
```bash
export AZURE_DEVOPS_EXT_PAT=your_personal_access_token
```

**"Can't find repository"**: Check `git remote -v`

**"Merge conflicts"**: Run `git pull origin main --rebase`

**"Work item not found"**: Verify work item IDs exist in your project

---

*This command makes creating Azure DevOps PRs simple and safe while keeping you in full control.*
