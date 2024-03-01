import 'package:http/http.dart' as http;
import 'dart:io';
import 'assets.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:just_audio/just_audio.dart';

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

Future<List<String>> splitAudioIntoSegments(
    String audioFilePath, int segmentDurationInSeconds) async {
  final flutterFFmpeg = FlutterFFmpeg();
  final player = AudioPlayer(); // Create a player
  final audioDuration = await player.setUrl(audioFilePath);
  print("Duration: ${audioDuration?.inSeconds ?? -1}\n\n\n\n\n");
  // Calculate number of segments
  final int numSegments =
      ((audioDuration?.inSeconds ?? 0) / segmentDurationInSeconds).ceil();
  final List<String> segmentPaths = [];
  // Split audio into segments
  for (int i = 0; i < numSegments; i++) {
    final start = i * segmentDurationInSeconds;
    final outputFilePath = "${audioFilePath}_segment_$i.wav";
    if (await File(outputFilePath).exists()) {
      await File(outputFilePath).delete();
    } 
    final arguments = [
      '-i',
      audioFilePath,
      '-ss',
      '$start',
      '-t',
      '$segmentDurationInSeconds',
      '-acodec',
      'copy',
      outputFilePath
    ];

    final result = await flutterFFmpeg.executeWithArguments(arguments);

    if (result == 0) {
      segmentPaths.add(outputFilePath);
    } else {
      print('Failed to split segment $i');
    }
  }

  return segmentPaths;
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

  // 切割音訊檔案
  final List<String> audioSegments =
      await splitAudioIntoSegments(audioFilePath, 60); // 每分鐘切割一段

  // 上傳片段並轉換文字
  final List<String> transcriptions = [];
  for (final segmentPath in audioSegments) {
    var url = Uri.https("api.openai.com", "v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({"Authorization": "Bearer $apiKey"});
    request.fields["model"] = 'whisper-1';
    request.fields["language"] = "zh";
    request.fields["response_format"] = "text";
    request.files.add(await http.MultipartFile.fromPath('file', segmentPath));
    var response = await request.send();
    var newResponse = await http.Response.fromStream(response);
    transcriptions.add(newResponse.body.trim());
    print("Segment $segmentPath, transcription ${newResponse.body}\n\n");
  }

  // 串接結果
  final fullTranscription = transcriptions.join("");

  print("Full transcription");
  print(fullTranscription);
  print("\n\n\n\n\n\n\n\n");
  return fullTranscription;
}
