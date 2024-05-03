import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() => _ReviewState();
}

class _ReviewState extends State<ReviewPage> {
  int _selectedIndex = 0;
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
      body: Column(
        children: [
          // User profile image and follower count
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.png'),
                      radius: 40.0,
                    ),
                    SizedBox(width: 16.0),
                    Text('example\n1M followers'),
                  ],
                ),
                // View count
                Row(
                  children: [
                    Icon(Icons.remove_red_eye),
                    SizedBox(width: 8.0),
                    Text('500K views'), // Replace '500K views' with your view count
                  ],
                ),
              ],
            ),
          ),
          // Product image
          Container(
            padding: EdgeInsets.all(20.0),
            child: Image.asset('asset/product_image.png'), // Change 'assets/product_image.png' to your image path
          ),
          // Share button
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => {}, // Add your share functionality here
                  child: Row(
                    children: [
                      Icon(Icons.share),
                      SizedBox(width: 8.0),
                      Text('Share'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Username
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Text(
              'Your Rating',
              style: GoogleFonts.abhayaLibre(fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () => {},
                ),
                IconButton(
                  icon: Icon(Icons.star_border),
                  onPressed: () => {},
                ),
              ],
            ),
          ),
          // Text fields for reviews
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write your reviews',
              ),
              maxLines: null,
            ),
          ),
          // View all reviews and comment button
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => {},
                  child: Text('view all reviews'),
                ),
                TextButton(
                  onPressed: () => {},
                  child: Text('comment'),
                ),
              ],
            ),
          ),
        ],
      ),
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search, color: Color.fromARGB(255, 12, 12, 12)),
          ),
          BottomNavigationBarItem(
            label: "Upload",
            icon: Icon(Icons.add_box, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.card_giftcard,
                color: Color.fromARGB(255, 12, 12, 12)),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle,
                color: Color.fromARGB(255, 12, 12, 12)),
          ),
        ]
       ),
    );
  }
}
