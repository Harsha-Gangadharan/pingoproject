import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/chatroom/chatscreen.dart';
import 'package:flutter_application_1/chatroom/message.dart';
import 'package:flutter_application_1/chatroom/model/model.dart';

class ChatService {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUser() {
    return db.collection('useregisteration').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String reciverID, message) async {
    final String curentuserid = auth.currentUser!.uid;
    final String curentemail = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    ChatMessageRoom newmessage = ChatMessageRoom(
      senderID: curentuserid,
      senderemail: curentemail,
      reciverid: reciverID,
      message: message,
      timestamp: timestamp,
    );

    String chatroom = getChatRoomId(curentuserid, reciverID);

    await db.collection('Chatroom')
        .doc(chatroom)
        .collection('message')
        .add(newmessage.toJsone());
  }

  Stream<QuerySnapshot> getMessage(String userid, String otheruserid) {
    String chatroom = getChatRoomId(userid, otheruserid);

    return db.collection('Chatroom')
        .doc(chatroom)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  String getChatRoomId(String user1, String user2) {
    List<String> ids = [user1, user2];
    ids.sort();
    return ids.join('_');
  }
}
