import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/createprofile.dart';
import 'package:flutter_application_1/User/Authentication/forgetpassword.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Getstart extends StatefulWidget {
  const Getstart({super.key});

  @override
  State<Getstart> createState() => _GetstartState();
}

class _GetstartState extends State<Getstart> {
  final _formkey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _EmailIdController = TextEditingController();

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  String email = '', password = '';

  userlogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (password != null) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        preferences.setString('islogin', credential.user!.uid);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in successfully'),
          ),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Packages(
                indexNum: 0,
              ),
            ));
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('error signup'),
          ),
        );
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('user not found'),
            ),
          );
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('wrong password'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Image.asset("asset/get.png")),
                Center(
                  child: Text(
                    'GET STARTED',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _EmailIdController,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(220, 201, 197, 197),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email Id';
                    } else if (!_emailRegex.hasMatch(value)) {
                      return 'Please Enter a Valid Email Id';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(220, 201, 197, 197),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = _EmailIdController.text;
                            password = _passwordController.text;
                          });
                          userlogin();
                        }

            //              Navigator.push(
            // context,
            // MaterialPageRoute(
            //   builder: (context) => packages(
            //     indexnum: 0,
            //   ),
            // ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 60, 105)),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Forgetpassword()),
                      );
                    },
                    child: Text(
                      'Forget your password ?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
