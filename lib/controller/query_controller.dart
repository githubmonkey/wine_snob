import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_controller.g.dart';

@Riverpod(keepAlive: true)
class QueryController extends _$QueryController {
  @override
  String? build() {
    return null;
  }

  void updateQuery({required String? query}) {
    state = query;
  }
}
