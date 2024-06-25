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

// class Chatscreen extends StatefulWidget {
//   @override
//   _ChatscreenState createState() => _ChatscreenState();
// }

// class _ChatscreenState extends State<Chatscreen> {
//   final List<Message> messages = [
//     Message(senderName: "User name", message: "example", time: "Sent Just now"),
//     Message(senderName: "example", message: "okay", time: "5w"),
//     Message(senderName: "example", message: "Seen", time: ""),
//     Message(
//         senderName: "example",
//         message: "Mentioned you in their story",
//         time: "7w"),
//   ];

//   bool _isMuted = Random().nextBool();
//   void _showBottomSheet(BuildContext context) {
//     setState(() {
//       _isMuted = Random().nextBool();
//     });

//     List<String> chooseradio = [
//       'mute',
//       'block',
//     ];

//     String? curentindex;

//     showModalBottomSheet(
//         context: context,
//         builder: (context) => StatefulBuilder(
//               builder: (context, setState) {
//                 return Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.white,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'User Name',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               Radio(
//                                   value: chooseradio[0],
//                                   groupValue: curentindex,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       curentindex = value.toString();
//                                     });
//                                   }),
//                               Text('Mute'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Radio(
//                                   value: chooseradio[1],
//                                   groupValue: curentindex,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       curentindex = value.toString();
//                                     });
//                                   }),
//                               Text('Block'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Spacer(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                             SizedBox(width: 16),
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 _isMuted = false;
//                               });
//                               Navigator.pop(context);
//                             },
//                             child: Text('cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               setState(() {
//                                 _isMuted = true;
//                               });
//                                Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => BlockMessage()),
//                       );
//                             },
//                             child: Text('until i changed'),
//                           ),

//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(183, 225, 56, 132),
//         title: Text('User name'),
//         titleTextStyle: GoogleFonts.inknutAntiqua(
//           fontSize: 26,
//           color: const Color.fromARGB(255, 14, 14, 14),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: 'Search...',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: () => _showBottomSheet(context),
//                   leading: SizedBox(
//                     width: 50.0,
//                     child: Container(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   title: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => MessageScreen()),
//                       );
//                     },
//                     child: Text(messages[index].senderName),
//                   ),
//                   subtitle: Text(messages[index].message),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(messages[index].time),
//                       const SizedBox(width: 8),
//                       const Padding(
//                         padding: EdgeInsets.only(left: 8.0),
//                         child: Icon(Icons.camera_alt),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//        bottomNavigationBar: MyNav(index:0, onTap: (index){
//   setState(() {
// Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Packages(indexNum: index)))   ;       });
//        }, firestore:  FirebaseFirestore.instance, auth: FirebaseAuth.instance),
//     );
//   }
// }

// class Message {
//   final String senderName;
//   final String message;
//   final String time;

//   Message({
//     required this.senderName,
//     required this.message,
//     required this.time,
//   });
// }

class Chatscreen extends StatefulWidget {
  const Chatscreen({super.key});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  @override
  Widget build(BuildContext context) {

    String searchQuery = '';
    return Scaffold(
      
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //     decoration: InputDecoration(
            //       hintText: 'Search Users',
            //       border: OutlineInputBorder(
                    
            //       ),
                  
            //     ),
            //     onChanged: (value) {
            //     setState(() {
            //         searchQuery = value.toLowerCase();
            //       });
            //     },
            //   ),
            // ),
            Expanded(child: buildUserlist()),
          ],
        ),
      ),
    );
  }
}

Widget buildUserlist() {
  return StreamBuilder(
    stream: ChatService().getUser(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      //  final filteredUsers = snapshot.data!
      //       .where((user) => user['username'].toString().toLowerCase().contains(searchQuery))
      //       .toList();
      return ListView(
          children: snapshot.data!
              .map<Widget>((userdata) => buildUserListitem(userdata, context))
              .toList());
    },
  );
}

User? getUser() {
  return auth.currentUser;
}

Widget buildUserListitem(Map<String, dynamic> userData, BuildContext context) {
  if (userData['email'] != getUser()!.email) {
    return UserTile(
      text: userData['username'],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MessageScreen(
                reciverID: userData['id'],
                reciveremail: userData['email'],
              ),
            ));
      }, imageUrl: userData['image'],
    );
  } else {
    return Container();
  }
}

class UserTile extends StatelessWidget {
  final String text;
  final String imageUrl;
  final void Function()? onTap;
  const UserTile({super.key, required this.text, required this.onTap, required this.imageUrl});

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
                backgroundImage: NetworkImage(imageUrl),
              ),
              SizedBox(
                width: 10,
              ),
              Text(text),
              // Spacer(),
              // CircleAvatar(
              //   radius: 10,
              //   child: Text('5'),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
