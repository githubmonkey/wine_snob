import 'dart:core';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/keys/secrets.dart';

part 'model_repository.g.dart';

const GEMINI_PRO_VISION = 'gemini-pro-vision';
const GEMINI_PRO = 'gemini-pro';

class ModelType {
  static const String text = 'gemini-pro';
  static const String multimodal = 'gemini-pro-vision';
}

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

  Future<List<String>> fetchResults(Iterable<Content> content) async {
    try {
      final response = await model.generateContent(content);
      // TODO: this will get more complex once larger candidate counts are supported
      return [response.text ?? 'no result'];
    } catch (error) {
      throw Exception('Error on model.generateContent: $error');
    }
  }
}

@Riverpod(keepAlive: true)
ModelRepository modelRepository(ModelRepositoryRef ref, String modelName) {
  return ModelRepository(
      apiKey: Secrets.modelApiKey, modelName: modelName);
}
