import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/otpverification.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
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
                  child: Image.asset(
                "asset/pass.png",
                width: 150.0,
                height: 150.5,
              )),
              SizedBox(height: 20.0,),
              Center(
                child: Text(
                  'Forget Your Password',
                  style: GoogleFonts.inknutAntiqua(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 165, 6, 86)),
                ),
              ),
              const Column(
                children: [
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Id or Phone Number ',
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        
                      ),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(220, 201, 197, 197),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Center(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () {   Navigator.push(context,MaterialPageRoute(builder: (context) => OTPVerificationPage(),));},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 181, 30, 80)),
                      child: const Text(
                        'Send',
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
