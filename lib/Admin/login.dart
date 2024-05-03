import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Admin/home.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _formkey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _EmailIdController = TextEditingController();

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 80, right: 80),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: Image.asset("asset/login.png")),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Text(
                        'Admin Login',
                        style: GoogleFonts.inknutAntiqua(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _EmailIdController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(220, 199, 192, 192),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                    SizedBox(height: 50.0),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      maxLines: 1,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: '*** Password',
                        prefixIcon: Icon(Icons.lock), // Change to lock icon
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(220, 199, 192, 192),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Your Password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 50.0,
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () { if (_formkey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdHome(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid name,username, password, or EmailId and phone number'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 195, 60, 105),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
