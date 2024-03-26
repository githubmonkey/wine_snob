import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/controller/query_controller.dart';
import 'package:wine_snob/data/repositories/model_repository.dart';

part 'oracle_controller.g.dart';

@riverpod
class OracleController extends _$OracleController {
  Future<List<String>> _fetchResults(String? query) async {
    if (query == null || query.isEmpty) {
      return [];
    }
    return ref.read(modelRepositoryProvider).fetchResults(query);
  }

  @override
  FutureOr<List<String>> build() {
    return _fetchResults(null);
  }

  Future<void> queryModel() async {
    // Custom_lint is warning "info: Generated providers should only depend on other generated providers. Failing to do so may break rules such as "provider_dependencies". (avoid_manual_providers_as_generated_provider_dependency at [wine_snob] lib/controller/oracle_controller.dart:25)
    // This is odd. Both providers are generated.
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final query = ref.read(queryControllerProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchResults(query);
    });
  }

  Future<void> resetResults() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchResults(null);
    });
  }
}
