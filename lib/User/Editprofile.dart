import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/proflie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _bioController = TextEditingController();
  late String email = '';
  late String password = '';

  Future<void> addFirebase(Map<String, dynamic> registeredUserInfoMap, String userId) async {
    await FirebaseFirestore.instance.collection('user_registration').doc(userId).set(registeredUserInfoMap);
  }

  Future<void> registerUser() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Success'),
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));

      final registeredUserId = randomAlphaNumeric(10);
      final registerInfoMap = {
        "name": _nameController.text,
        "username": _usernameController.text,
        "bio": _bioController.text,
        "phoneNumber": _phoneNumberController.text,
        "id": registeredUserId,
      };

      await addFirebase(registerInfoMap, registeredUserId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details added to Firebase successfully')),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'enter phone number') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter phone number')),
        );
      } else if (e.code == 'username-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username already in use')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred')),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Profile created successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
          child: Form(
            key: _formKey,
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
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    'Edit Profile',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Center(
                      child: Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                    ),
                    SizedBox(height: 20.0),
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
                SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
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
                  controller: _usernameController,
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
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
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
                  controller: _bioController,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    prefixIcon: const Icon(Icons.person),
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
                SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showSuccessDialog();
                          registerUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 195, 60, 105),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
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
