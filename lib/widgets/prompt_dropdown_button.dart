import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wine_snob/controller/oracle_controller.dart';
import 'package:wine_snob/controller/prompt_controller.dart';
import 'package:wine_snob/domain/models/prompt.dart';

import '../data/repositories/prompts_repository.dart';

class PromptDropdownButton extends ConsumerWidget {
  const PromptDropdownButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(promptsStreamProvider);
    final currentPrompt = ref.watch(promptControllerProvider);
    return asyncValue.when(
      data: (prompts) {
        return DropdownButtonFormField<Prompt>(
          value: currentPrompt,
          focusColor: Theme.of(context).canvasColor,
          items: prompts.map((Prompt prompt) {
            return DropdownMenuItem<Prompt>(
              value: prompt,
              child: Text(prompt.handle),
            );
          }).toList(),
          hint: Text(
            'Choose a Prompt',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onChanged: (value) {
            ref
                .read(promptControllerProvider.notifier)
                .updatePrompt(prompt: value);
            ref.read(oracleControllerProvider.notifier).resetResults();
          },
          isExpanded: true,
          validator: (value) {
            if (value == null) {
              return 'Please pick a prompt';
            }
            return null;
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text(e.toString())),
    );
  }
}
