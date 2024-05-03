import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/review.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewallReview extends StatefulWidget {
  const ViewallReview({Key? key}) : super(key: key);

  @override
  State<ViewallReview> createState() => _ViewallReviewState();
}

class _ViewallReviewState extends State<ViewallReview> {
  final List<Review> reviews = [
    Review(
      rating: 5,
      comment: 'Excellent product!',
      user: 'User1',
      date: '2 days ago',
    ),
    Review(
      rating: 4,
      comment: 'Good but could be better.',
      user: 'User2',
      date: '1 week ago',
    ),
    // Add more reviews as needed
  ];

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
      body: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(reviews[index].user[0]),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${reviews[index].user}'),
                Text('${reviews[index].date}'),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${reviews[index].comment}',
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
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'report') {
                  // Show report dialog
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
      ),
    );
  }
}

class Review {
  final int rating;
  final String comment;
  final String user;
  final String date;

  Review({
    required this.rating,
    required this.comment,
    required this.user,
    required this.date,
  });
}
