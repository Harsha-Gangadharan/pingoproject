import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:flutter_application_1/User/proflie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

File? selectedImage;

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _bioController = TextEditingController();
  late String email = '';
  late String password = '';
  int maxLength = 10;
  
  Future<void> addFirebase(
      Map<String, dynamic> registeredUserInfoMap, String userId) async {
    await FirebaseFirestore.instance
        .collection('user_registration')
        .doc(userId)
        .set(registeredUserInfoMap);
  }

  Future<void> updateProfile() async {
    String id = _auth.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection('useregisteration')
          .doc(id)
          .update({
        'name': _nameController.text,
        'username': _usernameController.text,
        'bio': _bioController.text,
        'phoneNumber': _phoneNumberController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  Packages(indexNum: 0,),));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    setState(() {
      selectedImage = File(pickedImage.path);
    });
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Photo Library'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    if (selectedImage != null) {
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      final currenttime = TimeOfDay.now();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('shoapimage/shoap$currenttime')
          .putFile(selectedImage!, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String url = await snapshot.ref.getDownloadURL();
      String id = _auth.currentUser!.uid;
      await FirebaseFirestore.instance
          .collection('useregisteration')
          .doc(id)
          .update({'image': url});
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
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: selectedImage != null
                                  ? FileImage(selectedImage!)
                                  : AssetImage('asset/profile.png')
                                      as ImageProvider<Object>),
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _showImagePickerOptions(context);
                        },
                        child: Text(
                          'Add Profile Photo',
                          style: GoogleFonts.inknutAntiqua(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                  inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
                  decoration: const InputDecoration(
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
                  controller: _bioController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateProfile();
                          _uploadImage();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 195, 60, 105),
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
