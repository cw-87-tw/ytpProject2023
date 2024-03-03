import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:summarease/pages/summary_page.dart';
import 'package:summarease/read_data/get_user_video_info.dart';
import '../read_data/get_current_user_id.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

List<String> videoIDs = [];

Future getVideoIDs() async {
  videoIDs.clear();
  CollectionReference files = FirebaseFirestore.instance.collection('userFile');
  final userID = getCurrentUserId();
  await files
      .doc(userID)
      .collection('userVideos')
      .get()
      .then((snapshot) => snapshot.docs.forEach((video) {
            videoIDs.add(video.reference.id);
          }));
}


class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  bool showingSummary = false;
  Map<String, dynamic> _data = {};
  
  void toggleSummary(Map<String, dynamic> data) {
    setState(() {
      showingSummary = !showingSummary;
      _data = data;
    });
  }

  CollectionReference files = FirebaseFirestore.instance.collection('userFile');
  final userID = getCurrentUserId();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: FutureBuilder(
            future: getVideoIDs(),
            builder: (context, snapshot) {
              if (showingSummary) {
                return SummaryPage(data: _data, toggleSummary: toggleSummary,);
              }
              else {
                return ListView.builder(
                  itemCount: videoIDs.length,
                  itemBuilder: (context, index) {
                    return GetUserVideoInfo(videoID: videoIDs[index], files: files, userID: userID, showSummary: toggleSummary,);
                  }
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
