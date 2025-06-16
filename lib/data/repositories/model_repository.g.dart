// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$modelRepositoryHash() => r'c0fa028ef5940b96eaaff704f7cae1f80d1df74d';

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

/// See also [modelRepository].
@ProviderFor(modelRepository)
const modelRepositoryProvider = ModelRepositoryFamily();

/// See also [modelRepository].
class ModelRepositoryFamily extends Family<ModelRepository> {
  /// See also [modelRepository].
  const ModelRepositoryFamily();

  /// See also [modelRepository].
  ModelRepositoryProvider call(
    String modelName,
  ) {
    return ModelRepositoryProvider(
      modelName,
    );
  }

  @override
  ModelRepositoryProvider getProviderOverride(
    covariant ModelRepositoryProvider provider,
  ) {
    return call(
      provider.modelName,
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
  String? get name => r'modelRepositoryProvider';
}

/// See also [modelRepository].
class ModelRepositoryProvider extends Provider<ModelRepository> {
  /// See also [modelRepository].
  ModelRepositoryProvider(
    String modelName,
  ) : this._internal(
          (ref) => modelRepository(
            ref as ModelRepositoryRef,
            modelName,
          ),
          from: modelRepositoryProvider,
          name: r'modelRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$modelRepositoryHash,
          dependencies: ModelRepositoryFamily._dependencies,
          allTransitiveDependencies:
              ModelRepositoryFamily._allTransitiveDependencies,
          modelName: modelName,
        );

  ModelRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.modelName,
  }) : super.internal();

  final String modelName;

  @override
  Override overrideWith(
    ModelRepository Function(ModelRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ModelRepositoryProvider._internal(
        (ref) => create(ref as ModelRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        modelName: modelName,
      ),
    );
  }

  @override
  ProviderElement<ModelRepository> createElement() {
    return _ModelRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ModelRepositoryProvider && other.modelName == modelName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, modelName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ModelRepositoryRef on ProviderRef<ModelRepository> {
  /// The parameter `modelName` of this provider.
  String get modelName;
}

class _ModelRepositoryProviderElement extends ProviderElement<ModelRepository>
    with ModelRepositoryRef {
  _ModelRepositoryProviderElement(super.provider);

  @override
  String get modelName => (origin as ModelRepositoryProvider).modelName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
