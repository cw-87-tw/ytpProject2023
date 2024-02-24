import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'assets.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

Future<String> extractAudio(String videoFilePath) async { // extract the audio here
  print("start extract audio\n");
  final FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();
  final outputDirectory = Directory.systemTemp.path;
  final outputFilePath = '$outputDirectory/audio.mp3';
  if (await File(outputFilePath).exists()) {
    await File(outputFilePath).delete();
  }

  // Execute FFmpeg command to extract audio from video
  final arguments = ['-i', videoFilePath, '-vn', outputFilePath];
  final result = await _flutterFFmpeg.executeWithArguments(arguments);
  print("extract result: $result\n\n\n\n");
  if (result == 0) {
    print('Audio extraction successful: $outputFilePath');
    return outputFilePath;
  } else {
    print('Failed to extract audio');
    return ''; // Return empty string on failure
  }
}

Future<String> convertSpeechToText(String filePath) async {
  String audioFilePath = await extractAudio(filePath);
  print("extraction finished\n");
  if (audioFilePath.isEmpty) {
    print('Audio extraction failed');
    return ''; // Return empty string if audio extraction failed
  }
  else {
    print('Got extracted mp3\n$audioFilePath\n\n\n');
  }

  var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
  var request = http.MultipartRequest('POST', url);
  request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
  request.fields["model"] = 'whisper-1';
  request.fields["language"] = "en";
  request.files.add(await http.MultipartFile.fromPath('file', audioFilePath)); // change the path to audioFilePath
  var response = await request.send();
  var newResponse = await http.Response.fromStream(response);
  final responseData = json.decode(newResponse.body);
  print("Got reply");
  print(responseData);
  print("\n\n\n\n\n\n\n\n");
  return responseData['text'];
}