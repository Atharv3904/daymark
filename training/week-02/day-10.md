what is benchmarking?
--> it means checking / systemetically mesuaring how well an ai agent performs a task under defined conditioned.

Without the skill, the agent required 1,850 tokens, produced 3 architectural violations, and needed 2 corrections. With the skill, it required 1,120 tokens, produced zero violations, and completed in one attempt.

2. What are we benchmarking in DayMark?
   Our Week 2 skills include:

- dart-model
- null-safe-collections
- dart-error-handling
  We want to know:
  Does activating these skills actually improve AI coding performance?

We measure five dimensions:
Benchmark Metrics

Correctness
Does the generated implementation satisfy the task?

Architecture Compliance
Does it follow Clean Architecture and project conventions?

Token Cost
How much context/prompt usage did the task require?

Rework
How many corrections or retries were required?

Time
How long did the task take?

3. The most important concept: A/B benchmarking
   We test the same task under two conditions.
   Condition A — Without skill
   AI Agent

- Project context
- Task prompt

Condition B — With skill
AI Agent

- Project context
- Task prompt
- Relevant skill

stress test - means giving the multiple challenges at a time.

applying stress test on each skill file - A) before using skill B) after suing skill , gives report
