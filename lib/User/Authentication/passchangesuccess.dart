import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:google_fonts/google_fonts.dart';

class Passchangesuccess extends StatefulWidget {
  const Passchangesuccess({super.key});

  @override
  State<Passchangesuccess> createState() => _PasschangesuccessState();
}

class _PasschangesuccessState extends State<Passchangesuccess> {
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
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Getstart()),
                    );
                  },
                  child: Text(
                    ' Password Change Successfully',
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
