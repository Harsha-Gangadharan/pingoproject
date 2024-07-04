import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:flutter_application_1/User/viewallreview.dart';

class ReviewPage extends StatefulWidget {
  final String userProfileImage;
  final String userName;
  final String productImage;
  final String productId;
  final String sellerId;

  ReviewPage({
    required this.userProfileImage,
    required this.userName,
    required this.productImage,
    required this.productId,
    required this.sellerId,
  });

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> submitReview() async {
    if (_rating == 0 || _reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating and a review')),
      );
      return;
    }

    try {
      String uid = _auth.currentUser!.uid;
      String reviewText = _reviewController.text;
      await FirebaseFirestore.instance.collection('ratings').doc().set({
        'userProfileImage': widget.userProfileImage,
        'userName': widget.userName,
        'productId': widget.productId,
        'sellerId': widget.sellerId,
        'rating': _rating,
        'review': reviewText,
        'timestamp': FieldValue.serverTimestamp(),
        'uid': uid,
      });

      print('Review submitted successfully');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Packages(indexNum: 0)),
      );
    } catch (e) {
      print('Failed to submit review: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit review: $e')),
      );
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPost() {
    return FirebaseFirestore.instance.collection("productdetails").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Comment'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget.userProfileImage),
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.productImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('ratings')
                  .where('productId', isEqualTo: widget.productId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                List<QueryDocumentSnapshot> reviews = snapshot.data!.docs;

                int totalRatings = reviews.length;
                double averageRating = 0;
                int counterFiveStars = 0;
                int counterFourStars = 0;
                int counterThreeStars = 0;
                int counterTwoStars = 0;
                int counterOneStars = 0;

                if (totalRatings > 0) {
                  for (var review in reviews) {
                    double rating = review['rating'];
                    averageRating += rating;

                    if (rating == 5)
                      counterFiveStars++;
                    else if (rating == 4)
                      counterFourStars++;
                    else if (rating == 3)
                      counterThreeStars++;
                    else if (rating == 2)
                      counterTwoStars++;
                    else if (rating == 1) counterOneStars++;
                  }

                  averageRating /= totalRatings;
                }

                return totalRatings > 0
                    ? Padding(
                        padding: EdgeInsets.all(20.0),
                        child: RatingSummary(
                          counter: totalRatings,
                          average: averageRating,
                          counterFiveStars: counterFiveStars,
                          counterFourStars: counterFourStars,
                          counterThreeStars: counterThreeStars,
                          counterTwoStars: counterTwoStars,
                          counterOneStars: counterOneStars,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'No ratings yet',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Your Rating',
                style: GoogleFonts.abhayaLibre(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Rating: $_rating',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  AnimatedRatingStars(
                    initialRating: 0,
                    onChanged: (rating) {
                      setState(() {
                        _rating = rating;
                      });
                    },
                    displayRatingValue: true, // Display the rating value
                    interactiveTooltips: true, // Allow toggling half-star state
                    customFilledIcon: Icons.star,
                    customHalfFilledIcon: Icons.star_half,
                    customEmptyIcon: Icons.star_border,
                    starSize: 40.0,
                    animationDuration: const Duration(milliseconds: 500),
                    animationCurve: Curves.easeInOut,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _reviewController,
                decoration: InputDecoration(
                  hintText: 'Write your reviews',
                ),
                maxLines: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: submitReview,
                    child: Text('Submit'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewAllReview(
                                productId: widget.productId,
                                sellerId: widget.sellerId,
                              )),
                    ),
                    child: Text('View All Reviews'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String review;
  final int rating;
  final String date;
  final String uid;
  final String productId;

  Review({
    required this.review,
    required this.rating,
    required this.date,
    required this.uid,
    required this.productId,
  });

  factory Review.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Review(
      review: data['review'] ?? '',
      rating: (data['rating'] as num).toInt(),
      date: (data['timestamp'] as Timestamp).toDate().toString(),
      uid: data['uid'] ?? '',
      productId: data['productId'] ?? '',
    );
  }
}
