import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/controller/query_multimodal_controller.dart';
import 'package:wine_snob/data/repositories/model_repository.dart';

part 'oracle_multimedia_controller.g.dart';

@riverpod
class OracleMultimediaController extends _$OracleMultimediaController {
  @override
  FutureOr<List<String>> build() {
    return [];
  }

  Future<void> queryModel() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final query = ref.read(queryMultimodalControllerProvider);
      final content = await query.toContentForMultimodal();
      return ref
          .read(modelRepositoryProvider(ModelType.multimodal))
          .fetchResults([content]);
    });
  }

  void resetResults() {
    state = const AsyncValue.data([]);
  }
}
