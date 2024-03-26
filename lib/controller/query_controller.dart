import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/query.dart';

part 'query_controller.g.dart';

@Riverpod(keepAlive: true)
class QueryController extends _$QueryController {
  @override
  Query? build() {
    return null;
  }

  void updateInput({required String? input}) {
    state = state?.copyWith(input: input) ??
        Query(input: input, scaffold: TEXT_TEMPLATE);
  }

  void updateScaffold({required String? scaffold}) {
    state = state?.copyWith(scaffold: scaffold) ??
        Query(scaffold: scaffold ?? TEXT_TEMPLATE);
  }
}
