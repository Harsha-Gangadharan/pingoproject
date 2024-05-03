import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/passchangesuccess.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
              Center(
                child: SizedBox(
                  width: 300, 
                  height: 300, 
                  child: Image.asset("asset/new.png"),
                ),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: Text(
                  'Change Password',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color:Color.fromARGB(255, 145, 10, 98),
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(220, 199, 192, 192),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.remove_red_eye_rounded),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(220, 201, 197, 197),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(context,MaterialPageRoute(builder: (context) => Passchangesuccess(),));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 60, 105)),
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
