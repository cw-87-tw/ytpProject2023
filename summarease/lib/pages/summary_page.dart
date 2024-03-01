import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:summarease/util/get_current_user_info.dart';
import 'package:summarease/util/msg_tile.dart';

class SummaryPage extends StatefulWidget {
  final String summary;
  final String conversation;
  final Function(String summary, String conversation)? toggleSummary;
  SummaryPage({
    super.key,
    required this.summary,
    required this.conversation,
    required this.toggleSummary,
  });

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  void initState() {
    super.initState();
    get_conversation();
  }

  List messages = [];

  void get_conversation() async {
    var jsonData = jsonDecode(widget.conversation);
    // {"messages": [{"author": "ChatGPT", "content": "hi"}, {"author": "user", "content": "bye"}]}
    messages = jsonData["messages"];
  }

  void hideSummary() {
    widget.toggleSummary!("", "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: hideSummary, 
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 10.0,),
                      Text("Save and exit"),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: SizedBox(
              width: 350,
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MsgTile(
                    author: messages[index]["role"],
                    content: messages[index]["content"],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Ask ChatGPT something...',
                labelStyle: TextStyle(color: Colors.grey)
              ),
            ),
          )
        ],
      ),
    );
  }
}