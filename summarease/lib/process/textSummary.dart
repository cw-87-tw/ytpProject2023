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
      "model": "gpt-4-turbo-preview",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a helpful assistant. You need to summarize the text given by the user. But you can only answer all questions in English."
        },
        {"role": "user", "content": text},
      ],
    }),
  );
  print("GPT replied\n\n\n");
  print("Reply Data ${response.body}");
  // return response.body;
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // final test = utf8.decode(data);
    // print("test $test\n\n\n\n");
    final summary = data['choices'][0]['message']['content'].toSdtring();
    return summary;
    // return respons;
  } else {
    print("Failed\n");
    return "Failed";
  }
}
