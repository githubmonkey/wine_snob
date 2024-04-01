import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/query.dart';

part 'query_multimodal_controller.g.dart';

@Riverpod(keepAlive: true)
class QueryMultimodalController extends _$QueryMultimodalController {
  @override
  MultimediaQuery build() {
    return const MultimediaQuery();
  }

  void updateText({required String? text}) {
    state = state.copyWith(text: text);
  }

  void updateImages({required List<XFile> images}) {
    state = state.copyWith(images: images);
  }
}
