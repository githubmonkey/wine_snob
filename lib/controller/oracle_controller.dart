import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/controller/prompt_controller.dart';
import 'package:wine_snob/controller/query_controller.dart';
import 'package:wine_snob/data/repositories/model_repository.dart';
import 'package:wine_snob/domain/models/prompt.dart';

part 'oracle_controller.g.dart';

@riverpod
class OracleController extends _$OracleController {
  Future<List<String>> _fetchResults(String? query, Prompt? prompt) async {
    if (query == null || query.isEmpty || prompt == null) {
      return [];
    }
    return ref.read(palmRepositoryProvider).fetchResults(query, prompt);
  }

  @override
  FutureOr<List<String>> build() {
    return _fetchResults(null, null);
  }

  Future<void> queryPalmAPI() async {
    // Custom_lint is warning "info: Generated providers should only depend on other generated providers. Failing to do so may break rules such as "provider_dependencies". (avoid_manual_providers_as_generated_provider_dependency at [wine_snob] lib/controller/oracle_controller.dart:25)
    // This is odd. Both providers are generated.
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final prompt = ref.read(promptControllerProvider);
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final query = ref.read(queryControllerProvider);

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchResults(query, prompt);
    });
  }

  Future<void> resetResults() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchResults(null, null);
    });
  }
}
