import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/expovote.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtExpo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Art Expo'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Explore Themes In Art',
              style: GoogleFonts.inknutAntiqua(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Expovote()),
                          );
                        },
                        child: _buildContainer(context, title: 'Conflict and Adversity'),
                      ),
                      _buildContainer(context, title: 'Heroes and Leaders'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      _buildContainer(context, title: 'Humans and Environment'),
                      _buildContainer(context, title: 'Identity'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainer(BuildContext context, {required String title}) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(title),
        ),
      ),
    );
  }
}

class ConflictAdversityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conflict and Adversity'),
      ),
      body: Center(
        child: Text('This is the Conflict and Adversity screen'),
      ),
    );
  }
}
