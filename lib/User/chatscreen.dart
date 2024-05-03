import 'dart:math'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Chatscreen extends StatefulWidget {
  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  final List<Message> messages = [
    Message(senderName: "User name", message: "example", time: "Sent Just now"),
    Message(senderName: "example", message: "okay", time: "5w"),
    Message(senderName: "example", message: "Seen", time: ""),
    Message(senderName: "example", message: "Mentioned you in their story", time: "7w"),
  ];

  bool _isMuted = Random().nextBool(); 
final GlobalKey _optionsKey = GlobalKey();

  // void _showOptions() => showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext builderContext) {
  //       return Card(
  //         elevation: 4,
  //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //         child: Column(
  //           key: _optionsKey,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             RadioListTile<int>(
  //               groupValue: _currentContent.contentType,
  //               value: SimpleContent.header,
  //               onChanged: (int value) {
  //                 setState(() {
  //                   _currentContent.contentType = value;
  //                 });
  //               },
  //               title: Text(
  //                 "Header",
  //                 style: buildTextStyleBlack(14),
  //               ),
  //             ),
  //             RadioListTile<int>(
  //               groupValue: _currentContent.contentType,
  //               value: SimpleContent.content,
  //               onChanged: (int value) {
  //                 setState(() {
  //                   _currentContent.contentType = value;
  //                 });
  //               },
  //               title: Text(
  //                 "Content",
  //                 style: buildTextStyleBlack(14),
  //               ),
  //             ),
              
             
  //             _buildDoneButton()
  //           ],
  //         ),
  //       );
  //     });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: Text('User name'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: const Color.fromARGB(255, 14, 14, 14),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
    
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // onTap: () => _showBottomSheet(context),
                  leading: SizedBox(
                    width: 50.0,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(messages[index].senderName),
                  subtitle: Text(messages[index].message),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(messages[index].time),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.camera_alt),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String senderName;
  final String message;
  final String time;

  Message({
    required this.senderName,
    required this.message,
    required this.time,
  });
}
