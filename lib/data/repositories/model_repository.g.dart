// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$modelRepositoryHash() => r'44e446a74140145ceb7bbac9ff127d61d1a3329e';

/// See also [modelRepository].
@ProviderFor(modelRepository)
final modelRepositoryProvider = Provider<ModelRepository>.internal(
  modelRepository,
  name: r'modelRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$modelRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ModelRepositoryRef = ProviderRef<ModelRepository>;
String _$fetchResultsHash() => r'80369054ce76e9bc7ef3c0c63b6a181e1c8317b6';

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

/// See also [fetchResults].
@ProviderFor(fetchResults)
const fetchResultsProvider = FetchResultsFamily();

/// See also [fetchResults].
class FetchResultsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [fetchResults].
  const FetchResultsFamily();

  /// See also [fetchResults].
  FetchResultsProvider call(
    Iterable<Content> content,
  ) {
    return FetchResultsProvider(
      content,
    );
  }

  @override
  FetchResultsProvider getProviderOverride(
    covariant FetchResultsProvider provider,
  ) {
    return call(
      provider.content,
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
  String? get name => r'fetchResultsProvider';
}

/// See also [fetchResults].
class FetchResultsProvider extends AutoDisposeFutureProvider<List<String>> {
  /// See also [fetchResults].
  FetchResultsProvider(
    Iterable<Content> content,
  ) : this._internal(
          (ref) => fetchResults(
            ref as FetchResultsRef,
            content,
          ),
          from: fetchResultsProvider,
          name: r'fetchResultsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchResultsHash,
          dependencies: FetchResultsFamily._dependencies,
          allTransitiveDependencies:
              FetchResultsFamily._allTransitiveDependencies,
          content: content,
        );

  FetchResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.content,
  }) : super.internal();

  final Iterable<Content> content;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(FetchResultsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchResultsProvider._internal(
        (ref) => create(ref as FetchResultsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        content: content,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _FetchResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchResultsProvider && other.content == content;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, content.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchResultsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `content` of this provider.
  Iterable<Content> get content;
}

class _FetchResultsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with FetchResultsRef {
  _FetchResultsProviderElement(super.provider);

  @override
  Iterable<Content> get content => (origin as FetchResultsProvider).content;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
