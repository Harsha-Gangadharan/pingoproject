import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List<String> users = [
    'user1',
    'user2',
    'user3',
    'user4',
    'user5',
    'user6',
    'user7',
    'user8',
    'user9',
    'user10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  backgroundColor: Color.fromARGB(192, 255, 64, 128),
  title: TextField(
    style: TextStyle(color: Colors.black), // Set text color to white
    decoration: InputDecoration(
      filled: true,
       fillColor: Colors.white.withOpacity(0.5), // Set background color
      hintText: 'Search',
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Set content padding
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0), // Set border radius
        borderSide: BorderSide.none, // Remove border side
      ),
      hintStyle: TextStyle(color: Colors.black), // Set hint color
    ),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.search, color: Colors.black), // Set icon color to white
      onPressed: () {
        // Handle search
      },
    ),
    IconButton(
      icon: Icon(Icons.camera_alt, color: Colors.black), // Set icon color to white
      onPressed: () {
        // Handle camera
      },
    ),
  ],
),

      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(users[index][0].toUpperCase()),
            ),
            title: Text(users[index]),
            onTap: () {
              // Handle user tap
            },
          );
        },
      ),
    );
  }
}
