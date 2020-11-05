import "package:benchmark_harness/benchmark_harness.dart";
import "package:meta/meta.dart";

import "config.dart";
import "table_score_emitter.dart";

abstract class CollectionBenchmarkBase<T> extends BenchmarkBase {
  @override
  final TableScoreEmitter emitter;

  const CollectionBenchmarkBase({
    @required String name,
    @required this.emitter,
  }) : super(name);

  Config get config => emitter.config;

  @override
  void exercise() {
    for (int i = 0; i < config.runs; i++) run();
  }

  /// This will be important for later checking if the resulting mutable
  /// collection processed by the benchmark is indeed the one we expected (TDD).
  @visibleForTesting
  @visibleForOverriding
  T toMutable();
}

abstract class ListBenchmarkBase extends CollectionBenchmarkBase<List<int>> {
  const ListBenchmarkBase({
    @required String name,
    @required TableScoreEmitter emitter,
  }) : super(name: name, emitter: emitter);

  static List<int> getDummyGeneratedList({int size = 10000}) =>
      List<int>.generate(size, (int index) => index);

  @visibleForTesting
  @visibleForOverriding
  @override
  List<int> toMutable();
}

abstract class SetBenchmarkBase extends CollectionBenchmarkBase<Set<int>> {
  const SetBenchmarkBase({
    @required String name,
    @required TableScoreEmitter emitter,
  }) : super(name: name, emitter: emitter);

  static Set<int> getDummyGeneratedSet({int size = 10000}) =>
      Set<int>.of(ListBenchmarkBase.getDummyGeneratedList(size: size));

  @visibleForTesting
  @visibleForOverriding
  @override
  Set<int> toMutable();
}
