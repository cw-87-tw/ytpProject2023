import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:summarease/read_data/get_current_user_id.dart';
import 'package:summarease/util/msg_tile.dart';

class SummaryPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final Function(Map<String, dynamic>)? toggleSummary;
  SummaryPage({
    super.key,
    required this.data,
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
    var jsonData = jsonDecode(widget.data['conversation']);
    // {"messages": [{"author": "ChatGPT", "content": "hi"}, {"author": "user", "content": "bye"}]}
    messages = jsonData["messages"];
  }

  void hideSummary() {
    widget.toggleSummary!({});
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