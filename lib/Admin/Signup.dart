import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Admin/home.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({super.key});

  @override
  _AdminSignUpState createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  final _NameController=TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _UsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _EmailIdController = TextEditingController();
   final _PhonenumberController = TextEditingController();
  final _emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); 

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
             Center(child: Image.asset("asset/adsign.png")),
             const SizedBox(height: 20.0,),
              Center(
                child: Text(
                  'Admin Signup',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
                  ),  Center(
                child: Text(
                  'Add Photo',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _NameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(220, 199, 192, 192),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.0),
                TextFormField(
                   autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _UsernameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(220, 199, 192, 192),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                   validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _PhonenumberController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.call),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Color.fromARGB(220, 199, 192, 192),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Phonenumber';
                    }
                    return null;
                  },
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
                  maxLines: 1,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '*** Password',
                    prefixIcon: Icon(Icons.lock),  // Change to lock icon
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
                    onPressed: () {
                       if (_formkey.currentState!.validate()) {
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
                        }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 195, 60, 105),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
              ]
          ),
        ),
      ),
    ),
    ),
    );
  }
}
