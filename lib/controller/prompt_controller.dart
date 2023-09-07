import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/prompt.dart';

part 'prompt_controller.g.dart';

@Riverpod(keepAlive: true)
class PromptController extends _$PromptController {
  @override
  Prompt? build() {
    return null;
  }

  void updatePrompt({required Prompt? prompt}) {
    state = prompt;
  }
}
