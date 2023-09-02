import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/repositories/abstract/blurb_repository.dart';

class BlurbRepositoryImpl implements BlurbRepository {
  BlurbRepositoryImpl();

  @override
  Future<List<String>> getBlurbs(String description) async {
    const apiKey = String.fromEnvironment("API_KEY");
    const recordCount = 2;

    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$apiKey');
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "prompt": {
        "context": "You are a wine expert. You are asked to describe the style and aroma of a particular wine.",
        "examples": [
          {
            "input": {"content": "Kleine Zalze Chenin Blanc Barrel Fermented 2022"},
            "output": {
              "content":
              "melon\nwhite peach\nalmond blossom\nhint of minerality\noaked\ncreamy on the mid-palate\ncrisp finish"
            }
          }
        ],
        "messages": [
          {"content": "List some phrases and adjectives that describe this particular wine: $description. Finish with a one paragraph description of this wine."}
        ]
      },
      "candidate_count": 3,
      "temperature": 1,
    });

    try {
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
