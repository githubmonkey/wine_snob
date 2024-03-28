import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/controller/query_multimodal_controller.dart';

part 'images_controller.g.dart';

@riverpod
class ImagesController extends _$ImagesController {
  @override
  FutureOr<List<XFile>> build() {
    return <XFile>[];
  }

  Future<void> pickImages() async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() async {
        final images = await ImagePicker()
            .pickMultiImage(maxHeight: 800, maxWidth: 800, imageQuality: 50);
        ref
            .read(queryMultimodalControllerProvider.notifier)
            .updateImages(images: images);
        return images;
      });
    } catch (e, stacktrace) {
      state = AsyncError(e, stacktrace);
    }
  }
}
