import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/controller/query_text_controller.dart';
import 'package:wine_snob/data/repositories/model_repository.dart';

part 'oracle_text_controller.g.dart';

@riverpod
class OracleTextController extends _$OracleTextController {
  @override
  FutureOr<List<String>> build() {
    return [];
  }

  Future<void> queryModel() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final query = ref.read(queryTextControllerProvider);
      final content = query.toContent();
      return ref
          .read(modelRepositoryProvider(ModelType.text))
          .fetchResults([content]);
    });
  }

  void resetResults() {
    state = const AsyncValue.data([]);
  }
}
