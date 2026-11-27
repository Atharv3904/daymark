---
name: dart-model
description: Generate and update null-safe Dart entities and data models with explicit types, fromJson, toJson, copyWith, and bidirectional mapping.
---

# Dart Model & Entity Skill

## Standards: ✓ Clean Architecture · ✓ Null safety · ✓ Explicit types

- **Domain Entity** (`domain/entity/`): Extends `Equatable`, `const` constructor, `final` fields, `props`. No JSON dependencies.
- **Data Model** (`data/model/`): Implements `fromJson(Map<String, dynamic>)`, `toJson()`, `fromEntity()`, `toEntity()`.
- **Types**: Explicit types; cast numbers `(json["id"] as num).toInt()`, parse dates `DateTime.parse()`.
- **Nullable copyWith**: Sentinel `const Object _s = Object();` pattern:
  `phone: identical(phone, _s) ? this.phone : phone as String?`
- **Mapping**: Symmetric `fromEntity` and `toEntity`.

```dart
factory ItemModel.fromJson(Map<String, dynamic> j) => ItemModel(
  id: (j["id"] as num).toInt(),
  title: j["title"] as String,
);
Map<String, dynamic> toJson() => {"id": id, "title": title};
factory ItemModel.fromEntity(ItemEntity e) => ItemModel(id: e.id, title: e.title);
ItemEntity toEntity() => ItemEntity(id: id, title: title);
```
