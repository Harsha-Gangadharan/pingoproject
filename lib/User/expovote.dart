import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expovote extends StatefulWidget {
  @override
  State<Expovote> createState() => _ExpovoteState();
}

class _ExpovoteState extends State<Expovote> {
  List<bool> isSelected = [false, false, false, false, false, false];
  List<int> voteCount = [0, 0, 0, 0, 0, 0];
  late List<bool> isLikedList;
  int index = 0;
  
  get g => null;

  @override
  void initState() {
    super.initState();
    isLikedList = List.generate(10, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Themes In Art',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Conflict and Adversity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10), // Adjust spacing
            Text(
              'Art can be added to this topic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 10), // Adjust spacing
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('asset/profile.png'), // Replace with your image
            ),
            SizedBox(height: 10), // Adjust spacing
            Center(
              child: Text(
                'Here a new one for you!\n Add art from your experiences on this topic',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 60, 155, 195),
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Container for the middle section
            const SizedBox(height: 16.0),
            Text('66 art works'),
            const SizedBox(height: 2.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                ),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildIconButton(0),
                buildIconButton(1),
                buildIconButton(2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(int buttonIndex) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSelected[buttonIndex] = !isSelected[buttonIndex];
                  if (isSelected[buttonIndex]) {
                    voteCount[buttonIndex]++;
                  } else {
                    voteCount[buttonIndex]--;
                  }
                });
              },
              icon: Icon(
                isSelected[buttonIndex]
                    ? Icons.thumb_up
                    : Icons.thumb_up_alt_outlined,
                color: isSelected[buttonIndex] ? Colors.black : null,
              ),
            ),
            Text('Votes: ${voteCount[buttonIndex]}'),
          ],
        ),
      ]
    );
  }
}
