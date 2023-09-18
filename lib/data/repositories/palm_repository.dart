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

  Future<List<String>> fetchResults(String description, Prompt prompt) async {
    final url = Uri.parse('${prompt.uri}?key=$apiKey');

    final headers = {'Content-Type': 'application/json'};

    final String body;
    try {
      // String interpolation won't work so I'll just fake it.
      // Decode/encode makes sure the string is well formatted.
      body = jsonEncode(jsonDecode(
          prompt.request.replaceAll("\${description}", description)));

      //print(jsonEncode(jsonDecode(prompt.request)));
    } catch (error) {
      throw Exception('Formatting error in prompt: $error\n$prompt.request');
    }

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        final List<String> records = [];
        decodedResponse['candidates']
            .forEach((res) => records.add(res['content'] ?? res['output']));
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
