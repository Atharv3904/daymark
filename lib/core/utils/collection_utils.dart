// lib/core/utils/collection_utils.dart
//
// Reusable, non-mutating, null-safe collection transformations for DayMark.
// Follows strict null safety: zero null assertions (!), pure transformations,
// and immutability of input collections.

/// Collection utilities providing safe, non-mutating transformations.
class CollectionUtils {
  const CollectionUtils._();

  /// 1. Nullable List -> clean List
  /// Filters out nulls and returns a new non-null [List<T>].
  /// Never mutates the original collection.
  static List<T> cleanList<T>(Iterable<T?>? source) {
    if (source == null) return <T>[];
    return source.whereType<T>().toList();
  }

  /// Sanitizes a string list: strips nulls, trims, optionally removes empty strings,
  /// and returns a new [List<String>].
  static List<String> sanitizeStrings(
    Iterable<String?>? source, {
    bool removeEmpty = true,
  }) {
    if (source == null) return const <String>[];
    return source
        .whereType<String>()
        .map((s) => s.trim())
        .where((s) => !removeEmpty || s.isNotEmpty)
        .toList();
  }

  /// 2. List -> unique Set
  /// Deduplicates elements and strips nulls into a new [Set<T>].
  /// The original iterable is untouched.
  static Set<T> toUniqueSet<T>(Iterable<T?>? source) {
    if (source == null) return <T>{};
    return source.whereType<T>().toSet();
  }

  /// 3. Map -> filtered/transformed Map
  /// Transforms values and filters entries safely, returning a new [Map<K, R>].
  /// Does not modify [source].
  static Map<K, R> transformMap<K, V, R>(
    Map<K, V>? source, {
    bool Function(K key, V value)? where,
    required R Function(K key, V value) transform,
  }) {
    if (source == null || source.isEmpty) return <K, R>{};

    return Map<K, R>.fromEntries(
      source.entries
          .where((entry) => where == null || where(entry.key, entry.value))
          .map(
            (entry) => MapEntry(entry.key, transform(entry.key, entry.value)),
          ),
    );
  }

  /// Filters out entries with null keys or null values from a map.
  static Map<K, V> compactMap<K, V>(Map<K?, V?>? source) {
    if (source == null || source.isEmpty) return <K, V>{};

    final Map<K, V> result = <K, V>{};
    for (final MapEntry<K?, V?> entry in source.entries) {
      final K? key = entry.key;
      final V? value = entry.value;
      if (key != null && value != null) {
        result[key] = value;
      }
    }
    return result;
  }

  /// 4. Nullable numeric collection -> safe aggregation
  /// Safely sums numbers ignoring nulls. Returns [num].
  static num safeSum(Iterable<num?>? numbers) {
    if (numbers == null) return 0;
    return numbers.whereType<num>().fold<num>(0, (sum, n) => sum + n);
  }

  /// Safely computes the average of numbers ignoring nulls.
  /// Returns `null` if the collection is null or has no valid numbers.
  static double? safeAverage(Iterable<num?>? numbers) {
    if (numbers == null) return null;
    final List<num> validNumbers = numbers.whereType<num>().toList();
    if (validNumbers.isEmpty) return null;
    final num sum = validNumbers.fold<num>(0, (acc, n) => acc + n);
    return sum / validNumbers.length;
  }
}
