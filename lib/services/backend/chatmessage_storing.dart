import 'package:chating_app/custom/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatMessageStoring {
  final FirebaseFirestore chat = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //storing a message
  Future<void> sendMessage(reciverId, message) async {
    final currentUserId = _auth.currentUser!.uid;
    final currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Messages newMessage = Messages(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      reciverId: reciverId,
      message: message,
      timeStamp: timestamp,
    );

    List ids = [currentUserId,reciverId];
    ids.sort();
    String docId = ids.join('_');

    await chat.collection("chatRoom").doc(docId).collection('message').add(newMessage.toMap());

  }

  // retrive a message
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(reciverId) {
    final currentUserId = _auth.currentUser!.uid;
    List ids = [currentUserId,reciverId];
    ids.sort();
    String docId = ids.join('_');
    return chat.collection('chatRoom').doc(docId).collection('message').orderBy('timestamp',descending: false).snapshots();
  }
}
