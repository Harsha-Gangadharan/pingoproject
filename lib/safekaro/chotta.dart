// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/User/blockmessage.dart';
// import 'package:flutter_application_1/User/notification.dart';
// import 'package:flutter_application_1/chatroom/message.dart';
// import 'package:flutter_application_1/User/package.dart';
// import 'package:flutter_application_1/chatroom/service/chatcontroller.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';



// class Chatscreen extends StatefulWidget {
//   const Chatscreen({super.key});

//   @override
//   State<Chatscreen> createState() => _ChatscreenState();
// }

// class _ChatscreenState extends State<Chatscreen> {
//   @override
//   Widget build(BuildContext context) {

//     String searchQuery = '';
//     return Scaffold(
      
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(),

//             Expanded(child: buildUserlist()),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget buildUserlist() {
//   return StreamBuilder(
//     stream: ChatService().getUser(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }

    
//       return ListView(
//           children: snapshot.data!
//               .map<Widget>((userdata) => buildUserListitem(userdata, context))
//               .toList());
//     },
//   );
// }

// User? getUser() {
//   return auth.currentUser;
// }

// Widget buildUserListitem(Map<String, dynamic> userData, BuildContext context) {
//   if (userData['email'] != getUser()!.email) {
//     return UserTile(
//       text: userData['username'],
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => MessageScreen(
//                 reciverID: userData['id'],
//                 reciveremail: userData['email'],
//               ),
//             ));
//       }, imageUrl: userData['image'],
//     );
//   } else {
//     return Container();
//   }
// }

// class UserTile extends StatelessWidget {
//   final String text;
//   final String imageUrl;
//   final void Function()? onTap;
//   const UserTile({super.key, required this.text, required this.onTap, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           decoration: BoxDecoration(),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: NetworkImage(imageUrl),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(text),
             
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
