Core technique: CLI-First Verification.

AI technique: Diff Prompting.

Deliverables:

- Refactored multi-file Dart package.
- Week 1 Token Efficiency Log.

Goal: Learn how to identify the root cause of a Dart error and ask Antigravity to fix only the affected code without unnecessarily changing other files.

useFull commands - dart analyze , flutter analyze
What is Diff Prompting?
Diff Prompting means asking the AI agent to make a small, targeted change and show exactly what changed.

to see diff what schange use - git diff

# TASK: Targeted Dart Error Correction

## ERROR

Paste the exact Flutter/Dart analyzer message.

## SCOPE

File: [Exact file path]
Symbol: [Affected class or method]
Line: [Reported line number]

## CONTRACT

Identify the root cause and correct only the reported issue.

## CONSTRAINTS

- Inspect the affected method and necessary dependencies only.
- Make the smallest correct change.
- Preserve existing architecture and method signatures.
- Do not refactor unrelated code.
- Do not modify unrelated files.
- Do not suppress analyzer warnings merely to hide them.

## OUTPUT

1. Explain the root cause.
2. Show the minimal Git diff.
3. List modified files.
4. Run `flutter analyze`.
5. Report the actual verification result.

What is refactoring?
Refactoring means improving the internal structure of existing code without changing its intended external behaviour.

context-scoped refactoring?
It means providing the AI agent with only the files and code sections necessary for the requested refactoring.
