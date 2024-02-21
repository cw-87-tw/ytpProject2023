import 'dart:io';
import '../util/op_tile.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summarease/util/get_current_user_info.dart';

class NewFilePage extends StatelessWidget {
  const NewFilePage({super.key});

  Future<void> uploadVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp4', 'avi', 'mkv', 'flv', 'mov'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final storageRef = FirebaseStorage.instance.ref();

      // The file's name should be the email of the user, instead of "test."
      final videosRef = storageRef.child("Videos/testing");
      await videosRef.putFile(file);
      print("--------------------- Successfully upload to Firestore DB!!!");

      String userId = getCurrentUserId();
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userDocRef.update({
        'UserVideo': videosRef,
      });
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
