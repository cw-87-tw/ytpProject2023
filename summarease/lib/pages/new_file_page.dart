// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'dart:async';
import '../process/videoToText.dart';
import '../process/textSummary.dart';
import '../util/op_tile.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summarease/read_data/get_current_user_id.dart';
import '../process/sendEmail.dart';

class NewFilePage extends StatefulWidget {
  const NewFilePage({super.key});

  @override
  State<NewFilePage> createState() => _NewFilePageState();
}

class _NewFilePageState extends State<NewFilePage> {
  String userId = getCurrentUserId();
  late File file;

  void showSummarizingDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 14),
                  CircularProgressIndicator(),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 35),
                      Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.grey,
                        size: 24,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Summarizing...",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void showSuccessSummarizeDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 197, 253, 200),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 36,
                        ),
                        SizedBox(width: 16),
                        Text('Summarize Successful',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black87,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              )),
            ),
            actions: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(
                      ' Done ',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ))
            ],
          );
        });
  }

  void summarizeAndUploadFunction() async {
    showSummarizingDialog();

    var transcription = await convertSpeechToText(file.path);
    var summary = await summarizeText(transcription);

    String prompt =
        "You are a helpful assistant. You need to summarize the text given by the user. Please answer all my question in English or Traditional Chinese. Please, do not use Simplified Chinese in the conversation later on no matter what.";

    // get video numbers
    int videoNumber = 0;
    await FirebaseFirestore.instance
        .collection('userFile')
        .doc(userId)
        .collection('userVideos')
        .count()
        .get()
        .then((res) => videoNumber = res.count!);

    // upload the `summary` here
    Map<String, dynamic> userVideoData = {
      'script': transcription,
      'summary': summary,
      'timestamp': Timestamp.now(),
      'name': 'video_$videoNumber',
      'conversation':
          '{"messages" : [{"role": "system", "content" : "$prompt"}, {"role" : "user", "content" : "The following is the class content: $transcription"}, {"role" : "system", "content" : "$summary"}]}'
    };

    await FirebaseFirestore.instance
        .collection('userFile')
        .doc(userId)
        .collection('userVideos')
        .doc('video #$videoNumber')
        .set(userVideoData)
        .then((value) async {
      // pop out the uploading dialog
      
    }).catchError((e) {
      // pop out the circle dialog
      Navigator.pop(context);
      showErrorDialog(e.code);
      print("---------- Failed to update reference :( ----------");
    });

    // uplaod to `firestore`
    await FirebaseFirestore.instance
        .collection('userFile')
        .doc(userId)
        .collection('userVideos')
        .doc('video #$videoNumber')
        .update(userVideoData)
        .then((value) async {
          // pop out the summarizing dialog
          Navigator.pop(context);
          showSuccessSummarizeDialog();
        })
        .catchError((e) {
      // pop out the circle dialog
      Navigator.pop(context);
      showErrorDialog(e.code);
      print("---------- Failed to update reference :( ----------");
    });

    // upload to `storage`
    final storageRef = FirebaseStorage.instance.ref();
    final videosRef =
        storageRef.child("$userId/videoFiles/video_#$videoNumber");
    await videosRef.putFile(file);
  }

  void showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.red.shade300,
                  ),
                  Text(' Error: $msg',
                      style:
                          TextStyle(color: Colors.red.shade300, fontSize: 20)),
                ],
              )),
            ),
          );
        });
  }

  Future<void> newVideoProject() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'flv', 'mov', 'm4a', 'wav', 'mp3'],
    );

    if (result != null) {
      // uploading file to `storage`
      file = File(result.files.single.path!);

      // summarize & upload to firebase
      summarizeAndUploadFunction();
    } else {
      print("---------- No file selected ----------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 80,
          leading: const Icon(Icons.add, color: Colors.white, size: 35),
          title: Text(
            '新增檔案',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OpTile(
                  opName: '新專案',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: newVideoProject,
                ),
              ],
            ),
          ),
        ));
  }
}
