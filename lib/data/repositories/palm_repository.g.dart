// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'palm_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$palmRepositoryHash() => r'7db33e8221bbb1d3c351b28884afc9e0d7bbbfd3';

/// See also [palmRepository].
@ProviderFor(palmRepository)
final palmRepositoryProvider = Provider<PalmRepository>.internal(
  palmRepository,
  name: r'palmRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$palmRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PalmRepositoryRef = ProviderRef<PalmRepository>;
String _$fetchResultsHash() => r'e6803b1b4b07042f4f909613fbce0928a712300e';

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
    String description,
    Prompt prompt,
  ) {
    return FetchResultsProvider(
      description,
      prompt,
    );
  }

  @override
  FetchResultsProvider getProviderOverride(
    covariant FetchResultsProvider provider,
  ) {
    return call(
      provider.description,
      provider.prompt,
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
    String description,
    Prompt prompt,
  ) : this._internal(
          (ref) => fetchResults(
            ref as FetchResultsRef,
            description,
            prompt,
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
          description: description,
          prompt: prompt,
        );

  FetchResultsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.description,
    required this.prompt,
  }) : super.internal();

  final String description;
  final Prompt prompt;

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
        description: description,
        prompt: prompt,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _FetchResultsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchResultsProvider &&
        other.description == description &&
        other.prompt == prompt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, description.hashCode);
    hash = _SystemHash.combine(hash, prompt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchResultsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `description` of this provider.
  String get description;

  /// The parameter `prompt` of this provider.
  Prompt get prompt;
}

class _FetchResultsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with FetchResultsRef {
  _FetchResultsProviderElement(super.provider);

  @override
  String get description => (origin as FetchResultsProvider).description;
  @override
  Prompt get prompt => (origin as FetchResultsProvider).prompt;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
