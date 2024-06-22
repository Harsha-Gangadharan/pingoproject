import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/chatroom/service/chatcontroller.dart';
import 'package:google_fonts/google_fonts.dart';

// class MessageScreen extends StatefulWidget {
//   @override
//   _MessageScreenState createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {
//   final List<ChatMessage> _messages = <ChatMessage>[];
//   final TextEditingController _textController = TextEditingController();
//  int _selectedIndex = 0;
//   void _handleSubmit(String text) {
//     _textController.clear();

//     String name = 'User 1';
//     ChatMessage message = ChatMessage(
//       text: text,
//       name: name,
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }

//   Widget _buildTextComposer() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Row(
//         children: [
//           Flexible(
//             child: TextField(
//               controller: _textController,
//               onSubmitted: _handleSubmit,
//               decoration: InputDecoration.collapsed(
//                 hintText: 'Send a message',
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () => _handleSubmit(_textController.text),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: Row(
//           children: [
//             CircleAvatar(child: Text('2', style: TextStyle(color: Colors.white))),
//             SizedBox(width: 10),
//             Text('User 2', style: TextStyle(color: Colors.white)),
//           ],
//         ),
//       ),
//       body: Column(
//         children: <Widget>[
//           Flexible(
//             child: ListView.builder(
//               padding: EdgeInsets.all(8.0),
//               reverse: true,
//               itemBuilder: (_, int index) => _messages[index],
//               itemCount: _messages.length,
//             ),
//           ),
//           Divider(height: 1.0),
//           Container(
//             decoration: BoxDecoration(color: Theme.of(context).cardColor),
//             child: _buildTextComposer(),
//           ),
//         ],
//       ),

//     );

//   }
// }

// class ChatMessage extends StatelessWidget {
//   final String text;
//   final String name;

//   ChatMessage({required this.text, required this.name});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.only(right: 16.0),
//             child: CircleAvatar(child: Text(name[0])),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name, style: Theme.of(context).textTheme.headline6),
//               Container(
//                 margin: const EdgeInsets.only(top: 5.0),
//                 child: Text(text),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

class MessageScreen extends StatefulWidget {
  final String reciveremail;
  final String reciverID;
    MessageScreen({super.key,required this.reciverID,required this.reciveremail});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
   ChatService chatService= ChatService();

    void sendmessage()async{
      if(messagecontrooler.text.isNotEmpty){
        await chatService.sendMessage(widget.reciverID, messagecontrooler.text);
      }
      messagecontrooler.clear();
    }

    @override
  void dispose() {
    // TODO: implement dispose
    messagecontrooler.dispose();
    super.dispose();
  }

    final messagecontrooler =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR CHAT ROOM '),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserinput(),
        ],
      ),
    );
  }

  Widget buildMessageList(){
  String senderId = auth.currentUser!.uid;

   return StreamBuilder(
    stream:ChatService().getMessage(widget.reciverID, senderId),
     builder: (context, snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting){
        return Center(child: CircularProgressIndicator());
      }
       return Padding(
         padding: const EdgeInsets.all(20),
         child: ListView(
          children: snapshot.data!.docs.map((doc) => buildMessage(doc)).toList()
         ),
       ); 
     },);
}

 Widget buildMessage(DocumentSnapshot doc){
  Map<String,dynamic> data =doc.data()as Map<String,dynamic>;


    bool iscurentUser =data['senderid']== auth.currentUser!.uid;

    var alignment = iscurentUser ? Alignment.centerRight : Alignment.centerLeft;


    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: iscurentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], iscurentUser: iscurentUser)
        ],
      ),
    );
 }

  Widget buildUserinput(){
    return Row(
      children: [
        Expanded(child: TextFormField(
          
          controller: messagecontrooler,
          decoration: InputDecoration(
            hintText: 'Message',
            border: OutlineInputBorder()
          ),
        ),),
        IconButton(onPressed: sendmessage, icon: Icon(Icons.arrow_upward))
      ],
    );
  }
}



class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurentUser;
    ChatBubble({super.key,required this.message,required this.iscurentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
     
      color: iscurentUser ? Colors.green :Colors.grey,
      child: Text(message),
    );
  }
}