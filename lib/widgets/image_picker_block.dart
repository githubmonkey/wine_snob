import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wine_snob/controller/images_controller.dart';
import 'package:wine_snob/controller/query_multimodal_controller.dart';

class ImagePickerBlock extends StatelessWidget {
  const ImagePickerBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _button(context),
        const SizedBox(width: 4.0),
        _imageBox(context),
      ],
    );
  }

  Widget _button(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final images = ref.watch(imagesControllerProvider).valueOrNull ?? [];
        return SizedBox(
          width: 160,
          child: OutlinedButton.icon(
            onPressed: () =>
                ref.read(imagesControllerProvider.notifier).pickImages(),
            icon: const Icon(Icons.description),
            label: images.isEmpty
                ? const Text('Pick files')
                : const Text('Pick new files'),
          ),
        );
      },
    );
  }

  Widget _imageBox(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150.0,
        constraints:
            const BoxConstraints(minHeight: 150, minWidth: double.infinity),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(child: _imageBoxContent(context)),
      ),
    );
  }

  Widget _imageBoxContent(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final images = ref.watch(
            queryMultimodalControllerProvider.select((query) => query.images));

        print('rebuild box for ${images.length} images');
        if (images.isEmpty) {
          return const Text('Your image here');
        } else {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            //shrinkWrap: true,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) => SizedBox(
              width: 150.0,
              height: 150.0,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: images[index].path,
                fit: BoxFit.cover,
                width: 150.0,
                height: 150.0,
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 4.0),
          );
        }
      },
    );
  }
}
