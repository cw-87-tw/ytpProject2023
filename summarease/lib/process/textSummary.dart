import 'package:http/http.dart' as http;
import 'dart:convert';
import 'assets.dart';

Future<String> summarizeText(String text) async {
  final apiUrl = 'https://api.openai.com/v1/chat/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
      {
        "role": "system",
        "content": "You are a helpful assistant. You need to summarize the text given by the user"
      },
      {
        "role": "user",
        "content": text
      }
    ],
    }),
  );
  print("GPT replied\n\n\n");
  print("Reply Data ${response.body}");
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final summary = data['choices'][0]['message']['content'].toString();
    return summary;
  } else {
    print("Failed\n");
    return "Failed";
  }
}
