---
name: Pull Request Creation Template
description: Generic template for automated PR creation with comprehensive change analysis, user confirmation, and platform-agnostic workflow (GitHub/Azure DevOps)
---

## Purpose
Template for AI agents to create Pull Requests with proper validation, user confirmation, and comprehensive change summarization. Supports both GitHub and Azure DevOps platforms.

## Core Principles
1. **User Control**: Always get explicit confirmation before pushing changes
2. **Transparency**: Provide clear summary of what will be done (under 200 words)
3. **Safety First**: Validate repository state before making changes
4. **Comprehensive Reporting**: Generate detailed change statistics and summaries
5. **Platform Agnostic**: Work with both GitHub and Azure DevOps
6. **Graceful Fallback**: Handle failures with alternative approaches

---

## PR Creation Workflow

### 1. Repository Context Validation
- Verify git repository and remote configuration
- Detect repository owner/organization and name from remote URL
- Check current branch and validate it's not the base branch
- Auto-detect base branch (main/master)
- Verify authentication status (GitHub CLI or Azure CLI)

### 2. Change Analysis
- Scan for staged, unstaged, and untracked files
- Analyze committed changes against base branch
- Count additions, modifications, and deletions
- Calculate line changes (+/-)
- Extract recent commit messages (limit to 5 most recent)
- Generate comprehensive change summary (under 200 words)

### 3. PR Content Generation
**Title Generation**:
- Use custom title if provided via `--title` parameter
- If single commit: Use the commit message as title
- If multiple commits: Use branch name converted to readable format
  - Remove prefixes: `feature/`, `bugfix/`, `hotfix/`
  - Convert hyphens to spaces
  - Capitalize each word

**Description Generation** (keep concise, under 200 words):
- Look for PR template in repository (platform-specific path)
  - GitHub: `.github/PULL_REQUEST_TEMPLATE.md`
  - Azure DevOps: `.azuredevops/pull_request_template.md` or `docs/pull_request_template.md`
- If template exists: Use template as base
- If no template: Auto-generate with:
  - Changes section: List commit messages (max 10)
  - Files changed section: Summary of modified files (max 20 files shown)
  - Test plan checklist: Basic validation items
  - Attribution: Claude Code reference

### 4. Conflict Detection
- Fetch latest changes from remote base branch
- Check if base branch has advanced since branch creation
- Warn user if behind base branch (suggest rebase)
- Detect potential merge conflicts using git merge-tree
- Allow user to proceed or cancel if conflicts detected

### 5. User Confirmation
Display comprehensive summary:
- Repository information (owner/org, repo name)
- Branch information (source → target)
- Change statistics (commits, files, lines)
- Actions to be performed (stage, commit, push, create PR)
- PR details (title, draft status, reviewers)

**Confirmation Requirements**:
- Require explicit "YES" (case-insensitive: YES, yes, Yes)
- Support dry-run mode with `--no-push` flag
- Allow cancellation at any point
- Show clear preview of all actions

### 6. Stage, Commit, and Push
- Stage all uncommitted changes if present
- Create commit with descriptive message (under 200 words):
  - Primary message: Use PR title or custom commit message
  - Attribution: "🤖 Generated with Claude Code"
  - Co-author: "Co-Authored-By: Claude <noreply@anthropic.com>"
- Push to remote:
  - Check if branch exists remotely
  - Use `git push -u origin <branch>` for new branches
  - Use `git push origin <branch>` for existing branches
- Verify push success before proceeding

### 7. Pull Request Creation

**Platform-Specific Creation**:

**For GitHub**:
- Use `mcp__github__create_pull_request` MCP tool
- Parameters: owner, repo, title, head, base, body, draft
- Fallback: Use `gh pr create` CLI command if MCP fails
- Return: PR number and HTML URL

**For Azure DevOps**:
- Use `mcp__azure-devops__repo_create_pull_request` MCP tool
- Parameters: repositoryId, sourceRefName, targetRefName, title, description, isDraft
- Optional: Link work items via `workItems` parameter
- Fallback: Use `az repos pr create` CLI command if MCP fails
- Return: PR ID and URL

**Common Options**:
- Support draft PR creation (--draft flag)
- Add reviewers if specified (--reviewers parameter)
- Link to work items/issues if provided

### 8. Post-Creation Actions
- Fetch PR details for verification
- Add reviewers if requested (platform-specific approach)
- Generate creation report (under 200 words)
- Save report to `.propel/context/pullrequest/pr-{id}-{timestamp}.md`
- Display success summary with PR URL
- Provide next steps for user

## Required Information

### From Git
- Current branch name
- Remote repository URL
- Staged/unstaged/untracked files
- Commit history against base branch (limit to recent commits)
- File change statistics
- Author information

### From User (Optional Parameters)
- `--title="PR Title"` - Custom PR title (default: auto-generated)
- `--description="Description"` - Custom PR description (default: auto-generated, under 200 words)
- `--base=BRANCH` - Target base branch (default: auto-detected main/master)
- `--draft` - Create as draft PR (default: false)
- `--reviewers=user1,user2` - Comma-separated list of reviewers (default: none)
- `--no-push` - Dry-run mode, preview only (default: false)
- `--work-items=123,456` - Azure DevOps work item IDs to link (default: none)
- `--project=NAME` - Azure DevOps project name (default: auto-detect)
- `--repository=NAME` - Repository name/ID (default: auto-detect)

## Output Format

### Console Output - Change Summary
```
═══════════════════════════════════════════════════════════
                    CHANGE SUMMARY
═══════════════════════════════════════════════════════════

📦 Repository: owner/repo
🌲 Current Branch: feature/new-feature → main

📝 Committed Changes:
   - Commits: 3
   - Files Added: 2
   - Files Modified: 5
   - Files Deleted: 0
   - Lines Added: +150
   - Lines Deleted: -25

📋 Recent Commits:
feat: Add new feature
fix: Resolve bug in component
docs: Update README

═══════════════════════════════════════════════════════════
```

### Confirmation Prompt
```
═══════════════════════════════════════════════════════════
                  CONFIRMATION REQUIRED
═══════════════════════════════════════════════════════════

This will perform the following actions:

1. Stage all uncommitted changes (if any)
2. Commit changes with message: 'feat: Add new feature'
3. Push 'feature/new-feature' to origin
4. Create Pull Request: feature/new-feature → main
   Title: Add new feature
   Draft: false

Proceed with PR creation? (YES/NO):
```

### Success Output
```
✅ Pull Request Created Successfully!

📋 PR #123: Add new feature
🔗 URL: https://github.com/owner/repo/pull/123

═══════════════════════════════════════════════════════════
                    PR SUMMARY
═══════════════════════════════════════════════════════════

📊 Status: OPEN
🏷️  Draft: No
👤 Author: username
🌲 Branch: feature/new-feature → main
📝 Commits: 3
📄 Files Changed: 7
➕ Additions: +150
➖ Deletions: -25

🔗 View PR: https://github.com/owner/repo/pull/123

═══════════════════════════════════════════════════════════
```

## Error Handling

### Common Errors and Responses

**Not on a branch**:
```
❌ Not on a branch. Please checkout a feature branch first.
```

**On base branch**:
```
❌ Cannot create PR from base branch (main)
💡 Create a feature branch: git checkout -b feature/your-feature-name
```

**Authentication failure**:
```
❌ Authentication required for PR creation
💡 GitHub: gh auth login
💡 Azure DevOps: az login && az devops login
```

**Merge conflicts detected**:
```
⚠️  Potential merge conflicts detected
💡 Resolve conflicts before creating PR
```

**Platform API failure**:
```
❌ Failed to create pull request: [error message]
⚠️  Attempting fallback via CLI...
```

## Validation Checklist

- [ ] Repository is a valid Git repository
- [ ] Remote is configured (GitHub or Azure DevOps)
- [ ] Current branch is not the base branch
- [ ] Authentication is valid (gh CLI or az CLI)
- [ ] No unresolved merge conflicts
- [ ] All changes are properly staged/committed
- [ ] PR description is under 200 words
- [ ] Commit messages are descriptive and under 200 words
- [ ] PR created successfully
- [ ] PR details retrieved and verified
- [ ] Report saved to `.propel/context/pullrequest/`

## Generated Artifacts

### PR Creation Report
**Location**: `.propel/context/pullrequest/pr-{number}-{timestamp}.md`

**Contents** (keep concise, under 200 words):
- PR number/ID, title, URL, status
- Branch information (source → target)
- Change statistics (files, additions, deletions)
- Commit list (limit to 5 most recent)
- Timestamp
- Attribution

**Example Report Structure**:
```markdown
# Pull Request Creation Report

**Created**: 2025-01-30 14:30:00

## PR Details
- **PR Number**: #123
- **Title**: Add user authentication feature
- **URL**: https://github.com/owner/repo/pull/123
- **Status**: Open
- **Draft**: No

## Branch Information
- **Source**: feature/user-auth
- **Target**: main
- **Commits**: 5

## Changes Summary
- **Files Changed**: 12
- **Additions**: +450
- **Deletions**: -85

## Recent Commits
1. feat: Add login component
2. feat: Implement JWT authentication
3. test: Add auth unit tests
4. docs: Update authentication guide
5. fix: Resolve token refresh issue

---
*Created with Claude Code*
```

## Platform-Specific Considerations

### GitHub
**MCP Tools**:
- `mcp__github__create_pull_request` - Primary PR creation
- `mcp__github__get_pull_request` - Fetch PR details
- `mcp__github__search_users` - Find reviewers (optional)

**CLI Fallback**:
- `gh pr create --title "..." --body "..." --base main --head feature-branch`
- `gh pr edit <number> --add-reviewer "user1,user2"`

**Detection**:
- Remote URL contains `github.com`
- Pattern: `github.com[:/]owner/repo`

### Azure DevOps
**MCP Tools**:
- `mcp__azure-devops__repo_create_pull_request` - Primary PR creation
- `mcp__azure-devops__repo_get_pull_request_by_id` - Fetch PR details
- `mcp__azure-devops__repo_update_pull_request_reviewers` - Add reviewers

**CLI Fallback**:
- `az repos pr create --title "..." --description "..." --source-branch feature --target-branch main`
- `az repos pr reviewer add --id <pr-id> --reviewers user1@email.com user2@email.com`

**Detection**:
- Remote URL contains `dev.azure.com` or `visualstudio.com`
- Pattern: `dev.azure.com/org/project/_git/repo`

**Additional Features**:
- Work item linking via `--work-items` parameter
- Auto-complete options
- Policy compliance checking

## Git Commands Reference

```bash
# Repository information
git status --porcelain                    # Check file changes
git diff --stat                          # Get change statistics
git branch --show-current                # Get current branch
git config --get remote.origin.url       # Get repository URL
git symbolic-ref refs/remotes/origin/HEAD # Get default branch

# Change analysis
git diff --name-status $BASE..$HEAD      # List changed files with status
git diff --shortstat $BASE..$HEAD        # Get addition/deletion counts
git log --oneline $BASE..$HEAD           # Get commit history
git rev-list --count $BASE..$HEAD        # Count commits

# Conflict detection
git fetch origin $BASE_BRANCH            # Update remote references
git rev-list --count HEAD..origin/$BASE  # Check if behind base
git merge-tree $(git merge-base HEAD origin/$BASE) HEAD origin/$BASE  # Check conflicts

# Staging and pushing
git add -A                               # Stage all changes
git commit -m "message"                  # Create commit
git push -u origin $BRANCH               # Push new branch
git push origin $BRANCH                  # Push existing branch
git ls-remote --exit-code --heads origin $BRANCH  # Check remote branch exists
```

## Best Practices

1. **Keep descriptions concise**: All generated text should be under 200 words
2. **Validate before acting**: Check repository state comprehensively
3. **Be transparent**: Show user exactly what will happen
4. **Require explicit confirmation**: Never auto-push without "YES"
5. **Handle uncommitted changes**: Offer to stage and commit them
6. **Use templates when available**: Apply repository's PR template if exists
7. **Add attribution**: Include Claude Code reference in commits
8. **Generate reports**: Save detailed reports to `.propel/context/pullrequest/`
9. **Provide next steps**: Guide user on what to do after PR creation
10. **Graceful degradation**: Fall back to CLI if MCP fails
11. **Clean error messages**: Provide actionable error messages with solutions
12. **Platform detection**: Auto-detect GitHub vs Azure DevOps from remote URL
13. **Limit output**: Show only recent commits (max 5) and files (max 20) in summaries

---

*This template ensures safe, transparent, and comprehensive pull request creation with full user control across both GitHub and Azure DevOps platforms.*
