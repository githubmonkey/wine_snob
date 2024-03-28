import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

const TEXT_TEMPLATE =
    'Write tasting notes for $INPUT_PLACEHOLDER. The tasting notes should be '
    'in the style of a wine critic and should mention the wine style, taste, '
    'and production process. Keep the result to one paragraph.';

const MULTIMODAL_TEXT =
    'Identify all wine bottles in the pictures. For each wine, provide details '
    'such as name, vineyard, vintage, grapes and process. '
    'For each wine, then generate tasting notes in the style of a wine critic. '
    'The tasting notes should mention the style '
    'of the wine, the tasting profile, and the production process. '
    'Keep the results to one paragraph per wine.';

const INPUT_PLACEHOLDER = '\${input}';

// This includes the text portions of a query. The images needed for a
// multimodal query are kept seperately in a List<XFile>
class Query extends Equatable {
  final String? input;

  // defaults to TEXT_TEMPLATE
  // TODO: make this optional?
  final String scaffold;

  // defaults to MULTIMODAL_TEXT
  final String text;

  // TODO: change type
  final List<XFile> images;

  const Query({
    this.input,
    this.scaffold = TEXT_TEMPLATE,
    this.text = MULTIMODAL_TEXT,
    this.images = const [],
  });

  @override
  List<Object?> get props => [input, scaffold, text, images];

  Query copyWith({input, scaffold, text, images}) => Query(
        input: input ?? this.input,
        scaffold: scaffold ?? this.scaffold,
        text: text ?? this.text,
        images: images ?? this.images,
      );

  Content toContentForText() {
    var finalText =
        _sanitizeInput(scaffold.replaceAll(INPUT_PLACEHOLDER, input ?? ''));

    return Content.text(finalText);
    // same as this
    // return Content.multi(parts);
  }

  Future<Content> toContentForMultimodal() async {
    var finalText = _sanitizeInput(text);

    final imageTuples = await _fetchImagesData(images);
    final List<Part> parts = [
      TextPart(finalText),
      ...imageTuples.map((tuple) => DataPart(tuple.$1, tuple.$2)),
    ];

    return Content.multi(parts);
  }

  Future<List<(String, Uint8List)>> _fetchImagesData(List<XFile> images) async {
    final List<(String, Uint8List)> imageTuples = [];
    for (final i in images) {
      imageTuples.add((i.mimeType ?? '', await i.readAsBytes()));
      // print('resolved for image $i(${i.name}, ${i.path}, ${i.mimeType}');
    }
    return imageTuples;
  }

  String _sanitizeInput(String string) {
    // TODO: is this still required when using the api?
    return string.replaceAll("\n", " ").replaceAll("\"", "'").trim();
  }

  static String prettyPrint(Content? content) {
    if (content == null) {
      return '';
    }
    const encoder = JsonEncoder.withIndent("  ");
    return encoder.convert(content.toJson());
  }
}
