import 'package:http/http.dart' as http;
import 'dart:convert';
import 'assets.dart';

String defaultPrompt =
    'You are a helpful assistant. You need to summarize the text given by the user. Please answer all my question in English or Traditional Chinese. Please, do not use Simplified Chinese in the conversation later on no matter what.';

// return the latest response
Future<String> callAPI(List msgs) async {
  final apiUrl = 'https://api.openai.com/v1/chat/completions';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      "model": "gpt-4-turbo-preview",
      "messages": msgs,
      // "response_format": {"type": "json_object"}
    }),
  );
  print("GPT replied\n\n\n");
  print("Reply Data ${response.body}");
  // return response.body;
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final rawData = data['choices'][0]['message']['content'].toString();
    final summary = utf8.decode(rawData.runes.toList());
    print("Summary $summary\n\n\n");
    return summary;
    // return respons;
  } else {
    print("Failed\n");
    return "Failed";
  }
}

Future<String> summarizeText(String text) async {
  List msgs = [
    {
      "role": "system",
      "content": defaultPrompt
    },
    {"role": "user", "content": text},
  ];
  return await callAPI(msgs);
}

Future<String> sendAPIMessage(List chatMsgs, String script) async {
  List msgs = [
    {
      "role": "system",
      "content": defaultPrompt
    },
    {"role": "user", "content": script},
  ];
  msgs.addAll(chatMsgs);
  return await callAPI(msgs);
}
