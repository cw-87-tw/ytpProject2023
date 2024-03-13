import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/pages/summary_page.dart';
import 'package:summarease/util/file_tile.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  //get all user videos
  Stream<QuerySnapshot> getUserVideos() {
    final videosStream = 
      FirebaseFirestore.instance.collection('userFile')
      .doc(user!.uid).collection('userVideos')
      .orderBy('timestamp', descending: false).snapshots();
    return videosStream;
  }

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 80,
        leading: const Icon(Icons.list_alt, color: Colors.white, size: 35),
        title: Text(
          '檔案紀錄',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),

      //show files
      body: StreamBuilder(
        stream: widget.getUserVideos(),
        builder: (context, snapshot) {
          
          //if error
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          //show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          //get all user videos
          List videos = snapshot.data!.docs;

          //if no videos
          if (snapshot.data == null || videos.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text("沒有已儲存的專案"),
              ),
            );
          }

          //show files as list
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return FileTile(
                    data: videos[index],
                    onTapConversation: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SummaryPage(videoIndex: index)
                        )
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      )
    );
  }
}