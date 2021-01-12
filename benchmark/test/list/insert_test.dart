import "dart:math";

import "package:test/test.dart";

import "package:fast_immutable_collections_benchmarks/fast_immutable_collections_benchmarks.dart";

void main() {
  group("Separate Benchmarks |", () {
    test("List (Mutable)", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "insert_list_mutable", config: Config(size: 100));
      final MutableListInsertBenchmark listInsertBenchmark =
          MutableListInsertBenchmark(emitter: tableScoreEmitter);

      listInsertBenchmark.report();

      final List<int> expectedList = List<int>.generate(100, (int index) => index);
      final int randomInt = Random(0).nextInt(100);
      expectedList.insert(randomInt, randomInt);
      expect(listInsertBenchmark.toMutable(), expectedList);
    });

    test("IList", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "insert_ilist", config: Config(size: 100));
      final IListInsertBenchmark ilistInsertBenchmark =
          IListInsertBenchmark(emitter: tableScoreEmitter);

      ilistInsertBenchmark.report();

      final List<int> expectedList = List<int>.generate(100, (int index) => index);
      final int randomInt = Random(0).nextInt(100);
      expectedList.insert(randomInt, randomInt);
      expect(ilistInsertBenchmark.toMutable(), expectedList);
    });

    test("KtList", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "insert_ktlist", config: Config(size: 100));
      final KtListInsertBenchmark ktListInsertBenchmark =
          KtListInsertBenchmark(emitter: tableScoreEmitter);

      ktListInsertBenchmark.report();

      final List<int> expectedList = List<int>.generate(100, (int index) => index);
      final int randomInt = Random(0).nextInt(100);
      expectedList.insert(randomInt, randomInt);
      expect(ktListInsertBenchmark.toMutable(), expectedList);
    });

    test("BuiltList", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "insert_builtlist", config: Config(size: 100));
      final BuiltListInsertBenchmark builtListInsertBenchmark =
          BuiltListInsertBenchmark(emitter: tableScoreEmitter);

      builtListInsertBenchmark.report();

      final List<int> expectedList = List<int>.generate(100, (int index) => index);
      final int randomInt = Random(0).nextInt(100);
      expectedList.insert(randomInt, randomInt);
      expect(builtListInsertBenchmark.toMutable(), expectedList);
    });
  });

  group("Multiple Benchmarks |", () {
    test("Simple run", () {
      final TableScoreEmitter tableScoreEmitter =
          TableScoreEmitter(prefixName: "insert", config: Config(size: 100));
      final ListInsertBenchmark insertBenchmark = ListInsertBenchmark(emitter: tableScoreEmitter);

      insertBenchmark.report();

      final List<int> expectedList = List<int>.generate(100, (int index) => index);
      final int randomInt = Random(0).nextInt(100);
      expectedList.insert(randomInt, randomInt);
      insertBenchmark.benchmarks
          .forEach((ListBenchmarkBase benchmark) => expect(benchmark.toMutable(), expectedList));
    });
  });
}