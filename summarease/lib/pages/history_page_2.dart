import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/pages/sumary_page_2.dart';
import 'package:summarease/util/file_tile_2.dart';

class HistoryPage2 extends StatefulWidget {
  HistoryPage2({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  //get all user videos
  Stream<QuerySnapshot> getUserVideos() {
    final videosStream = 
      FirebaseFirestore.instance.collection('userFile')
      .doc(user!.uid).collection('userVideos')
      .orderBy('timestamp', descending: true).snapshots();
    return videosStream;
  }

  @override
  State<HistoryPage2> createState() => _HistoryPage2State();
}

class _HistoryPage2State extends State<HistoryPage2> {
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
            return Center(child: Text('Something went wrong'));
          }

          //show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          //get all user videos
          List videos = snapshot.data!.docs;

          //if no videos
          if (snapshot.data == null || videos.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Text("沒有已儲存的專案"),
              ),
            );
          }

          //show files as list
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return FileTile2(
                  data: videos[index],
                  onTapConversation: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 
                        SummaryPage2(videoIndex: index)
                      )
                    );
                  },
                );
              },
            ),
          );
        },
      )
    );
  }
}