import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/query.dart';

part 'query_text_controller.g.dart';

@Riverpod(keepAlive: true)
class QueryTextController extends _$QueryTextController {
  @override
  Query build() {
    return const Query();
  }

  void updateInput({required String? input}) {
    state = state.copyWith(input: input);
  }

  void updateScaffold({required String? scaffold}) {
    state = state.copyWith(scaffold: scaffold);
  }
}
