---
description: create a git branch for a feature or hotfix
---
# Branch Creation Guidelines

Whenever you need to create a new branch, you **MUST** follow these rules:

1. **Category Prefix**:
   - For a new feature, the branch must be created in a `feature` directory (i.e., `feature/branch_name`).
   - For a hotfix, the branch must be created in a `hotfix` directory (i.e., `hotfix/branch_name`).

2. **Branch Name Format**:
   - The branch name must strictly be in **lowercase**.
   - The branch name must be written in **English**.
   - If the name is composed of multiple words, they must be separated by **underscores (`_`)**.
   - The name must clearly describe the proposed functionality or fix.
   - The name must contain a **maximum of 4 words**.

## Steps to create the branch:

1. Identify if the task is a feature or a hotfix.
2. Determine the English translation and summarize it into 1 to 4 words.
3. Replace spaces with underscores and lower the case.
4. Construct the branch name, e.g., `feature/add_login_screen` or `hotfix/fix_auth_crash`.
// turbo
5. Run the git command to create and switch to the branch:
`git checkout -b <prefix>/<branch_name>`
