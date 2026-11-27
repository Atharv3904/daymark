spec.md - files won't necessarily be automatically discovered just because they exist. Your AGENTS.md or a feature-implementation skill needs to instruct the agent to locate and read the relevant feature specification before implementation.

when user gives prompt input then agent must check global AGENTS.md must explicitly tell the agent how to discover feature specifications.
The agent doesn't inherently know which spec.md belongs to a feature unless you establish a discovery rule.

4. But spec.md is different from SKILL.md
   This is the crucial distinction:
   SKILL.md spec.md
   Discovery Antigravity's skill discovery system Your project-defined discovery process
   Trigger Description/frontmatter matching Feature identification + search
   Purpose How to implement What to implement
   Automatically loaded Supported natively Must be instructed to locate/read it

5. Antigravity automatically discovers skills
   For skills, Antigravity already has a built-in mechanism:
   On each task, Antigravity sees skill names/descriptions and can autonomously activate a relevant skill by matching the request. When relevant, it reads the full SKILL.md. This is its progressive-loading behavior

Antigravity documents autonomous skill discovery, but feature specs are ordinary project documents. You need to give your AGENTS.md an explicit spec-discovery instruction.

You don't need to manually tell it:
Read authentication/spec.md and load dart-model skill.

You simply say:
Implement Authentication.

The global instruction tells it to find the spec, while Antigravity's native skill system handles relevant skill activation.

when you written a prompt and from prompt it will read the all input context and then it will load / read the global rules Agents.md.
The agent's workflow

1. Reads AGENTS.md → understands global DayMark rules.
2. Identifies the feature → Authentication.
3. Automatically searches for and reads the relevant spec.md → because your global instructions explicitly tell it to do so.
4. Automatically discovers applicable skills → through Antigravity's native skill discovery mechanism.
5. Loads relevant SKILL.md files → based on the task.
6. Implements the feature → using global rules + feature specification + applicable skills.
7. Verifies the implementation → against requirements and project standards.

spec.md - its variable , all feature requirement

skill.md - under 400 tokens.

Agents.md - under 250 to 300 tokens.

Null safe collections and extension

Build an Ai skill that uses few-shot canonical snippets instead of long explination.

target is - a reusable-null-safe-collections skill + non mutating transaformation module that avoids !.

instead of writing imperative code dart allows to write declarative code. - You're describing what result you want, rather than manually describing every operation.

what is null safe transaformation -

final result = names
.map((name) => name!.toUpperCase())
.toList();

null safe -
final result = names
.whereType<String>()
.map((name) => name.toUpperCase())
.toList(); - whereType<String>() filters out null values and ensures the remaining collection is typed as String.

    3. Transform Map values

Suppose we want to increase everyone's score by 5.
Original
final Map<String, int> scores = {
'Atharv': 90,
'Rahul': 75,
'Aditya': 85,
};

Transformation
final updatedScores = scores.map(
(name, score) => MapEntry(name, score + 5),
);

Output
{
'Atharv': 95,
'Rahul': 80,
'Aditya': 90,
}

How does it work?
.map((name, score) => MapEntry(name, score + 5))

- name → current key
- score → current value
- MapEntry() → creates a new key-value pair
- score + 5 → transformed value
  This creates a new Map; the original remains unchanged.

This is a useful canonical pattern for your future null-safe-collections skill.
final validScores = Map.fromEntries(
scores.entries.where((entry) => entry.value != null),
);

7. Transform nullable values into a non-null Map
   If we specifically want Map<String, int>, we can use a pipeline:
   final validScores = Map<String, int>.fromEntries(
   scores.entries
   .where((entry) => entry.value != null)
   .map((entry) => MapEntry(entry.key, entry.value!)),
   );

But notice:
entry.value!

We are using !, which today's goal is to avoid.

A better null-safe approach is:
final validScores = Map<String, int>.fromEntries(
scores.entries
.where((entry) => entry.value != null)
.map((entry) => MapEntry(entry.key, entry.value as int)),
);

conclusion - we just avoid the ! null assertion operatior using the own trasformation methods of set , map , list. so then we cant get ther un time errors.

Your conclusion
Instead of using the null assertion operator !, we use Dart's built-in collection transformation methods to filter, transform, and handle nullable data safely. without mutating.

For example:
Unsafe approach Null-safe transformation
value! whereType<T>()
Assuming values exist where((x) => x != null)
Manual null checks everywhere map(), where(), fold()
Mutating original collection Create a transformed collection
Unsafe access firstWhere() with orElse where appropriate

Handle nullable data without force unwrapping it using !.
We will learn 5 patterns:

1. Null-aware operators
2. Conditional checks
3. ?? fallback values
4. ?. safe access
5. Null-safe collection transformations

! - null Assertion operator - it tells/give gauranty to dart that the value is not null.
? - null aware operator - it tells that it can store null value.

?. = null aware access operator. name?.length() - before accessing the length it first check name is null or not.
?? = null coalescing operator - final displayName = user.name ?? 'Guest'; If user.name is not null → use user.name
Otherwise → use 'Guest'
!=' = explicit null checking '
??= null aware assgnment operator - if the value is null then assign the value.

1. What is a collection pipeline?
   A collection pipeline combines multiple transformations sequentially.
   final result = names
   .whereType<String>()
   .where((name) => name.length > 5)
   .map((name) => name.toUpperCase())
   .toList();
2. Filtering → Transforming → Collecting - this is pattern of pipeline.
   now how we can make a collection trasaformation clean , resuable , and redable.
   instead of writing this repeatedly we can create extension.

what is an extension - extension is allow to add some functionality to an existing type without modifying the orignal type.

few shot canonical snippets - need to teach Ai coding Agent consistently produce the correct code using small, high-quality examples inside a skill.
problem - long explination = Filter null
Transform values.
Avoid !.
Don't mutate collections.
Use typed collections.
Use pipelines.Return the correct collection type.

so i tmeans everytime if he activated skill he need to load this all , instead of this we provide simple canonical exampple.

3. canonical snippet is a simple standard example that your agent should follow when performing similar task.

For DayMark, we want these qualities:

- Null-safe
- No !
- Non-mutating
- Declarative
- Correct types
- Readable pipeline
  This example teaches several behaviors simultaneously.
  Snippet demonstrates Agent learns
  whereType<String>() Remove null values
  .where() Filter data
  .map() Transform elements
  .toList() Return typed List
  .toSet() Deduplicate
  No ! Avoid forced null assertions
  No .add() Avoid mutating original collection
  Extension Reusable functionality

Instead of 500 words of instructions, this compact example acts as a behavioral template.

Nullable collection
↓
Filter nulls
↓
Filter unwanted data
↓
Transform values
↓
Collect result
