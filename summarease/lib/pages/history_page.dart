import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/read%20data/get_user_video_info.dart';
import '../util/file_tile.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> videoIDs = [];

  CollectionReference files = FirebaseFirestore.instance.collection('userFile');

  Future getVideoIDs() async {
    await files.doc(user.uid).collection('userVideos').get().then(
      (snapshot) => snapshot.docs.forEach((video) {
        videoIDs.add(video.reference.id);
      })
    );
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
        leading: const Icon(Icons.list_alt, color: Colors.white, size: 35),
        title: Text(
          '檔案紀錄',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Center(
        //到時候會改成ListView.builder()
        child: Expanded(
          child: FutureBuilder(
            future: getVideoIDs(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: videoIDs.length,
                itemBuilder: (context, index) {
                  return GetUserVideoInfo(videoID: videoIDs[index], files: files, userID: user.uid,);
                }
              );
            },
          )
        ),
      ),
    );
  }
}
