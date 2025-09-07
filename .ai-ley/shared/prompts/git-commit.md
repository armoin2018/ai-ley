---
agentMode: general
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*)
applyTo: general
author: AI-LEY
description: Create a git commit
extensions:
- .md
guidelines: N/A
instructionType: general
keywords: []
lastUpdated: '2025-09-03T00:04:48.102167'
summaryScore: 3.0
title: Git Commit
version: 1.0.0
---

## Context

- Current git status: !`git status`
- Current git diff (staged and unstaged changes): !`git diff HEAD`
- Current branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -10`

## Your task
- Create a git commit message that summarizes the changes made to the repository.