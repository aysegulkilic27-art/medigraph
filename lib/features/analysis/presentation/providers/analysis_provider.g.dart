// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analysis_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedDateRangeHash() => r'dcf257c6aaf98704f77ffc86f0d21efb1304c1d5';

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

/// See also [selectedDateRange].
@ProviderFor(selectedDateRange)
const selectedDateRangeProvider = SelectedDateRangeFamily();

/// See also [selectedDateRange].
class SelectedDateRangeFamily extends Family<DateTimeRange> {
  /// See also [selectedDateRange].
  const SelectedDateRangeFamily();

  /// See also [selectedDateRange].
  SelectedDateRangeProvider call({
    required int tabIndex,
  }) {
    return SelectedDateRangeProvider(
      tabIndex: tabIndex,
    );
  }

  @override
  SelectedDateRangeProvider getProviderOverride(
    covariant SelectedDateRangeProvider provider,
  ) {
    return call(
      tabIndex: provider.tabIndex,
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
  String? get name => r'selectedDateRangeProvider';
}

/// See also [selectedDateRange].
class SelectedDateRangeProvider extends AutoDisposeProvider<DateTimeRange> {
  /// See also [selectedDateRange].
  SelectedDateRangeProvider({
    required int tabIndex,
  }) : this._internal(
          (ref) => selectedDateRange(
            ref as SelectedDateRangeRef,
            tabIndex: tabIndex,
          ),
          from: selectedDateRangeProvider,
          name: r'selectedDateRangeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$selectedDateRangeHash,
          dependencies: SelectedDateRangeFamily._dependencies,
          allTransitiveDependencies:
              SelectedDateRangeFamily._allTransitiveDependencies,
          tabIndex: tabIndex,
        );

  SelectedDateRangeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tabIndex,
  }) : super.internal();

  final int tabIndex;

  @override
  Override overrideWith(
    DateTimeRange Function(SelectedDateRangeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedDateRangeProvider._internal(
        (ref) => create(ref as SelectedDateRangeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tabIndex: tabIndex,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<DateTimeRange> createElement() {
    return _SelectedDateRangeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedDateRangeProvider && other.tabIndex == tabIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tabIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SelectedDateRangeRef on AutoDisposeProviderRef<DateTimeRange> {
  /// The parameter `tabIndex` of this provider.
  int get tabIndex;
}

class _SelectedDateRangeProviderElement
    extends AutoDisposeProviderElement<DateTimeRange>
    with SelectedDateRangeRef {
  _SelectedDateRangeProviderElement(super.provider);

  @override
  int get tabIndex => (origin as SelectedDateRangeProvider).tabIndex;
}

String _$filteredMeasurementsHash() =>
    r'9ff3b6801cb715cd574246799d5491c40af328da';

/// See also [filteredMeasurements].
@ProviderFor(filteredMeasurements)
const filteredMeasurementsProvider = FilteredMeasurementsFamily();

/// See also [filteredMeasurements].
class FilteredMeasurementsFamily extends Family<AsyncValue<List<Measurement>>> {
  /// See also [filteredMeasurements].
  const FilteredMeasurementsFamily();

  /// See also [filteredMeasurements].
  FilteredMeasurementsProvider call({
    required AnalysisCategory category,
    required int tabIndex,
  }) {
    return FilteredMeasurementsProvider(
      category: category,
      tabIndex: tabIndex,
    );
  }

  @override
  FilteredMeasurementsProvider getProviderOverride(
    covariant FilteredMeasurementsProvider provider,
  ) {
    return call(
      category: provider.category,
      tabIndex: provider.tabIndex,
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
    required AnalysisCategory category,
    required int tabIndex,
  }) : this._internal(
          (ref) => filteredMeasurements(
            ref as FilteredMeasurementsRef,
            category: category,
            tabIndex: tabIndex,
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
          category: category,
          tabIndex: tabIndex,
        );

  FilteredMeasurementsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
    required this.tabIndex,
  }) : super.internal();

  final AnalysisCategory category;
  final int tabIndex;

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
        category: category,
        tabIndex: tabIndex,
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
        other.category == category &&
        other.tabIndex == tabIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, tabIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilteredMeasurementsRef
    on AutoDisposeFutureProviderRef<List<Measurement>> {
  /// The parameter `category` of this provider.
  AnalysisCategory get category;

  /// The parameter `tabIndex` of this provider.
  int get tabIndex;
}

class _FilteredMeasurementsProviderElement
    extends AutoDisposeFutureProviderElement<List<Measurement>>
    with FilteredMeasurementsRef {
  _FilteredMeasurementsProviderElement(super.provider);

  @override
  AnalysisCategory get category =>
      (origin as FilteredMeasurementsProvider).category;
  @override
  int get tabIndex => (origin as FilteredMeasurementsProvider).tabIndex;
}

String _$categoryStatsHash() => r'fdd1e753f5aa2ef3e07a265baa85926e23bed41f';

/// See also [categoryStats].
@ProviderFor(categoryStats)
const categoryStatsProvider = CategoryStatsFamily();

/// See also [categoryStats].
class CategoryStatsFamily extends Family<AsyncValue<CategoryStats>> {
  /// See also [categoryStats].
  const CategoryStatsFamily();

  /// See also [categoryStats].
  CategoryStatsProvider call({
    required AnalysisCategory category,
    required int tabIndex,
  }) {
    return CategoryStatsProvider(
      category: category,
      tabIndex: tabIndex,
    );
  }

  @override
  CategoryStatsProvider getProviderOverride(
    covariant CategoryStatsProvider provider,
  ) {
    return call(
      category: provider.category,
      tabIndex: provider.tabIndex,
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
  String? get name => r'categoryStatsProvider';
}

/// See also [categoryStats].
class CategoryStatsProvider extends AutoDisposeFutureProvider<CategoryStats> {
  /// See also [categoryStats].
  CategoryStatsProvider({
    required AnalysisCategory category,
    required int tabIndex,
  }) : this._internal(
          (ref) => categoryStats(
            ref as CategoryStatsRef,
            category: category,
            tabIndex: tabIndex,
          ),
          from: categoryStatsProvider,
          name: r'categoryStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryStatsHash,
          dependencies: CategoryStatsFamily._dependencies,
          allTransitiveDependencies:
              CategoryStatsFamily._allTransitiveDependencies,
          category: category,
          tabIndex: tabIndex,
        );

  CategoryStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
    required this.tabIndex,
  }) : super.internal();

  final AnalysisCategory category;
  final int tabIndex;

  @override
  Override overrideWith(
    FutureOr<CategoryStats> Function(CategoryStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryStatsProvider._internal(
        (ref) => create(ref as CategoryStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
        tabIndex: tabIndex,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CategoryStats> createElement() {
    return _CategoryStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryStatsProvider &&
        other.category == category &&
        other.tabIndex == tabIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, tabIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryStatsRef on AutoDisposeFutureProviderRef<CategoryStats> {
  /// The parameter `category` of this provider.
  AnalysisCategory get category;

  /// The parameter `tabIndex` of this provider.
  int get tabIndex;
}

class _CategoryStatsProviderElement
    extends AutoDisposeFutureProviderElement<CategoryStats>
    with CategoryStatsRef {
  _CategoryStatsProviderElement(super.provider);

  @override
  AnalysisCategory get category => (origin as CategoryStatsProvider).category;
  @override
  int get tabIndex => (origin as CategoryStatsProvider).tabIndex;
}

String _$categoryBarGroupsHash() => r'a250adf0b52c5dc5dac549f794e854217071eec4';

/// See also [categoryBarGroups].
@ProviderFor(categoryBarGroups)
const categoryBarGroupsProvider = CategoryBarGroupsFamily();

/// See also [categoryBarGroups].
class CategoryBarGroupsFamily
    extends Family<AsyncValue<List<BarChartGroupData>>> {
  /// See also [categoryBarGroups].
  const CategoryBarGroupsFamily();

  /// See also [categoryBarGroups].
  CategoryBarGroupsProvider call({
    required AnalysisCategory category,
    required int tabIndex,
  }) {
    return CategoryBarGroupsProvider(
      category: category,
      tabIndex: tabIndex,
    );
  }

  @override
  CategoryBarGroupsProvider getProviderOverride(
    covariant CategoryBarGroupsProvider provider,
  ) {
    return call(
      category: provider.category,
      tabIndex: provider.tabIndex,
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
  String? get name => r'categoryBarGroupsProvider';
}

/// See also [categoryBarGroups].
class CategoryBarGroupsProvider
    extends AutoDisposeFutureProvider<List<BarChartGroupData>> {
  /// See also [categoryBarGroups].
  CategoryBarGroupsProvider({
    required AnalysisCategory category,
    required int tabIndex,
  }) : this._internal(
          (ref) => categoryBarGroups(
            ref as CategoryBarGroupsRef,
            category: category,
            tabIndex: tabIndex,
          ),
          from: categoryBarGroupsProvider,
          name: r'categoryBarGroupsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryBarGroupsHash,
          dependencies: CategoryBarGroupsFamily._dependencies,
          allTransitiveDependencies:
              CategoryBarGroupsFamily._allTransitiveDependencies,
          category: category,
          tabIndex: tabIndex,
        );

  CategoryBarGroupsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
    required this.tabIndex,
  }) : super.internal();

  final AnalysisCategory category;
  final int tabIndex;

  @override
  Override overrideWith(
    FutureOr<List<BarChartGroupData>> Function(CategoryBarGroupsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CategoryBarGroupsProvider._internal(
        (ref) => create(ref as CategoryBarGroupsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
        tabIndex: tabIndex,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<BarChartGroupData>> createElement() {
    return _CategoryBarGroupsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryBarGroupsProvider &&
        other.category == category &&
        other.tabIndex == tabIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);
    hash = _SystemHash.combine(hash, tabIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryBarGroupsRef
    on AutoDisposeFutureProviderRef<List<BarChartGroupData>> {
  /// The parameter `category` of this provider.
  AnalysisCategory get category;

  /// The parameter `tabIndex` of this provider.
  int get tabIndex;
}

class _CategoryBarGroupsProviderElement
    extends AutoDisposeFutureProviderElement<List<BarChartGroupData>>
    with CategoryBarGroupsRef {
  _CategoryBarGroupsProviderElement(super.provider);

  @override
  AnalysisCategory get category =>
      (origin as CategoryBarGroupsProvider).category;
  @override
  int get tabIndex => (origin as CategoryBarGroupsProvider).tabIndex;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
