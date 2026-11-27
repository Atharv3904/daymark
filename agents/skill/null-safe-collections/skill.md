---
name: null-safe-collections
description: Transform, filter, map, aggregate, flatten, and deduplicate Dart List, Map, and Set collections safely without mutation or null assertion (!).
---

# Null-Safe Collections Skill

## Standards: ✓ No `!` · ✓ Non-mutating · ✓ Explicit types · ✓ Null-safe

- **Immutable**: Never mutate source collections. Always return new collections (`toList()`, `toSet()`).
- **Null Filtering**: Use `whereType<T>()` to strip `null` and narrow `Iterable<T?>` to `Iterable<T>`.
- **Safe Navigation**: Use `?.`, `??`, and `fold` with explicit initial values for aggregations.
- **Maps & Sets**: Use `Map.fromEntries()` for map filtering/mapping; `.toSet()` for deduplication.
- **Empty Filtering**: Check `.trim().isNotEmpty` after null stripping.

```dart
// Canonical pipeline: null-removal, empty-removal, transform, deduplicate
List<String> sanitizeTags(List<String?>? raw) {
  if (raw == null || raw.isEmpty) return const <String>[];
  return raw
      .whereType<String>()
      .map((s) => s.trim().toLowerCase())
      .where((s) => s.isNotEmpty)
      .toSet()
      .toList();
}
```
