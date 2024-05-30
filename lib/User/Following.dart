import 'package:flutter/material.dart';
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
      body: ListView.builder(
        itemCount: flowerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(flowerImages[index]),
                backgroundColor: Colors.grey[200],
              ),
              title: Text(
                userNames[index],
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  print('Following button pressed for ${userNames[index]}');
                },
                child: Text('Following'),
              ),
            ),
          );
        },
      ),
    );
  }
}
