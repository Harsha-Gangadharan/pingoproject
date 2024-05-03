import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Added extends StatefulWidget {
  const Added({super.key});

  @override
  State<Added> createState() => _AddedState();
}

class _AddedState extends State<Added> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Image.asset("asset/tick.png")),
              Center(
                child: Text(
                  'Added Successfully ',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 10, 147, 53),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
