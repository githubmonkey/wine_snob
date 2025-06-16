// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'oracles_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$oraclesRepositoryHash() => r'd8567b2a529adcbe41a12df1a075fc043ea93bf6';

/// See also [oraclesRepository].
@ProviderFor(oraclesRepository)
final oraclesRepositoryProvider = Provider<OraclesRepository>.internal(
  oraclesRepository,
  name: r'oraclesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$oraclesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OraclesRepositoryRef = ProviderRef<OraclesRepository>;
String _$oraclesQueryHash() => r'fea2e298a857c59f43e10cdd45fcb2c9a8ef4e57';

/// See also [oraclesQuery].
@ProviderFor(oraclesQuery)
final oraclesQueryProvider = AutoDisposeProvider<Query<Oracle>>.internal(
  oraclesQuery,
  name: r'oraclesQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$oraclesQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OraclesQueryRef = AutoDisposeProviderRef<Query<Oracle>>;
String _$oracleStreamHash() => r'5385de42c92d0c13d3672ec6bd75b749b46d6300';

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

/// See also [oracleStream].
@ProviderFor(oracleStream)
const oracleStreamProvider = OracleStreamFamily();

/// See also [oracleStream].
class OracleStreamFamily extends Family<AsyncValue<Oracle>> {
  /// See also [oracleStream].
  const OracleStreamFamily();

  /// See also [oracleStream].
  OracleStreamProvider call(
    String oracleId,
  ) {
    return OracleStreamProvider(
      oracleId,
    );
  }

  @override
  OracleStreamProvider getProviderOverride(
    covariant OracleStreamProvider provider,
  ) {
    return call(
      provider.oracleId,
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
  String? get name => r'oracleStreamProvider';
}

/// See also [oracleStream].
class OracleStreamProvider extends AutoDisposeStreamProvider<Oracle> {
  /// See also [oracleStream].
  OracleStreamProvider(
    String oracleId,
  ) : this._internal(
          (ref) => oracleStream(
            ref as OracleStreamRef,
            oracleId,
          ),
          from: oracleStreamProvider,
          name: r'oracleStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$oracleStreamHash,
          dependencies: OracleStreamFamily._dependencies,
          allTransitiveDependencies:
              OracleStreamFamily._allTransitiveDependencies,
          oracleId: oracleId,
        );

  OracleStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.oracleId,
  }) : super.internal();

  final String oracleId;

  @override
  Override overrideWith(
    Stream<Oracle> Function(OracleStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OracleStreamProvider._internal(
        (ref) => create(ref as OracleStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        oracleId: oracleId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Oracle> createElement() {
    return _OracleStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OracleStreamProvider && other.oracleId == oracleId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, oracleId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OracleStreamRef on AutoDisposeStreamProviderRef<Oracle> {
  /// The parameter `oracleId` of this provider.
  String get oracleId;
}

class _OracleStreamProviderElement
    extends AutoDisposeStreamProviderElement<Oracle> with OracleStreamRef {
  _OracleStreamProviderElement(super.provider);

  @override
  String get oracleId => (origin as OracleStreamProvider).oracleId;
}

String _$oraclesStreamHash() => r'ac03528f8401f329e32cf628729a4ce18a8c82fd';

/// See also [oraclesStream].
@ProviderFor(oraclesStream)
final oraclesStreamProvider = AutoDisposeStreamProvider<List<Oracle>>.internal(
  oraclesStream,
  name: r'oraclesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$oraclesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OraclesStreamRef = AutoDisposeStreamProviderRef<List<Oracle>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
