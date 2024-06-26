// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/User/notification.dart';
// import 'package:flutter_application_1/chatroom/service/chatcontroller.dart';
// import 'package:google_fonts/google_fonts.dart';



// class MessageScreen extends StatefulWidget {
//   final String reciveremail;
//   final String reciverID;
//     MessageScreen({super.key,required this.reciverID,required this.reciveremail});

//   @override
//   State<MessageScreen> createState() => _MessageScreenState();
// }

// class _MessageScreenState extends State<MessageScreen> {
//    ChatService chatService= ChatService();

//     void sendmessage()async{
//       if(messagecontrooler.text.isNotEmpty){
//         await chatService.sendMessage(widget.reciverID, messagecontrooler.text);
//       }
//       messagecontrooler.clear();
//     }

//     @override
//   void dispose() {
//     // TODO: implement dispose
//     messagecontrooler.dispose();
//     super.dispose();
//   }

//     final messagecontrooler =TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('YOUR CHAT ROOM '),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: buildMessageList()),
//           buildUserinput(),
//         ],
//       ),
//     );
//   }

//   Widget buildMessageList(){
//   String senderId = auth.currentUser!.uid;

//    return StreamBuilder(
//     stream:ChatService().getMessage(widget.reciverID, senderId),
//      builder: (context, snapshot) {
//       if(snapshot.connectionState==ConnectionState.waiting){
//         return Center(child: CircularProgressIndicator());
//       }
//        return Padding(
//          padding: const EdgeInsets.all(30),
//          child: ListView(
//           children: snapshot.data!.docs.map((doc) => buildMessage(doc)).toList()
//          ),
//        ); 
//      },);
// }

//  Widget buildMessage(DocumentSnapshot doc){
//   Map<String,dynamic> data =doc.data()as Map<String,dynamic>;


//     bool iscurentUser =data['senderid']== auth.currentUser!.uid;

//     var alignment = iscurentUser ? Alignment.centerRight : Alignment.centerLeft;


//     return Container(
//       alignment: alignment,
//       child: Column(
//         crossAxisAlignment: iscurentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           ChatBubble(message: data['message'], iscurentUser: iscurentUser)
//         ],
//       ),
//     );
//  }

//   Widget buildUserinput(){
//     return Row(
//       children: [
//         Expanded(child: TextFormField(
          
//           controller: messagecontrooler,
//           decoration: InputDecoration(
//             hintText: 'Message',
//             border: OutlineInputBorder()
//           ),
//         ),),
//         IconButton(onPressed: sendmessage, icon: Icon(Icons.arrow_upward))
//       ],
//     );
//   }
// }



// class ChatBubble extends StatelessWidget {
//   final String message;
//   final bool iscurentUser;
//     ChatBubble({super.key,required this.message,required this.iscurentUser});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
     
//       color: iscurentUser ? Colors.green :Colors.grey,
//       child: Text(message),
//     );
//   }
// }