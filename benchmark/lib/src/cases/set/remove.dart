import "dart:math";

import "package:built_collection/built_collection.dart";
import "package:fast_immutable_collections_benchmarks/fast_immutable_collections_benchmarks.dart";
import "package:kt_dart/collection.dart";
import "package:meta/meta.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";

//////////////////////////////////////////////////////////////////////////////////////////////////

class SetRemoveBenchmark extends MultiBenchmarkReporter<SetBenchmarkBase> {
  @override
  final List<SetBenchmarkBase> benchmarks;

  SetRemoveBenchmark({@required TableScoreEmitter emitter})
      : benchmarks = <SetBenchmarkBase>[
          MutableSetRemoveBenchmark(emitter: emitter),
          ISetRemoveBenchmark(emitter: emitter),
          KtSetRemoveBenchmark(emitter: emitter),
          BuiltSetRemoveBenchmark(emitter: emitter),
        ],
        super(emitter: emitter);
}

//////////////////////////////////////////////////////////////////////////////////////////////////

class MutableSetRemoveBenchmark extends SetBenchmarkBase {
  MutableSetRemoveBenchmark({@required TableScoreEmitter emitter})
      : super(name: "Set (Mutable)", emitter: emitter);

  Set<int> set;
  int count;
  List<Set<int>> initialSets;

  @override
  Set<int> toMutable() => set;

  @override
  void setup() {
    count = 0;
    initialSets = [];
    for (int i = 0; i <= max(1, 1000000 ~/ config.size); i++)
      initialSets.add(SetBenchmarkBase.getDummyGeneratedSet(size: config.size));
  }

  @override
  void run() {
    set = getNextSet();
    set.remove((config.size ~/ 2));
  }

  Set<int> getNextSet() {
    if (count >= initialSets.length - 1)
      count = 0;
    else
      count++;
    return initialSets[count];
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////

class ISetRemoveBenchmark extends SetBenchmarkBase {
  ISetRemoveBenchmark({@required TableScoreEmitter emitter})
      : super(name: "ISet", emitter: emitter);

  ISet<int> fixedSet;
  ISet<int> iSet;

  @override
  Set<int> toMutable() => iSet.unlock;

  @override
  void setup() => fixedSet = ISet(SetBenchmarkBase.getDummyGeneratedSet(size: config.size));

  @override
  void run() {
    iSet = fixedSet;
    iSet = iSet.remove((config.size ~/ 2));
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////

class KtSetRemoveBenchmark extends SetBenchmarkBase {
  KtSetRemoveBenchmark({@required TableScoreEmitter emitter})
      : super(name: "KtSet", emitter: emitter);

  KtSet<int> fixedSet;
  KtSet<int> ktSet;

  @override
  Set<int> toMutable() => ktSet.asSet();

  @override
  void setup() => fixedSet = KtSet.from(SetBenchmarkBase.getDummyGeneratedSet(size: config.size));

  @override
  void run() {
    ktSet = fixedSet;
    ktSet = ktSet.minusElement((config.size ~/ 2)).toSet();
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////

class BuiltSetRemoveBenchmark extends SetBenchmarkBase {
  BuiltSetRemoveBenchmark({@required TableScoreEmitter emitter})
      : super(name: "BuiltSet", emitter: emitter);

  BuiltSet<int> fixedSet;
  BuiltSet<int> builtSet;

  @override
  Set<int> toMutable() => builtSet.asSet();

  @override
  void setup() => fixedSet = BuiltSet.of(SetBenchmarkBase.getDummyGeneratedSet(size: config.size));

  @override
  void run() {
    builtSet = fixedSet;
    builtSet =
        fixedSet.rebuild((SetBuilder<int> setBuilder) => setBuilder.remove((config.size ~/ 2)));
  }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
