import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'review.dart';

class ViewAllReview extends StatefulWidget {
  final String productId;
  final String sellerId;

  ViewAllReview({required this.productId, required this.sellerId});

  @override
  State<ViewAllReview> createState() => _ViewAllReviewState();
}

class _ViewAllReviewState extends State<ViewAllReview> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('View all reviews'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ratings')
            .where('productId', isEqualTo: widget.productId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No reviews yet'));
          }

          List<Review> reviews = snapshot.data!.docs.map((doc) {
            return Review.fromFirestore(doc);
          }).toList();

          return ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              String uid = reviews[index].uid;
              bool isCurrentUser = uid == _auth.currentUser!.uid;
              bool isSeller = widget.sellerId == _auth.currentUser!.uid;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('useregisteration')
                    .doc(uid)
                    .get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return ListTile(
                      leading: CircleAvatar(child: CircularProgressIndicator()),
                      title: Text('Loading...'),
                      subtitle: Text('Loading...'),
                    );
                  }

                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return ListTile(
                      leading: CircleAvatar(child: Icon(Icons.error)),
                      title: Text('User not found'),
                      subtitle: Text('User not found'),
                    );
                  }

                  var userData = userSnapshot.data!;
                  String imageUrl = userData['image'] ?? '';
                  String username = userData['username'] ?? '';

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                      radius: 20,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(username),
                        Text(reviews[index].date),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reviews[index].review,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: List.generate(
                            reviews[index].rating,
                            (i) => Icon(Icons.star, color: Colors.amber, size: 16),
                          ),
                        ),
                      ],
                    ),
                    trailing: isCurrentUser || isSeller
                        ? IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('ratings')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Review deleted')),
                              );
                            },
                          )
                        : PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'report') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Report'),
                                      content: Text('You reported this comment.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'report'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Row(
                                    children: [
                                      Icon(Icons.report),
                                      SizedBox(width: 8),
                                      Text('Report'),
                                    ],
                                  ),
                                );
                              }).toList();
                            },
                          ),
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
