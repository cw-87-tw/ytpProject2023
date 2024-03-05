import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/util/msg_tile.dart';
import 'package:summarease/util/send_button.dart';
import '../read_data/conversation.dart';

class SummaryPage2 extends StatelessWidget {

  final videoIndex;
  Conversation conversation = Conversation();
  User? user = FirebaseAuth.instance.currentUser;
  late List msgs;
  
  final msg_controller = TextEditingController();

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
              msgs = jsonData['messages'];

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
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: msg_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        labelText: 'Ask ChatGPT something...',
                        labelStyle: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                ),
                SendButton(
                  onTap: () {
                    //if empty
                    if (msg_controller.text.isEmpty) return;
            
                    //add user msg to list
                    msgs.add({"user" : msg_controller.text});
                    msg_controller.clear();

                    //call chatgpt (+add chatgpt msg to list)

                    //update conversation
                    conversation.updateConversation(msgs, videoIndex);

                  }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}