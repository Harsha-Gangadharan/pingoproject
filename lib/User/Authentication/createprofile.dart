import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/User/Authentication/profilesuccessfully.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/User/Authentication/createprofile.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
class Createprofile extends StatefulWidget {
  const Createprofile({super.key});

  @override
  State<Createprofile> createState() => _CreateprofileState();
}

class _CreateprofileState extends State<Createprofile> {
  final _formkey = GlobalKey<FormState>();
   final _UsernameController = TextEditingController();
  final _NameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _BioController = TextEditingController();
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  
  String email = '';
  String password = '';
  Future addfirebase(Map<String,dynamic>registerreduserinfomap,String userid)async{
  return FirebaseFirestore.instance
  .collection('useregisteration')
    .doc(userid)
    .set(registerreduserinfomap);
 }
  registration() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Success'),),
      );
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Createprofile()));
       String registered_user_id=randomString(10);
       Map<String,dynamic>registerinfomap={
        "name":_NameController.text,
         "username":_UsernameController.text,
        "bio":_BioController.text,
        "phonenumber":_phonenumberController.text,
        "id":registered_user_id,
       };
       await addfirebase(registerinfomap,registered_user_id );
       const SnackBar(content:Text('details added to firebase successfully'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'enter phone number') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('enter phone number'),),
        );
      } else if (e.code == 'username-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('usename already in use'),),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred'),),
      );
    }
  }

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
                  width: 200, 
                  height: 200, 
                  child: Image.asset("asset/pro.png"),
                ),
              ),
              const SizedBox(height: 20.0,),
              Center(
                child: Text(
                  'Create Account',
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
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Center(
                    child: Text(
                      'Add Profile Photo',
                      style: GoogleFonts.inknutAntiqua(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _NameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(220, 199, 192, 192),
                ),
                 validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Name';
                    }
                    return null;
                  },
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _UsernameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(220, 201, 197, 197),
                ),
                 validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
              ),
              const SizedBox(height: 20.0),
               TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _phonenumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(220, 201, 197, 197),
                ),
                 validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Phone Number';
                    }
                    return null;
                  },
              ),
              const SizedBox(height: 20.0),
           TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _BioController,
                decoration: InputDecoration(
                  labelText: 'Bio',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Color.fromARGB(220, 201, 197, 197),
                ),
               validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Bio';
                    }
                    return null;
                  },  
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () {
                         Navigator.push(context,MaterialPageRoute(builder: (context) => Profilesuccessfully(),));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 195, 60, 105)),
                      child: const Text(
                        'Create',
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
