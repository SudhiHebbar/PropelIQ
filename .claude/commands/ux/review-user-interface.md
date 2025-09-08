---
allowed-tools: Task, Bash, Glob
description: Complete a design review of the pending changes on the current branch using the design-analyzer agent
parameters:
  figma_design:
    type: string
    required: false
    description: "Figma URL or local image path to design mockup for pixel-perfect comparison (e.g., 'https://figma.com/file/abc123' or '/path/to/wireframe.png')"
  server_url:
    type: string
    required: false
    description: "URL of the development server (defaults to http://localhost:3000)"
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

## Step 3: Invoke the Design-Analyzer Agent

Use the Task tool to invoke the design-analyzer agent with the following configuration:

```
Task(
  subagent_type="design-analyzer",
  description="UI design review",
  prompt="""
    Conduct a comprehensive design review of the UI changes in this project.
    
    Development server: {{ server_url | default('http://localhost:3000') }}
    {% if figma_design %}
    Design reference: {{ figma_design }}
    - If URL: Extract design specifications using WebFetch
    - If local path: Analyze mockup image using Read tool
    - Perform pixel-perfect comparison between design and implementation
    {% endif %}
    
    Git context:
    - Review all modified files and understand the scope of changes
    - Focus on UI/UX components, styles, and user-facing features
    
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
    - Findings categorized as:
      * [Blocker] - Critical issues requiring immediate fix
      * [High-Priority] - Significant issues to fix before merge
      * [Medium-Priority] - Improvements for follow-up
      * [Nitpick] - Minor aesthetic details (prefix with "Nit:")
    - Include screenshots for all visual issues
    - Focus on problems and impact, not prescriptive solutions
    
    Use Playwright MCP tools for comprehensive testing:
    - Navigate and interact with the UI
    - Take screenshots at multiple viewports
    - Test keyboard navigation and accessibility
    - Monitor console for errors
    - Verify responsive behavior
  """
)
```

## Step 4: Return the Report

The agent will provide a comprehensive design review report. Return this report to the user as the final output.
