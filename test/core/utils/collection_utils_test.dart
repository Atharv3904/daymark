import 'package:flutter_test/flutter_test.dart';
import 'package:daymark_tracking/core/utils/collection_utils.dart';

void main() {
  group('CollectionUtils', () {
    test(
      'cleanList strips nulls and returns a new list without mutating source',
      () {
        final List<int?> source = [1, null, 2, null, 3];
        final List<int> result = CollectionUtils.cleanList(source);

        expect(result, [1, 2, 3]);
        expect(source, [1, null, 2, null, 3]); // source unchanged
        expect(CollectionUtils.cleanList(null), isEmpty);
      },
    );

    test('sanitizeStrings strips nulls, trims, and removes empty strings', () {
      final List<String?> source = [' flutter ', null, '', '  ', 'dart'];
      final List<String> result = CollectionUtils.sanitizeStrings(source);

      expect(result, ['flutter', 'dart']);
      expect(source.length, 5); // source unchanged
      expect(CollectionUtils.sanitizeStrings(null), isEmpty);
    });

    test('toUniqueSet deduplicates elements and returns a new set', () {
      final List<String?> source = ['a', 'b', null, 'a', 'c', 'b'];
      final Set<String> result = CollectionUtils.toUniqueSet(source);

      expect(result, {'a', 'b', 'c'});
      expect(source.length, 6); // source unchanged
      expect(CollectionUtils.toUniqueSet(null), isEmpty);
    });

    test('transformMap filters and transforms without mutating source', () {
      final Map<String, int> source = {'a': 1, 'b': 2, 'c': 3, 'd': 4};
      final Map<String, String> result =
          CollectionUtils.transformMap<String, int, String>(
            source,
            where: (k, v) => v.isEven,
            transform: (k, v) => 'val-$v',
          );

      expect(result, {'b': 'val-2', 'd': 'val-4'});
      expect(source, {'a': 1, 'b': 2, 'c': 3, 'd': 4}); // source unchanged
      expect(
        CollectionUtils.transformMap<String, int, String>(
          null,
          transform: (k, v) => '',
        ),
        isEmpty,
      );
    });

    test('compactMap removes entries with null key or null value', () {
      final Map<String?, int?> source = {'a': 1, null: 2, 'b': null, 'c': 3};
      final Map<String, int> result = CollectionUtils.compactMap(source);

      expect(result, {'a': 1, 'c': 3});
      expect(CollectionUtils.compactMap(null), isEmpty);
    });

    test('safeSum aggregates numbers safely ignoring nulls', () {
      final List<num?> numbers = [10, null, 20.5, null, 5];
      expect(CollectionUtils.safeSum(numbers), 35.5);
      expect(CollectionUtils.safeSum(null), 0);
      expect(CollectionUtils.safeSum([]), 0);
    });

    test('safeAverage computes average correctly and returns null for empty/null input', () {
      final List<num?> numbers = [10, null, 20, 30];
      expect(CollectionUtils.safeAverage(numbers), 20.0);
      expect(CollectionUtils.safeAverage(null), isNull);
      expect(CollectionUtils.safeAverage([null, null]), isNull);
    });
  });
}
