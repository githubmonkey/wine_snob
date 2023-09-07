// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompts_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$promptsRepositoryHash() => r'705febec66b7c894b450d954d21498d3df346183';

/// See also [promptsRepository].
@ProviderFor(promptsRepository)
final promptsRepositoryProvider = Provider<PromptsRepository>.internal(
  promptsRepository,
  name: r'promptsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$promptsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PromptsRepositoryRef = ProviderRef<PromptsRepository>;
String _$promptsQueryHash() => r'f9648ccdb2a71240c4d8db8ccd5c1ab831d6fc26';

/// See also [promptsQuery].
@ProviderFor(promptsQuery)
final promptsQueryProvider = AutoDisposeProvider<Query<Prompt>>.internal(
  promptsQuery,
  name: r'promptsQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$promptsQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PromptsQueryRef = AutoDisposeProviderRef<Query<Prompt>>;
String _$promptStreamHash() => r'346a373c3ba5e3c49f310264f0fba19cb6eb8ea5';

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

/// See also [promptStream].
@ProviderFor(promptStream)
const promptStreamProvider = PromptStreamFamily();

/// See also [promptStream].
class PromptStreamFamily extends Family<AsyncValue<Prompt>> {
  /// See also [promptStream].
  const PromptStreamFamily();

  /// See also [promptStream].
  PromptStreamProvider call(
    String promptId,
  ) {
    return PromptStreamProvider(
      promptId,
    );
  }

  @override
  PromptStreamProvider getProviderOverride(
    covariant PromptStreamProvider provider,
  ) {
    return call(
      provider.promptId,
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
  String? get name => r'promptStreamProvider';
}

/// See also [promptStream].
class PromptStreamProvider extends AutoDisposeStreamProvider<Prompt> {
  /// See also [promptStream].
  PromptStreamProvider(
    String promptId,
  ) : this._internal(
          (ref) => promptStream(
            ref as PromptStreamRef,
            promptId,
          ),
          from: promptStreamProvider,
          name: r'promptStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$promptStreamHash,
          dependencies: PromptStreamFamily._dependencies,
          allTransitiveDependencies:
              PromptStreamFamily._allTransitiveDependencies,
          promptId: promptId,
        );

  PromptStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.promptId,
  }) : super.internal();

  final String promptId;

  @override
  Override overrideWith(
    Stream<Prompt> Function(PromptStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PromptStreamProvider._internal(
        (ref) => create(ref as PromptStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        promptId: promptId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Prompt> createElement() {
    return _PromptStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PromptStreamProvider && other.promptId == promptId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, promptId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PromptStreamRef on AutoDisposeStreamProviderRef<Prompt> {
  /// The parameter `promptId` of this provider.
  String get promptId;
}

class _PromptStreamProviderElement
    extends AutoDisposeStreamProviderElement<Prompt> with PromptStreamRef {
  _PromptStreamProviderElement(super.provider);

  @override
  String get promptId => (origin as PromptStreamProvider).promptId;
}

String _$promptsStreamHash() => r'92dc73c5e03b87f956645790b758309527b381c7';

/// See also [promptsStream].
@ProviderFor(promptsStream)
final promptsStreamProvider = AutoDisposeStreamProvider<List<Prompt>>.internal(
  promptsStream,
  name: r'promptsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$promptsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PromptsStreamRef = AutoDisposeStreamProviderRef<List<Prompt>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
