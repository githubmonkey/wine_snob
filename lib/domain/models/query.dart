import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const TEXT_TEMPLATE =
    'Write tasting notes for the $INPUT_PLACEHOLDER. The tasting notes should be'
    'in the style of a wine critic and should mention the wine style, taste, '
    'and production process.Keep the result to one paragraph.';

const INPUT_PLACEHOLDER = '\${input}';

class Query extends Equatable {
  final String? input;

  // will be TEXT_TEMPLATE if not overwritten
  final String scaffold;

  // TODO: change type
  final List<Uint8List>? imageBytes;

  const Query({this.input, required this.scaffold, this.imageBytes});

  @override
  List<Object?> get props => [input, scaffold, imageBytes];

  Query copyWith({input, scaffold}) => Query(
      input: input ?? this.input,
      scaffold: scaffold ?? this.scaffold ?? TEXT_TEMPLATE);

  Content toContent() {
    // For now there should always be one basic text component
    var finalText = scaffold;
    if (input != null) {
      finalText = (scaffold).replaceAll(INPUT_PLACEHOLDER, input!);
    }

    // sanitize the string
    // TODO: is this still required after the rewrite?
    finalText.replaceAll("\n", " ").replaceAll("\"", "'").trim();

    final List<Part> parts = [
      TextPart(finalText),
      //...imageBytes.map((e) => DataPart('images/jpeg', e))
    ];

    return Content.multi(parts);
  }
}
