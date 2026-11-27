skill.md file automatically loaded by agents.md

skill.md file needed beacuse build a reusable AI skill that generate dart models/entities automatically when needed. without loading out model-generation instruction/spec.md file into every Ai conversation.

It should help your agent generate:

- Dart Entities
- Data Models
- fromJson()
- toJson()
- copyWith()
- Null-safe fields
- Explicit types
- Entity ↔ Model mapping
- JSON-schema-driven code generation

the skill.md contains the specialized knowledge for generating models.

## staring of skill.md begins with - yaml formatter

name: dart-model
description: Generate and update null-safe Dart entities and data models from JSON schemas or examples, including explicit types, fromJson, toJson, copyWith, and mapping.

---

this helps the agent determine when the skill in relevant.

User Request
│
▼
AI Agent
│
├── Read AGENTS.md
│ │
│ └── Global rules
│
▼
Task Classification
│
▼
Create Dart Model?
│
├── NO → Other workflow
│
└── YES
│
▼
Load dart-model/SKILL.md
│
▼
Analyze JSON/schema
│
▼
Generate Dart code
│
├── Entity
├── Model
├── fromJson()
├── toJson()
├── copyWith()
└── Mapping
│
▼
Verification

what is an on demand skill - on-demand skill is a specialized instructon package that the AI loads when a task matches its purpose.

Antigravity can automatically identify and load a skill when the task matches its description—you don't need to manually mention the SKILL.md path every time.

the token size of this file under 400 tokens.

## The SKILL.md contains frontmatter such as:

name: dart-model
description: Use when creating, modifying, reviewing, or validating Dart entities, models, DTOs, JSON serialization, mappings, or model-related tests.

---

Automatic triggering
You ask:
Create a Task model with id, title, description, dueDate, and isCompleted.

Antigravity's agent:

1. Reads your task.
2. Identifies that it is a Dart model/entity task.
3. Matches it against the skill's description.
4. Loads the relevant SKILL.md instructions.
5. Executes the task using that skill's standards.
