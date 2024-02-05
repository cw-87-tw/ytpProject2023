import 'dart:io';
import 'package:summarease/pages/register_page.dart';
import 'package:flutter/material.dart';
import '../util/op_tile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewFilePage extends StatelessWidget {
  const NewFilePage({super.key});

  Future<void> uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'flv'],
    );

    if (result != null) {
      print("Successfully Uploaded YAYA!");

      final storageRef = FirebaseStorage.instance.ref();

      final videosRef = storageRef.child("videos");

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.absolute}/file-to-upload.png';
      File file = File(filePath);

      try {
        await videosRef.putFile(file);
      } on firebase_core.FirebaseException catch (e) {
        // ...
      }
    } else {
      print("No file selected");
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
