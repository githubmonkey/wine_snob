import 'dart:async';
import 'dart:core';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/prompt.dart';
import 'package:wine_snob/keys/secrets.dart';

part 'model_repository.g.dart';

const GEMINI_PRO_VISION = 'gemini-pro-vision';
const GEMINI_PRO = 'gemini-pro';

class ModelRepository {
  ModelRepository({required this.apiKey, required this.modelName}) {
    model = GenerativeModel(
      model: modelName,
      apiKey: apiKey,
      // the rest is optional
      safetySettings: [],
      generationConfig: GenerationConfig(
        // for now gemini-pro seems to support only one candidate
        candidateCount: 1,
        temperature: 0.7,
        maxOutputTokens: 1024,
      ),
    );
  }

  final String apiKey;
  final String modelName;

  late GenerativeModel model;

  Future<List<String>> fetchResults(String description, Prompt prompt) async {
    // Make sure the input string doesn't contain newlines or quotes
    final sanitized =
        description.replaceAll("\n", " ").replaceAll("\"", "'").trim();

    // TODO: the context should come from prompt
    final text_prompt =
        "Write tasting notes for the ${sanitized}. The tasting notes should be"
        "in the style of a wine critic and should mention the wine style, taste, "
        "and production process.Keep the result to one paragraph.";

    try {
      final content = [Content.text(text_prompt)];
      final response = await model.generateContent(content);
      // TODO: this will get more complex once larger candidate counts are supported
      return [response.text ?? 'no result'];
    } catch (error) {
      throw Exception('Error on model.generateContent: $error');
    }
  }
}

@Riverpod(keepAlive: true)
ModelRepository modelRepository(ModelRepositoryRef ref) {
  return ModelRepository(apiKey: Secrets.modelApiKey, modelName: GEMINI_PRO);
}

@riverpod
Future<List<String>> fetchResults(
    FetchResultsRef ref, String description, Prompt prompt) {
  final repository = ref.watch(modelRepositoryProvider);
  return repository.fetchResults(description, prompt);
}
