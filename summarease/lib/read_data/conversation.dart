import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Conversation {

  User? user = FirebaseAuth.instance.currentUser;

  //update conversation
  Future<void> updateMsg(String msg, int vidIndex) {
    DocumentReference vid = 
      FirebaseFirestore.instance.collection('userFile')
      .doc(user!.uid).collection('userVideos').doc('video #${vidIndex}');

    //msg --> json map string

    return vid.set({'conversation' : msg});
  }

  //get conversation
  Stream<DocumentSnapshot> getConversation(int vidIndex) {
    DocumentReference vid = 
      FirebaseFirestore.instance.collection('userFile')
      .doc(user!.uid).collection('userVideos').doc('video #$vidIndex');
    final vidStream = vid.snapshots();
    return vidStream;
  }
}