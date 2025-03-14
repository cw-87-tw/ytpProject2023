import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:summarease/process/sendEmail.dart';
import 'package:summarease/process/textSummary.dart';
import 'package:summarease/util/msg_tile.dart';
import 'package:summarease/util/send_button.dart';
import '../read_data/conversation.dart';

class SummaryPage extends StatefulWidget {
  final int videoIndex;

  const SummaryPage({required this.videoIndex, super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  Conversation conversation = Conversation();

  User? user = FirebaseAuth.instance.currentUser;

  late List msgs;

  final msg_controller = TextEditingController();

  final ScrollController scroll_controller = ScrollController();

  String replyingText = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => scrollToBottom());
  }

  @override
  void dispose() {
    scroll_controller.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    scroll_controller.animateTo(scroll_controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  void callSendEmail() async {
    DocumentReference vid = FirebaseFirestore.instance
        .collection('userFile')
        .doc(user!.uid)
        .collection('userVideos')
        .doc('video #${widget.videoIndex}');
    vid.get().then((doc) async {
      List _msgs = jsonDecode(doc['conversation'])['messages'];
      String result = "";
      for (int i = 1; i < _msgs.length; i++) {
        result += "${_msgs[i]['role']} : \n${_msgs[i]['content']}\n\n";
      }
      await sendEmail(
          [user!.email!], "Summarease ${doc['name']} conversation", result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("對話"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
                onTap: callSendEmail,
                child: const Row(
                  children: [
                    Text("Send Email"),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(Icons.mail),
                  ],
                )),
          ),
        ],
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
                    return const Center(child: Text("Something went wrong"));
                  }

                  //show loading circle
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  //get conversation
                  var jsonData = jsonDecode(snapshot.data!['conversation']);
                  msgs = jsonData['messages'];

                  //if no msgs (which shouldn't happen at all...?)
                  if (snapshot.data == null || msgs.isEmpty) {
                    return const Center(
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
                        if (index < 2) {
                          return const SizedBox(
                            height: 0.1,
                          );
                        } else {
                          return MsgTile(
                            role: msgs[index]["role"].toString(),
                            content: msgs[index]["content"].toString(),
                          );
                        }
                      },
                    ),
                  );
                }),

            const SizedBox(
              height: 10,
            ),

            //page down button
            SizedBox(
              height: 40.0,
              width: 40.0,
              child: FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  elevation: 0,
                  child: const Icon(
                    size: 20.0,
                    Icons.arrow_downward,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    scrollToBottom();
                  }),
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
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ),
                  SendButton(onTap: () async {
                    //if empty
                    if (msg_controller.text.isEmpty) return;

                    //add user msg to list
                    msgs.add({"role": "user", "content": msg_controller.text});

                    msg_controller.clear();

                    //update user msg
                    await conversation.updateConversation(
                        msgs, widget.videoIndex);

                    //auto scroll
                    scrollToBottom();

                    //hide phone keyboard
                    FocusScope.of(context).requestFocus(FocusNode());

                    //call chatgpt
                    String aiMsg = await sendAPIMessage(msgs);
                    msgs.add({"role": "system", "content": aiMsg});

                    //update chatgpt message
                    await conversation.updateConversation(
                        msgs, widget.videoIndex);

                    //auto scroll
                    scrollToBottom();
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
