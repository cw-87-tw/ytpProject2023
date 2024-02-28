import 'dart:io';
import 'dart:async';
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
  void showSuccessUploadDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 183, 246, 186),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(width: 2, color: Colors.red.shade300)
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Color.fromARGB(255, 136, 248, 187),
                  ),
                  Text('Upload Successful',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 24)),
                ],
              )),
            ),
          );
        });
  }

  void showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red.shade100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              // side: BorderSide(width: 2, color: Colors.red.shade300)
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
                  Text(' Error: ' + msg,
                      style:
                          TextStyle(color: Colors.red.shade300, fontSize: 20)),
                ],
              )),
            ),
          );
        });
  }

  Future<void> uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'flv', 'mov'],
    );

    String userId = getCurrentUserId();

    if (result != null) {
      File file = File(result.files.single.path!);
      final storageRef = FirebaseStorage.instance.ref();

      getVideoIDs();
      final videosRef =
          storageRef.child("$userId/videoFiles/video_#${videoIDs.length}");

      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await videosRef.putFile(file);
      // print("---------- Successfully upload to Storage!!! ----------");
      // print("---------- reference: $videosRef ----------");

      // print("---------- userID: $userId ----------");

      Map<String, dynamic> userVideoData = {
        'path': videosRef.fullPath,
      };

      await FirebaseFirestore.instance
          .collection('userFile')
          .doc(userId)
          .collection('userVideos')
          .doc('video #${videoIDs.length}')
          .set(userVideoData)
          .then((value) {
        Navigator.pop(context);
        showSuccessUploadDialog();
      }).catchError((e) {
        Navigator.pop(context);
        showErrorDialog(e.code);
        print("---------- Failed to update reference :( ----------");
      });
    } else {
      print("---------- No file selected ----------");
    }
  }

  void uploadAudio() {
    //
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
                  opName: '上傳影片',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: uploadVideo,
                ),
                SizedBox(height: 30),
                OpTile(
                  opName: '上傳音檔',
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: uploadAudio,
                ),
                SizedBox(height: 30),
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
