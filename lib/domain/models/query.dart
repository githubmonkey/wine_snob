import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:firebase_ai/firebase_ai.dart';
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

abstract class BaseQuery extends Equatable {
  const BaseQuery();

  String toPrettyPrintedContent();

  Future<Map<String, dynamic>> dataForHistory();

  static String _sanitizeInput(String string) {
    // TODO: is this still required when using the api?
    return string.replaceAll("\n", " ").replaceAll("\"", "'").trim();
  }
}

class TextQuery extends BaseQuery {
  final String? input;
  final String scaffold;

  const TextQuery({
    this.input,
    this.scaffold = TEXT_TEMPLATE,
  });

  @override
  List<Object?> get props => [input, scaffold];

  TextQuery copyWith({input, scaffold}) => TextQuery(
        input: input ?? this.input,
        scaffold: scaffold ?? this.scaffold,
      );

  Content toContent() {
    var finalText = BaseQuery._sanitizeInput(
        scaffold.replaceAll(INPUT_PLACEHOLDER, input ?? ''));

    // same as this
    // return Content.multi(parts);
    return Content.text(finalText);
  }

  @override
  String toPrettyPrintedContent() {
    final content = toContent();

    const encoder = JsonEncoder.withIndent("  ");
    return encoder.convert(content.toJson());
  }

  @override
  Future<Map<String, dynamic>> dataForHistory() async {
    return {
      'input': input,
      'content': toPrettyPrintedContent(),
    };
  }
}

class MultimediaQuery extends BaseQuery {
  final String text;
  final List<XFile> images;

  const MultimediaQuery({
    this.text = MULTIMODAL_TEXT,
    this.images = const [],
  });

  @override
  List<Object?> get props => [text, images];

  MultimediaQuery copyWith({text, images}) => MultimediaQuery(
        text: text ?? this.text,
        images: images ?? this.images,
      );

  Future<Content> toContent() async {
    var finalText = BaseQuery._sanitizeInput(text);

    final List<(String, Uint8List)> imageTuples = [];
    for (final i in images) {
      imageTuples.add((i.mimeType ?? '', await i.readAsBytes()));
    }

    final List<Part> parts = [
      ...imageTuples.map((tuple) => InlineDataPart(tuple.$1, tuple.$2)),
      TextPart(finalText),
    ];

    return Content.multi(parts);
  }

  @override
  String toPrettyPrintedContent() {
    var finalText = BaseQuery._sanitizeInput(text);

    final List<Part> parts = [
      ...images.map((img) => InlineDataPart(
            img.mimeType ?? '??',
            Uint8List.fromList(''.codeUnits),
          )),
      TextPart(finalText),
    ];

    final content = Content.multi(parts);

    const encoder = JsonEncoder.withIndent("  ");
    return encoder.convert(content.toJson());
  }

  @override
  Future<Map<String, dynamic>> dataForHistory() async {
    final List<Uint8List> imageBytes = [];
    for (final i in images) {
      imageBytes.add(await i.readAsBytes());
    }

    return {
      'content': toPrettyPrintedContent(),
      // TODO: include image array
      // 'images': imageBytes,
    };
  }
}
