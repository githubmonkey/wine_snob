import 'dart:core';

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model_repository.g.dart';

class ModelType {
  static const String text = 'gemini-1.0-pro';
  static const String multimodal = 'gemini-1.5-flash';
}

class ModelRepository {
  ModelRepository({required this.modelName}) {
    model = FirebaseVertexAI.instance.generativeModel(
      model: modelName,
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
ModelRepository modelRepository(Ref ref, String modelName) {
  return ModelRepository(modelName: modelName);
}
