import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'NEW POST',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: 200, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.currency_rupee, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter description',
                labelText: 'Description',
              ),
              maxLines: 3,
            ),
            Spacer(), // Adds flexible space between the text field and the button
            ElevatedButton(
              onPressed: () {
                // Add your share functionality here
                print('Share button pressed');
              },
              child: Text('Share'),
            ),
          ],
        ),
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
