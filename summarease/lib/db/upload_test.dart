import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void uploadFile_Firebase(File file, String uid) async {
  try {
    // 建立一個參考到指定的路徑
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('user_files/$uid/${file.path.split('/').last}');

    // 上傳檔案
    UploadTask uploadTask = ref.putFile(file);

    // 等待上傳任務完成
    await uploadTask.whenComplete(() => null);

    // 取得下載 URL
    String downloadURL = await ref.getDownloadURL();

    // 儲存元數據和下載 URL
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('users').doc(uid).set({
      'fileName': file.path.split('/').last,
      'downloadURL': downloadURL,
    });
  } catch (e) {
    // 處理任何錯誤
    print(e);
  }
}
