import 'package:http/http.dart' as http;
import 'dart:io';
import 'assets.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

Future<String> extractAudio(String videoFilePath) async {
  // extract the audio here
  print("start extract audio\n");
  final flutterFFmpeg = FlutterFFmpeg();
  // final outputDirectory = Directory.systemTemp.path;
  final outputDirectory =
      videoFilePath.substring(1, videoFilePath.lastIndexOf('/'));
  final outputFilePath = '$outputDirectory/audio.wav'; // 將音訊存為 WAV 格式
  if (await File(outputFilePath).exists()) {
    await File(outputFilePath).delete();
  }
  // 執行 FFmpeg 命令來提取音訊並轉換為 WAV 格式
  final arguments = [
    '-i',
    videoFilePath,
    '-vn',
    '-acodec',
    'pcm_s16le',
    '-ar',
    '41000',
    outputFilePath
  ];
  final result = await flutterFFmpeg.executeWithArguments(arguments);

  if (result == 0) {
    print('音訊提取成功: $outputFilePath');
    return outputFilePath;
  } else {
    print('提取音訊失敗');
    return ''; // 失敗時返回空字符串
  }
}

Future<String> convertSpeechToText(String filePath) async {
  // print("$filePath");
  String audioFilePath = await extractAudio(filePath);
  print("extraction finished\n");
  if (audioFilePath.isEmpty) {
    print('Audio extraction failed');
    return ''; // Return empty string if audio extraction failed
  } else {
    print('Got extracted audio\n$audioFilePath\n\n\n');
    print("audio Size: ${File(audioFilePath).lengthSync()}");
    print("video Size: ${File(filePath).lengthSync()}");
  }

  var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
  var request = http.MultipartRequest('POST', url);
  request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
  request.fields["model"] = 'whisper-1';
  request.fields["language"] = "zh";
  request.fields["response_format"] = "text";
  request.files.add(await http.MultipartFile.fromPath(
      'file', audioFilePath)); // change the path to audioFilePath
  var response = await request.send();
  var newResponse = await http.Response.fromStream(response);
  // final responseData = json.decode(newResponse.body);
  print("Got reply");
  print(newResponse.body);
  print("\n\n\n\n\n\n\n\n");
  return newResponse.body;
}
