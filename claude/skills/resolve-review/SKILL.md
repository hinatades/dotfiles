---
name: resolve-review
description: Review and resolve PR review comments on the current branch
user-invocable: true
disable-model-invocation: false
---

Review and resolve review comments on the current branch's PR.

## Steps

1. Use `gh` to get the PR number for the current branch and fetch all review comments.
2. For each comment, decide the approach:
   - Valid and simple to fix → address it
   - Valid but adds too much complexity → skip it
   - When in doubt, prefer simplicity
3. Fix the code for comments you're addressing.
4. Reply to every comment on GitHub:
   - If addressed: briefly state what was changed
   - If skipped: one-line reason (e.g., "Skipping to avoid added complexity")
5. Run build and lint.
6. Commit and push.
