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
import 'package:summarease/util/get_current_user_info.dart';
import 'package:summarease/pages/history_page.dart';

class NewFilePage extends StatefulWidget {
  const NewFilePage({super.key});

  @override
  State<NewFilePage> createState() => _NewFilePageState();
}

class _NewFilePageState extends State<NewFilePage> {
  String userId = getCurrentUserId();
  late File file;

  void showSuccessUploadDialog() {
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
                  Text('Upload Successful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24
                    )
                  ),
                ],
              )
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                summarizeFunction();
              },
              child: Text(
                'Summarize Now',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20
                ),
              )
            )
          ],
        );
      }
    );
  }

  void showUploadingDialog() {
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
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    "Uploading...",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
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
                  Text(
                    ' Error: $msg',
                    style: TextStyle(color: Colors.red.shade300, fontSize: 20)
                  ),
                ],
              )
            ),
          ),
        );
      }
    );
  }

  void summarizeFunction() async {
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
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    "Summarizing...",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              );
            },
          ),
        );
      },
    );

    var transcription = await convertSpeechToText(file.path);
    var summary = await summarizeText(transcription);

    // upload the `summary` here
    
    Navigator.pop(context);

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
                  Text('Summarize Successful',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 24
                    )
                  ),
                ],
              )
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Done',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18
                )
              )
            ),
          ],
        );
      }
    );
  }

  Future<void> newVideoProject() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'flv', 'mov'],
    );

    if (result != null) {
      // the dialog of uploading videos
      showUploadingDialog();

      // uploading file to `storage`
      file = File(result.files.single.path!);
      final storageRef = FirebaseStorage.instance.ref();

      getVideoIDs();
      final videosRef =
          storageRef.child("$userId/videoFiles/video_#${videoIDs.length}");
      await videosRef.putFile(file);

      // the field information of the video
      Map<String, dynamic> userVideoData = {
        'path': videosRef.fullPath,
      };

      // uploading file to `firestore`
      await FirebaseFirestore.instance
          .collection('userFile')
          .doc(userId)
          .collection('userVideos')
          .doc('video #${videoIDs.length}')
          .set(userVideoData)
          .then((value) async {
        // pop out the uploading dialog
        Navigator.pop(context);
        showSuccessUploadDialog();
      }).catchError((e) {
        // pop out the circle dialog
        Navigator.pop(context);
        showErrorDialog(e.code);
        print("---------- Failed to update reference :( ----------");
      });
    } else {
      print("---------- No file selected ----------");
    }
  }

  void setEmailRecipient() {
    //
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
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OpTile(
                  opName: '新專案',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: newVideoProject,
                ),
                SizedBox(height: 20),
                OpTile(
                  opName: '預設寄信對象',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: setEmailRecipient,
                )
              ],
            ),
          ),
        ));
  }
}
