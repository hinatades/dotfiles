---
name: resolve-pr-review
description: Review and resolve PR review comments on the current branch
user-invocable: true
disable-model-invocation: false
---

Review and resolve review comments on the current branch's PR.

## Steps

1. Use `gh` to get the PR number for the current branch and fetch all review comments.
2. For each comment, decide the approach:
   - **Must verify against actual code** — never accept a comment based on general reasoning alone. Read the relevant code and confirm the problem actually exists in this specific context.
   - Valid and simple to fix → address it
   - Valid but adds too much complexity → skip it
   - Problem does not actually exist in the code → skip it (e.g., guarding against a case that cannot happen given the actual data)
   - When in doubt, prefer simplicity
3. Fix the code for comments you're addressing.
4. Reply to every comment on GitHub:
   - If addressed: briefly state what was changed
   - If skipped: one-line reason (e.g., "Skipping to avoid added complexity")
5. Run build and lint.
6. Commit and push.
7. Resolve all review comment threads (both addressed and skipped) using `gh api` (GraphQL `resolveReviewThread` mutation) to mark them as resolved.
