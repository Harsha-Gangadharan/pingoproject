import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/blockmessage.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/chatroom/message.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:flutter_application_1/chatroom/service/chatcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search Users',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(child: buildUserlist(searchQuery)),
          ],
        ),
      ),
              bottomNavigationBar: MyNav(index:0, onTap: (index){
  setState(() {
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Packages(indexNum: index)))   ;       });
       }, firestore:  FirebaseFirestore.instance, auth: FirebaseAuth.instance),
    );
  }

  Widget buildUserlist(String searchQuery) {
    return StreamBuilder(
      stream: ChatService().getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No users found'));
        }

        final filteredUsers = snapshot.data!
            .where((user) =>
                user['username'].toString().toLowerCase().contains(searchQuery))
            .toList();

        return ListView(
          children: filteredUsers
              .map<Widget>((userdata) => buildUserListitem(userdata, context))
              .toList(),
        );
      },
    );
  }

  User? getUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Widget buildUserListitem(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != getUser()!.email) {
      return UserTile(
        userData: userData,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(
                  reciverID: userData['id'],
                  reciveremail: userData['email'],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}

class UserTile extends StatelessWidget {
  final Map<String, dynamic> userData;
  final void Function()? onTap;
  const UserTile({
    super.key,
    required this.userData,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userData['image']),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userData['username']),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Chatroom')
                          .doc(getChatRoomId(FirebaseAuth.instance.currentUser!.uid, userData['id']))
                          .collection('message')
                          .orderBy('timestamp', descending: true)
                          .limit(1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Loading...');
                        }
                        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                          var lastMessage = snapshot.data!.docs.first;
                          return Text(
                            lastMessage['message'],
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                          );
                        } else {
                          return Text(
                            'No messages yet',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getChatRoomId(String user1, String user2) {
    List<String> ids = [user1, user2];
    ids.sort();
    return ids.join('_');
  }
}
