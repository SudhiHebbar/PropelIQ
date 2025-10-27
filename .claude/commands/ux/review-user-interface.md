---
name: User Interface Design Review
description: Complete a design review of the pending changes on the current branch using the design-analyzer agent for comprehensive UI/UX validation with Playwright automation
model: inherit
allowed-tools: Task, Bash, Glob
parameters:
  figma_design:
    type: string
    required: false
    description: "Figma URL or local image path to design mockup for pixel-perfect comparison (e.g., 'https://figma.com/file/abc123' or '/path/to/wireframe.png')"
  server_url:
    type: string
    required: false
    description: "URL of the development server (defaults to http://localhost:3000)"
  app_path:
    type: string
    required: false
    description: "URL path to review (e.g., '/checkout', '/dashboard', '/home'). Defaults to '/' if not specified"
  focus_area:
    type: string
    required: false
    description: "Aspect to emphasize in review: 'full' (default), 'accessibility', 'responsive', 'interactions', or 'visual-polish'"
---

You need to invoke the design-analyzer agent to conduct a comprehensive design review of the current UI changes.

## Step 1: Gather Git Information

First, collect the current git status and changes:

```
!`git status`
```

```
!`git diff --name-only origin/HEAD...`
```

```
!`git log --oneline -n 5 origin/HEAD...`
```

## Step 2: Start Development Server (if needed)

Check if the development server is running. If not, start it:

```bash
# Check for common dev server ports
!`netstat -an | grep -E ":(3000|3001|4200|5173|8080)" | head -5`
```

If no server is running, identify and start the appropriate dev server based on the project type.

## Step 3: Generate Timestamp and Setup Storage

Generate a timestamp for file naming:

```bash
!`timestamp=$(date +%Y%m%d_%H%M%S) && echo "Generated timestamp: $timestamp"`
```

## Step 4: Invoke the Design-Analyzer Agent

Use the Task tool to invoke the design-analyzer agent with the following configuration:

```
Task(
  subagent_type="design-analyzer",
  description="UI design review",
  prompt="""
    Conduct a comprehensive design review of the UI changes in this project.

    Development server: {{ server_url | default('http://localhost:3000') }}{{ app_path | default('/') }}
    {% if figma_design %}
    Design reference: {{ figma_design }}
    - If URL: Extract design specifications using WebFetch
    - If local path: Analyze mockup image using Read tool
    - Perform pixel-perfect comparison between design and implementation
    {% endif %}
    
    Screenshot Storage Requirements:
    - Save ALL screenshots to .propel/context/playwright/ directory
    - Use descriptive naming convention: <feature>_<viewport>_<issue-type>_<timestamp>.png
    - Examples: checkout_mobile_alignment_20250912_143022.png, header_desktop_spacing_20250912_143022.png
    - Return full file paths for all screenshots in your report

    {% if focus_area and focus_area != 'full' %}
    Review Focus: Emphasize {{ focus_area }} testing while still performing basic validation of other areas
    {% endif %}

    Follow the comprehensive design review methodology:
    1. Phase 0: Preparation - Analyze changes and set up Playwright
    2. Phase 1: Interaction Testing - Test all user flows and interactions
    3. Phase 2: Responsiveness - Test across desktop (1440px), tablet (768px), mobile (375px)
    4. Phase 3: Visual Polish - Check alignment, spacing, typography, colors
    5. Phase 4: Accessibility - WCAG 2.1 AA compliance, keyboard navigation, focus states
    6. Phase 5: Robustness - Edge cases, error states, content overflow
    7. Phase 6: Code Health - Component reuse, design tokens, patterns
    8. Phase 7: Content & Console - Grammar, clarity, console errors
    
    Provide a structured markdown report with:
    - Design Review Summary
    - Screenshots Section (list all captured screenshots with file paths)
    - Findings categorized as:
      * [Blocker] - Critical issues requiring immediate fix
      * [High-Priority] - Significant issues to fix before merge
      * [Medium-Priority] - Improvements for follow-up
      * [Nitpick] - Minor aesthetic details (prefix with "Nit:")
    - Resolution Status for each finding (Fixed/Pending/Not Applicable)
    - Include references to screenshot files for all visual issues
    - Focus on problems and impact, not prescriptive solutions
    
    Use Playwright MCP tools for comprehensive testing:
    - Navigate and interact with the UI
    - Take screenshots at multiple viewports with descriptive filenames
    - Test keyboard navigation and accessibility
    - Monitor console for errors
    - Verify responsive behavior
  """
)
```

## Step 5: Save and Return the Report

Save the agent's comprehensive design review report to a timestamped file:

```bash
# Create the report file with timestamp
!`echo "$AGENT_REPORT" > ".propel/context/ui-review/ui-review-${timestamp}.md"`
```

```bash
# Confirm file was created
!`ls -la .propel/context/ui-review/ui-review-${timestamp}.md`
```

Return the report location and summary to the user:

```
UI Design Review Complete!

Report saved to: .propel/context/ui-review/ui-review-${timestamp}.md
Screenshots saved to: .propel/context/playwright/

The agent has provided a comprehensive design review report with categorized findings and screenshot references.
```
