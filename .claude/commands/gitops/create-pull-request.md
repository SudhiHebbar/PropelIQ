---
name: Create GitHub Pull Request
description: Create a GitHub Pull Request with comprehensive change analysis, user confirmation workflow, and automated PR creation using GitHub MCP integration
model: inherit
allowed-tools: Bash, Read, Write, TodoWrite, Grep, Glob, mcp__github__create_pull_request, mcp__github__get_pull_request, mcp__github__search_users
argument-hint: [--title="PR Title"] [--base=BRANCH] [--draft] [--reviewers=user1,user2] [--no-push]
---

# Create GitHub Pull Request

This command helps you create a GitHub Pull Request by analyzing your changes, getting your confirmation, and handling all the Git and GitHub operations automatically.

Refer to the PR creation template at `.propel/templates/pr_creation_base.md` for detailed workflow and best practices.

## Command Options

```
/gitops/create-pull-request [options]

Options:
  --title="Your PR Title"       Custom PR title (default: auto-generated from commits)
  --base=main                   Target branch for PR (default: auto-detect main/master)
  --draft                       Create as draft PR (default: regular PR)
  --reviewers=user1,user2       GitHub usernames to request reviews from
  --no-push                     Dry-run mode - show what would happen without doing it
  --description="Description"   Custom PR description (default: uses template or auto-generates)
```

## How It Works

### Step 1: Verify Your Repository

We check that everything is set up correctly:

```bash
echo "= Checking your repository setup..."

# Get your current branch
CURRENT_BRANCH=$(git branch --show-current)

if [ -z "$CURRENT_BRANCH" ]; then
  echo "L You're not on a branch. Please checkout a feature branch first:"
  echo "   git checkout -b feature/your-feature-name"
  exit 1
fi

# Extract GitHub repository info
REMOTE_URL=$(git config --get remote.origin.url)
if [[ "$REMOTE_URL" =~ github.com[:/]([^/]+)/([^/.]+) ]]; then
  OWNER="${BASH_REMATCH[1]}"
  REPO="${BASH_REMATCH[2]}"
  echo " Repository: $OWNER/$REPO"
else
  echo "L Couldn't find a GitHub repository in your remote"
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
  echo "L You can't create a PR from the base branch ($BASE_BRANCH)"
  echo "=¡ Create a feature branch first:"
  echo "   git checkout -b feature/your-feature-name"
  exit 1
fi

echo " Current Branch: $CURRENT_BRANCH"
echo " Will create PR to: $BASE_BRANCH"
```

### Step 2: Analyze Your Changes

Look at everything you've changed:

```bash
echo ""
echo "=Ê Analyzing your changes..."

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
echo "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
echo "                    CHANGE SUMMARY                          "
echo "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
echo ""
echo "=æ Repository: $OWNER/$REPO"
echo "<2 Current Branch: $CURRENT_BRANCH ’ $BASE_BRANCH"
echo ""
echo "=Ý Committed Changes:"
echo "   - Commits: $COMMIT_COUNT"
echo "   - Files Added: $ADDED_COUNT"
echo "   - Files Modified: $MODIFIED_COUNT"
echo "   - Files Deleted: $DELETED_COUNT"
echo "   - Lines Added: +$TOTAL_ADDITIONS"
echo "   - Lines Deleted: -$TOTAL_DELETIONS"
echo ""

if [ $STAGED_COUNT -gt 0 ] || [ $UNSTAGED_COUNT -gt 0 ] || [ $UNTRACKED_COUNT -gt 0 ]; then
  echo "   You also have uncommitted changes:"
  [ $STAGED_COUNT -gt 0 ] && echo "   - Staged files: $STAGED_COUNT"
  [ $UNSTAGED_COUNT -gt 0 ] && echo "   - Unstaged files: $UNSTAGED_COUNT"
  [ $UNTRACKED_COUNT -gt 0 ] && echo "   - Untracked files: $UNTRACKED_COUNT"
  echo ""
  echo "=¡ These will be staged and committed before creating the PR"
  echo ""
fi

echo "=Ë Recent Commits:"
echo "$COMMIT_MESSAGES"
if [ $COMMIT_COUNT -gt 5 ]; then
  echo "   ... and $((COMMIT_COUNT - 5)) more commits"
fi
echo ""
echo "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
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
    // Check for GitHub PR template
    try {
      const template = await Read({
        file_path: '.github/PULL_REQUEST_TEMPLATE.md'
      });
      prDescription = template;
    } catch (e) {
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
          const icon = status === 'A' ? '(' : status === 'M' ? '=Ý' : '=Ñ';
          description += `${icon} ${file}\n`;
        }
      });

      // Add test plan
      description += `\n## Test Plan\n\n`;
      description += `- [ ] Manual testing completed\n`;
      description += `- [ ] Unit tests passing\n`;
      description += `- [ ] No breaking changes\n\n`;

      // Add attribution
      description += `> Generated with [Claude Code](https://claude.com/claude-code)`;

      prDescription = description;
    }
  }

  return { prTitle, prDescription };
}

const { prTitle, prDescription } = await generatePRContent();

// Show preview (limit to 200 words / ~500 chars)
console.log("\n=Ý PR Title:", prTitle);
console.log("\n=Ä PR Description Preview:");
const preview = prDescription.substring(0, 500);
console.log(preview + (prDescription.length > 500 ? "..." : ""));
console.log("");
```

### Step 4: Check for Conflicts

Before creating the PR, check for potential issues:

```bash
echo "= Checking for potential conflicts..."

# Fetch latest from GitHub
git fetch origin $BASE_BRANCH --quiet 2>/dev/null

# Check if base branch has new commits
BEHIND_COUNT=$(git rev-list --count HEAD..origin/$BASE_BRANCH 2>/dev/null || echo 0)

if [ $BEHIND_COUNT -gt 0 ]; then
  echo "   The $BASE_BRANCH branch has $BEHIND_COUNT new commits since you branched off"
  echo "=¡ You might want to rebase:"
  echo "   git pull origin $BASE_BRANCH --rebase"
  echo ""
  read -p "Continue with PR creation anyway? (y/N): " CONTINUE
  if [[ ! $CONTINUE =~ ^[Yy]$ ]]; then
    echo "L PR creation cancelled"
    exit 1
  fi
fi

# Check for merge conflicts
if ! git merge-tree $(git merge-base HEAD origin/$BASE_BRANCH) HEAD origin/$BASE_BRANCH > /dev/null 2>&1; then
  echo "   There might be merge conflicts when this PR is merged"
  echo ""
fi
```

### Step 5: Get Your Confirmation

You decide if you want to proceed:

```bash
echo ""
echo "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
echo "                  CONFIRMATION REQUIRED                     "
echo "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
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

echo "$STEP. Push '$CURRENT_BRANCH' to GitHub"
STEP=$((STEP + 1))
echo "$STEP. Create Pull Request: $CURRENT_BRANCH ’ $BASE_BRANCH"
echo "   Title: $prTitle"
echo "   Draft: ${ARGUMENTS_DRAFT:-false}"

if [ -n "$ARGUMENTS_REVIEWERS" ]; then
  STEP=$((STEP + 1))
  echo "$STEP. Request reviews from: $ARGUMENTS_REVIEWERS"
fi

echo ""
echo "PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP"
echo ""

# Dry-run mode check
if [ "$ARGUMENTS_NO_PUSH" = "true" ]; then
  echo "= DRY-RUN MODE - Nothing will actually be pushed"
  echo "   This was just a preview"
  echo ""
  exit 0
fi

# Get explicit confirmation
read -p "Type YES to proceed with PR creation: " CONFIRMATION
echo ""

if [[ ! $CONFIRMATION =~ ^(YES|yes|Yes)$ ]]; then
  echo "L PR creation cancelled"
  echo "   No changes were made"
  exit 1
fi
```

### Step 6: Stage, Commit, and Push

Once confirmed, handle all Git operations:

```bash
echo "=€ Creating your pull request..."
echo ""

# Stage uncommitted changes if needed
if [ $UNSTAGED_COUNT -gt 0 ] || [ $UNTRACKED_COUNT -gt 0 ]; then
  echo "=æ Staging all changes..."
  git add -A
  echo " Changes staged"
  echo ""
fi

# Create commit if there are staged changes
if [ $(git diff --cached --name-only | wc -l) -gt 0 ]; then
  echo "=¾ Creating commit..."

  # Use PR title or generate commit message (under 200 words)
  COMMIT_MESSAGE="${ARGUMENTS_TITLE:-Update: $(date +'%Y-%m-%d %H:%M')}"

  git commit -m "$COMMIT_MESSAGE" \
    -m "> Generated with Claude Code" \
    -m "Co-Authored-By: Claude <noreply@anthropic.com>"

  echo " Commit created"
  echo ""
fi

# Push to GitHub
echo "=ä Pushing to GitHub..."

if git ls-remote --exit-code --heads origin $CURRENT_BRANCH > /dev/null 2>&1; then
  git push origin $CURRENT_BRANCH
else
  git push -u origin $CURRENT_BRANCH
fi

echo " Pushed to origin/$CURRENT_BRANCH"
echo ""
```

### Step 7: Create the Pull Request on GitHub

Use GitHub MCP to create the PR:

```javascript
console.log("=( Creating pull request on GitHub...");

try {
  // Create PR using GitHub MCP
  const prResult = await mcp__github__create_pull_request({
    owner: OWNER,
    repo: REPO,
    title: prTitle,
    head: CURRENT_BRANCH,
    base: BASE_BRANCH,
    body: prDescription,
    draft: $ARGUMENTS.draft === 'true'
  });

  const prNumber = prResult.number;
  const prUrl = prResult.html_url;

  console.log("\n Pull Request Created Successfully!");
  console.log(`\n=Ë PR #${prNumber}: ${prTitle}`);
  console.log(`= ${prUrl}`);

  // Add reviewers if specified
  if ($ARGUMENTS.reviewers) {
    console.log("\n=e Adding reviewers...");
    const reviewers = $ARGUMENTS.reviewers.split(',').map(r => r.trim());

    try {
      await Bash({
        command: `gh pr edit ${prNumber} --add-reviewer "${reviewers.join(',')}"`,
        description: "Add reviewers to PR"
      });
      console.log(` Added reviewers: ${reviewers.join(', ')}`);
    } catch (e) {
      console.log(`   Couldn't add reviewers automatically. Add them at: ${prUrl}`);
    }
  }

  // Get full PR details
  const prDetails = await mcp__github__get_pull_request({
    owner: OWNER,
    repo: REPO,
    pull_number: prNumber
  });

  // Display summary
  console.log("\nPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
  console.log("                    PR SUMMARY                              ");
  console.log("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
  console.log(`\n=Ê Status: ${prDetails.state.toUpperCase()}`);
  console.log(`<÷  Draft: ${prDetails.draft ? 'Yes' : 'No'}`);
  console.log(`=d Author: ${prDetails.user.login}`);
  console.log(`<2 Branch: ${CURRENT_BRANCH} ’ ${BASE_BRANCH}`);
  console.log(`=Ý Commits: ${prDetails.commits}`);
  console.log(`=Ä Files Changed: ${prDetails.changed_files}`);
  console.log(`• Additions: +${prDetails.additions}`);
  console.log(`– Deletions: -${prDetails.deletions}`);
  console.log(`\n= View PR: ${prUrl}`);
  console.log("\nPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP\n");

  // Save report to .propel/context/pullrequest/
  await Bash({
    command: "mkdir -p .propel/context/pullrequest",
    description: "Create pullrequest reports directory"
  });

  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const reportPath = `.propel/context/pullrequest/pr-${prNumber}-${timestamp}.md`;

  // Generate concise report (under 200 words)
  const report = `# Pull Request Creation Report

**Created**: ${new Date().toLocaleString()}

## PR Details
- **PR Number**: #${prNumber}
- **Title**: ${prTitle}
- **URL**: ${prUrl}
- **Status**: ${prDetails.state}
- **Draft**: ${prDetails.draft}

## Branch Information
- **Source**: ${CURRENT_BRANCH}
- **Target**: ${BASE_BRANCH}
- **Commits**: ${prDetails.commits}

## Changes Summary
- **Files Changed**: ${prDetails.changed_files}
- **Additions**: +${prDetails.additions}
- **Deletions**: -${prDetails.deletions}

## Recent Commits
${COMMIT_MESSAGES.split('\n').slice(0, 5).join('\n')}

## Next Steps
1. Wait for CI/CD checks to complete
2. Request reviews if not already done
3. Address any review comments
4. Merge when approved: gh pr merge ${prNumber}

---
*Created with Claude Code*
`;

  await Write({
    file_path: reportPath,
    content: report
  });

  console.log(`=Ä Report saved to: ${reportPath}\n`);

  // Provide next steps
  console.log("=¡ What to do next:");
  console.log("   1. Review the PR and make any needed edits");
  console.log("   2. Request reviews from team members");
  console.log("   3. Address any review comments");
  console.log(`   4. When ready, merge: gh pr merge ${prNumber}\n`);

} catch (error) {
  console.error(`\nL Failed to create PR: ${error.message}`);

  // Fallback to GitHub CLI
  console.log("\n   Trying with GitHub CLI...");

  try {
    const draftFlag = $ARGUMENTS.draft ? '--draft' : '';
    const ghCommand = `gh pr create --title "${prTitle}" --body "${prDescription}" --base ${BASE_BRANCH} --head ${CURRENT_BRANCH} ${draftFlag}`;

    const ghResult = await Bash({
      command: ghCommand,
      description: "Create PR via gh CLI"
    });

    console.log("\n Pull Request created via GitHub CLI");
    console.log(ghResult);
  } catch (ghError) {
    console.error("\nL Both GitHub MCP and CLI failed");
    console.error("\nCreate the PR manually at:");
    console.error(`https://github.com/${OWNER}/${REPO}/compare/${BASE_BRANCH}...${CURRENT_BRANCH}`);
    console.error("\nOr check authentication: gh auth login");
  }
}
```

## Examples

### Basic Usage
```bash
# Auto-generate title and description
/gitops/create-pull-request
```

### With Custom Title
```bash
/gitops/create-pull-request --title="Add user authentication feature"
```

### Draft PR
```bash
/gitops/create-pull-request --draft --title="WIP: New dashboard"
```

### With Reviewers
```bash
/gitops/create-pull-request --reviewers=john,sarah
```

### Dry Run
```bash
/gitops/create-pull-request --no-push
```

## Common Scenarios

**"I have uncommitted changes"**: They'll be staged and committed automatically when you confirm.

**"I'm not sure what base branch to use"**: We auto-detect `main` or `master`.

**"I want to preview first"**: Use `--no-push` flag.

**"My repo has a PR template"**: We automatically use `.github/PULL_REQUEST_TEMPLATE.md` if it exists.

**"Something went wrong"**: We fall back to `gh` CLI automatically.

## Tips

- Work on feature branches, not `main` or `master`
- Make focused commits with clear messages
- Use `--draft` for work-in-progress
- Keep PR descriptions under 200 words

## Troubleshooting

**"Not authenticated"**: Run `gh auth login`

**"Can't find repository"**: Check `git remote -v`

**"Merge conflicts"**: Run `git pull origin main --rebase`

---

*This command makes creating PRs simple and safe while keeping you in full control.*
