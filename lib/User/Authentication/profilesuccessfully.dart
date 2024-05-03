import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/User/Authentication/worldofarts.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilesuccessfully extends StatefulWidget {
  const Profilesuccessfully({super.key});

  @override
  State<Profilesuccessfully> createState() => _ProfilesuccessfullyState();
}

class _ProfilesuccessfullyState extends State<Profilesuccessfully> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Image.asset("asset/tick.png")),
                            Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Worldofarts()),
                    );
                  },
                  child: Text(
                    ' Profile Created Successfully',
                     style: GoogleFonts.inknutAntiqua(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                      color: Colors.green),
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
