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
        stream: FirebaseFirestore.instance.collection('followers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final followerDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: followerDocs.length,
            itemBuilder: (context, index) {
              final followerID = followerDocs[index].id;

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
                    trailing: FollowButton(followerID: followerID),
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

class FollowButton extends StatefulWidget {
  final String followerID;

  FollowButton({required this.followerID});

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    _checkFollowStatus();
  }

  void _checkFollowStatus() async {
    final followStatus = await FirebaseFirestore.instance
        .collection('followers')
        .doc(widget.followerID)
        .get();

    setState(() {
      isFollowing = followStatus.exists;
    });
  }

  void _toggleFollow() async {
    final followersRef = FirebaseFirestore.instance.collection('followers').doc(widget.followerID);
    if (isFollowing) {
      await followersRef.delete();
    } else {
      await followersRef.set({'timestamp': FieldValue.serverTimestamp()});
    }

    setState(() {
      isFollowing = !isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleFollow,
      child: Text(isFollowing ? 'Unfollow' : 'Follow'),
    );
  }
}
