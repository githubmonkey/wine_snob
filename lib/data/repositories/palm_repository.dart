import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wine_snob/domain/models/prompt.dart';
import 'package:wine_snob/keys/secrets.dart';

part 'palm_repository.g.dart';

class PalmRepository {
  PalmRepository({required this.apiKey});

  final String apiKey;
  final recordCount = 3;
  final temperature = 0.5;

  Object _formatForPalm(Map<String, String> examples) {
    var list = [];
    examples.forEach((k, v) {
      list.add({
        'input': {'content': k},
        'output': {'content': v}
      });
    });
    return list;
  }

  Future<List<String>> fetchResults(String description, Prompt prompt) async {
    final url =
        Uri.parse('https://generativelanguage.googleapis.com/v1beta2/models/'
            'chat-bison-001:generateMessage?key=$apiKey');

    final headers = {'Content-Type': 'application/json'};

    final str = {
      "prompt": {
        "context": prompt.context,
        "examples": _formatForPalm(prompt.examples),
        "messages": [
          {"content": prompt.message.replaceAll("\${description}", description)}
        ],
      },
      "candidate_count": recordCount,
      "temperature": temperature,
    };

    final body = jsonEncode({
      "prompt": {
        "context": prompt.context,
        "examples": _formatForPalm(prompt.examples),
        "messages": [
          {"content": prompt.message.replaceAll("\${description}", description)}
        ],
      },
      "candidate_count": recordCount,
      "temperature": temperature,
    });

    try {
      print(str);
      print(body);
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        final List<String> records = [];
        for (var i = 0; i < recordCount; i++) {
          records.add(decodedResponse['candidates'][i]['content']);
        }
        return records;
      } else {
        throw Exception(
            'Request failed with status: ${response.statusCode}.\n\n${response.body}');
      }
    } catch (error) {
      throw Exception('Error sending POST request: $error');
    }
  }
}

@Riverpod(keepAlive: true)
PalmRepository palmRepository(PalmRepositoryRef ref) {
  return PalmRepository(apiKey: Secrets.palmApiKey);
}

@riverpod
Future<List<String>> fetchResults(
    FetchResultsRef ref, String description, Prompt prompt) {
  final repository = ref.watch(palmRepositoryProvider);
  return repository.fetchResults(description, prompt);
}
