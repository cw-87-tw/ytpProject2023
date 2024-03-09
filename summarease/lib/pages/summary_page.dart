import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/process/textSummary.dart';
import 'package:summarease/util/msg_tile.dart';
import 'package:summarease/util/send_button.dart';
import '../read_data/conversation.dart';

class SummaryPage extends StatefulWidget {

  final videoIndex;

  SummaryPage({required this.videoIndex, super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  
  Conversation conversation = Conversation();

  User? user = FirebaseAuth.instance.currentUser;

  late List msgs;

  final msg_controller = TextEditingController();

  final ScrollController scroll_controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => scrollToBottom());
  }

  @override
  void dispose() {
    scroll_controller.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    scroll_controller.animateTo(
      scroll_controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 300), 
      curve: Curves.easeOut
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("對話")
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            //show conversation
            StreamBuilder(
              stream: conversation.getConversation(widget.videoIndex), 
              builder: (context, snapshot) {
        
                //if error
                if (snapshot.hasError) {
                  return Center(child: Text("Something went wrong"));
                }
        
                //show loading circle
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
        
                //get conversation
                var jsonData = jsonDecode(snapshot.data!['conversation']);
                msgs = jsonData['messages'];
        
                //if no msgs (which shouldn't happen at all...?)
                if (snapshot.data == null || msgs.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("沒有對話紀錄"),
                    ),
                  );
                }
        
                //show msgs as list
                return Expanded(
                  child: ListView.builder(
                    controller: scroll_controller,
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
            
            SizedBox(height: 10,),
        
            //page down button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.surface,
                elevation: 0,
                child: Icon(Icons.arrow_downward, color: Colors.black,),
                onPressed: scrollToBottom
              ),
            ),
        
            //textfield & send button
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 25.0),
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
                    onTap: () async {
                      //if empty
                      if (msg_controller.text.isEmpty) return;
              
                      //add user msg to list
                      msgs.add({"role" : "user", "content" : msg_controller.text});
                      msg_controller.clear();
        
                      //call chatgpt
                      String aiMsg = await sendAPIMessage(msgs, "");
                      msgs.add({"role" : "system", "content" : aiMsg});
        
                      //update conversation
                      await conversation.updateConversation(msgs, widget.videoIndex);
        
                      //auto scroll
                      scrollToBottom();
        
                    }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}