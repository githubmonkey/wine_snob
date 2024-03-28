import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/controller/query_controller.dart';
import 'package:wine_snob/data/repositories/model_repository.dart';
import 'package:wine_snob/domain/models/query.dart';

part 'oracle_controller.g.dart';

@riverpod
class OracleController extends _$OracleController {
  Future<List<String>> _fetchResults(Query? query) async {
    if (query == null) {
      return [];
    }

    final content = query.toContent();
    return ref.read(modelRepositoryProvider).fetchResults([content]);
  }

  @override
  FutureOr<List<String>> build() {
    return _fetchResults(null);
  }

  Future<void> queryModel() async {
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
