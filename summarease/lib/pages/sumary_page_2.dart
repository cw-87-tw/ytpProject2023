import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:summarease/util/msg_tile.dart';
import '../read_data/conversation.dart';

class SummaryPage2 extends StatelessWidget {

  final videoIndex;
  Conversation conversation = Conversation();

  SummaryPage2({required this.videoIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          //show conversation
          StreamBuilder(
            stream: conversation.getConversation(videoIndex), 
            builder: (context, snapshot) {

              //if error
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }

              //show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
                
              print(snapshot.toString());

              //get conversation
              var jsonData = jsonDecode(snapshot.data!['conversation']);
              List msgs = jsonData['messages'];

              //if no msgs (which shouldn't happen at all...?)
              if (snapshot.data == null || msgs.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("沒有對話內容"),
                  ),
                );
              }

              //show msgs as list
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    return MsgTile(
                      role: msgs[index]["role"].toString(), 
                      content: msgs[index]["content"].toString(),
                    );
                  },
                ),
              );
            }
          ),

          //textfield
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