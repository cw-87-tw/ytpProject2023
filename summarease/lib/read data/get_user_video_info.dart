import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:summarease/util/file_tile.dart';

class GetUserVideoInfo extends StatelessWidget {
  final String videoID;
  CollectionReference files;
  final String userID;

  GetUserVideoInfo({
    required this.videoID,
    required this.files,
    required this.userID,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: files.doc(userID).collection('userVideos').doc(videoID).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            return FileTile(fileName: data['name'], fileTime: "${data['upload_time']} ${data['duration']}");
          }
          return FileTile(fileName: "loading...", fileTime: "loading...");
        }
    );
  }
}
