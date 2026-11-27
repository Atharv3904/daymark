---
name: flutter-model-entity-separation
description: Enforces appropriate Model and Entity separation across Flutter feature modules while allowing reuse when data structures and responsibilities are genuinely identical.
---

# Model & Entity Separation

- Maintain separate Model and Entity files when their structures, responsibilities, or data requirements differ.
- Reuse an existing Model or Entity when the data structure and purpose are genuinely identical.
- Do not force unrelated modules to share Models or Entities merely because some fields are similar.
- Keep Models responsible for data-layer representation, serialization, deserialization, and API mapping.
- Keep Entities responsible for domain-layer data representation.
- Maintain clear mapping between Models and Entities when required.
- Follow existing feature architecture, naming conventions, and folder structures.
- Avoid unnecessary duplicate classes, files, abstractions, or mapping logic.
- Before creating new files, inspect existing Models and Entities for possible reuse.

## Rule

Reuse Models and Entities only when their structures and responsibilities genuinely match. Otherwise, maintain separate module-specific files to preserve clear architecture and avoid unwanted coupling.
