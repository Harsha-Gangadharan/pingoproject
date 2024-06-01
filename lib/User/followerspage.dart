import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowingListPage extends StatelessWidget {
  FollowingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(131, 255, 64, 128),
        title: Text('Followers'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('useregisteration').doc(FirebaseAuth.instance.currentUser!.uid).collection("Following").snapshots(),
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
                    trailing: FollowButton(followerID: followerID,onPressed: () {
                      unFollow(followerID);
                    },),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
  unFollow(anothorUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final collection =
        FirebaseFirestore.instance.collection("useregisteration");
    collection
        .doc(currentUserId)
        .collection("Following")
        .doc(anothorUserId)
        .delete();
    collection
        .doc(anothorUserId)
        .collection("Followers")
        .doc(currentUserId)
        .delete();
  }
}

class FollowButton extends StatelessWidget {
  final String followerID;
   void Function()? onPressed;

  FollowButton({required this.followerID,required this.onPressed});

  // void _toggleFollow() async {


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:onPressed ,
      child: Text( 'Unfollow'),
    );
  }
}
