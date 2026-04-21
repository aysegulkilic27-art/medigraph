// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$measurementBoxHash() => r'7ffb33c5ab761525967700cebf12cd5f09e51f7c';

/// See also [measurementBox].
@ProviderFor(measurementBox)
final measurementBoxProvider =
    AutoDisposeProvider<Box<MeasurementHiveModel>>.internal(
  measurementBox,
  name: r'measurementBoxProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$measurementBoxHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MeasurementBoxRef = AutoDisposeProviderRef<Box<MeasurementHiveModel>>;
String _$measurementRepositoryHash() =>
    r'42c885b1028e4b5166d4f61dc797fc85edf0ebda';

/// See also [measurementRepository].
@ProviderFor(measurementRepository)
final measurementRepositoryProvider =
    AutoDisposeProvider<MeasurementRepository>.internal(
  measurementRepository,
  name: r'measurementRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$measurementRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MeasurementRepositoryRef
    = AutoDisposeProviderRef<MeasurementRepository>;
String _$addMeasurementUseCaseHash() =>
    r'fe1f3cbb0204d0048b428ccfc3526ae7a2a29d69';

/// See also [addMeasurementUseCase].
@ProviderFor(addMeasurementUseCase)
final addMeasurementUseCaseProvider =
    AutoDisposeProvider<AddMeasurementUseCase>.internal(
  addMeasurementUseCase,
  name: r'addMeasurementUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addMeasurementUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AddMeasurementUseCaseRef
    = AutoDisposeProviderRef<AddMeasurementUseCase>;
String _$allMeasurementsHash() => r'30798112fd27a7a52cbc68a54253d09ca2989572';

/// See also [allMeasurements].
@ProviderFor(allMeasurements)
final allMeasurementsProvider =
    AutoDisposeFutureProvider<List<Measurement>>.internal(
  allMeasurements,
  name: r'allMeasurementsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allMeasurementsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllMeasurementsRef = AutoDisposeFutureProviderRef<List<Measurement>>;
String _$filteredMeasurementsHash() =>
    r'9027ad3f4a9df12d4589d5033b63b1f6d4aa88a4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [filteredMeasurements].
@ProviderFor(filteredMeasurements)
const filteredMeasurementsProvider = FilteredMeasurementsFamily();

/// See also [filteredMeasurements].
class FilteredMeasurementsFamily extends Family<AsyncValue<List<Measurement>>> {
  /// See also [filteredMeasurements].
  const FilteredMeasurementsFamily();

  /// See also [filteredMeasurements].
  FilteredMeasurementsProvider call({
    required MeasurementType type,
    required DateRange range,
  }) {
    return FilteredMeasurementsProvider(
      type: type,
      range: range,
    );
  }

  @override
  FilteredMeasurementsProvider getProviderOverride(
    covariant FilteredMeasurementsProvider provider,
  ) {
    return call(
      type: provider.type,
      range: provider.range,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'filteredMeasurementsProvider';
}

/// See also [filteredMeasurements].
class FilteredMeasurementsProvider
    extends AutoDisposeFutureProvider<List<Measurement>> {
  /// See also [filteredMeasurements].
  FilteredMeasurementsProvider({
    required MeasurementType type,
    required DateRange range,
  }) : this._internal(
          (ref) => filteredMeasurements(
            ref as FilteredMeasurementsRef,
            type: type,
            range: range,
          ),
          from: filteredMeasurementsProvider,
          name: r'filteredMeasurementsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filteredMeasurementsHash,
          dependencies: FilteredMeasurementsFamily._dependencies,
          allTransitiveDependencies:
              FilteredMeasurementsFamily._allTransitiveDependencies,
          type: type,
          range: range,
        );

  FilteredMeasurementsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.range,
  }) : super.internal();

  final MeasurementType type;
  final DateRange range;

  @override
  Override overrideWith(
    FutureOr<List<Measurement>> Function(FilteredMeasurementsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FilteredMeasurementsProvider._internal(
        (ref) => create(ref as FilteredMeasurementsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        range: range,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Measurement>> createElement() {
    return _FilteredMeasurementsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilteredMeasurementsProvider &&
        other.type == type &&
        other.range == range;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, range.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredMeasurementsRef
    on AutoDisposeFutureProviderRef<List<Measurement>> {
  /// The parameter `type` of this provider.
  MeasurementType get type;

  /// The parameter `range` of this provider.
  DateRange get range;
}

class _FilteredMeasurementsProviderElement
    extends AutoDisposeFutureProviderElement<List<Measurement>>
    with FilteredMeasurementsRef {
  _FilteredMeasurementsProviderElement(super.provider);

  @override
  MeasurementType get type => (origin as FilteredMeasurementsProvider).type;
  @override
  DateRange get range => (origin as FilteredMeasurementsProvider).range;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
