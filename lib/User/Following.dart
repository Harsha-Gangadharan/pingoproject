import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/followerspage.dart';
import 'package:google_fonts/google_fonts.dart';
class FollowingList extends StatelessWidget {
  FollowingList({Key? key}) : super(key: key);

  final List<String> flowerImages = [
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
  ];

  final List<String> userNames = [
    'User1',
    'User2',
    'User3',
    'User4',
    'User5',
    'User6',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(131, 255, 64, 128),
        title: Text('Fllowers'),
         
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        
      ),
       centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('useregisteration').doc(FirebaseAuth.instance.currentUser!.uid).collection("Followers").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final following = snapshot.data!.docs;
          return  following.isEmpty?Center(child: Text("No Followers"),): ListView.builder(
            itemCount: following.length,
            itemBuilder: (context, index) {
           final followerID=following[index]["id"];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('useregisteration')
                    .doc(followerID)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return SizedBox(); // Placeholder while loading
                  }
                  final userData = userSnapshot.data!.data() as Map<String, dynamic>?; // Explicit cast
                  final userProfileImage = userData?['image'] as String?; // Explicit cast
                  final username = userData?['username'] as String?; // Explicit cast

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userProfileImage ?? ''),
                    ),
                    title: Text(username ?? ''),
                    // trailing: FollowButton(followerID: followerID),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
