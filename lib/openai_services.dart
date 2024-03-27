import 'dart:convert';

import 'package:askalech/secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];

  Future<String> isArtPrompt(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content':
                  'Does this message want to generate ai picture, image, art or anything similar? $prompt . simply answer with a yes or no.'
            }
          ]
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)('choices')(0)('message')('content');
        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = dellEAPI(prompt);
            return res;
          default:
            final res = chatGPTAI(prompt);
            return res;
        }
      }
      return 'An internal error has occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/completions'),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content':
                  'Does this message want to generate ai picture, image, art or anything similar? $prompt . simply answer with a yes or no.'
            }
          ]
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)('choices')(0)('message')('content');
      }
      return 'An internal error has occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dellEAPI(String prompt) async {
    return 'DELL-E';
  }
}
