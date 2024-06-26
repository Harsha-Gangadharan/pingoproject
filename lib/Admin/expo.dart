import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Admin/expopayment.dart';
import 'package:flutter_application_1/Admin/home.dart';
import 'package:flutter_application_1/Admin/login.dart';
import 'package:flutter_application_1/Admin/manageuser.dart';
import 'package:flutter_application_1/Admin/payment.dart';
import 'package:flutter_application_1/User/buynowpage.dart';
import 'package:flutter_application_1/User/cartpage.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/chatroom/chatscreen.dart';
import 'package:flutter_application_1/User/expopage.dart';
import 'package:flutter_application_1/User/review.dart';
import 'package:flutter_application_1/crud/notification_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminExpo extends StatefulWidget {
  const AdminExpo({Key? key}) : super(key: key);

  @override
  State<AdminExpo> createState() => _AdminExpoState();
}

class _AdminExpoState extends State<AdminExpo> {
   void _navigateToPalette() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminExpo()));
  }
  final _formKey = GlobalKey<FormState>();

  final TitleController = TextEditingController();
  final DescriptionController = TextEditingController();
  final DateController = TextEditingController();
  final VoteController = TextEditingController();
  final PriceController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  Future<void> ExpoDetailsadd() async {
    try {
      String uid = _auth.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('expo').doc();
      doc.set({
        'title': TitleController.text,
        'date': DateController.text,
        'Vote': VoteController.text,
        'Price': PriceController.text,
        'uid': uid,
        "expoId": doc.id
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bank details added successfully'),
        ),
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdHome()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add bank details: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 94, 133),
        title: Text(
          "Pingo",
          style: GoogleFonts.aclonica(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        actions: [
  Row(
    children: [
      SizedBox(width: 20.0),
      GestureDetector(
        onTap: () {
          _showLogoutBottomSheet(context); // Pass context to show bottom sheet
        },
        child: Icon(
          Icons.logout,
          color: Colors.black,
        ),
      ),
      SizedBox(width: 20.0),
      GestureDetector(
        onTap: _navigateToPalette,
        child: Icon(
          Icons.palette,
          color: Colors.black,
        ),
      ),
      SizedBox(width: 20.0),
      PopupMenuButton<int>(
        itemBuilder: (BuildContext context) => [
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.home),
                SizedBox(width: 8.0),
                Text('Home'),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                Icon(Icons.people),
                SizedBox(width: 8.0),
                Text('View Users'),
              ],
            ),
          ),
        ],
        onSelected: (int value) {
          if (value == 1) {
             Navigator.push(context, MaterialPageRoute(builder: (context) => AdHome()));
          }
           else if (value == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUser()));
          }
        },
      ),
    ],
  ),
],

      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: TitleController,
                    decoration: InputDecoration(
                      labelText: '  Title',
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Title';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: DescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Description';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: VoteController,
                    decoration: InputDecoration(
                      labelText: 'Vote',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Vote';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: DateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Date';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: PriceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Price';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 195, 60, 105),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ExpoDetailsadd().then((value) {
                            sendNotiifcation(
                              NotificationModel(
                                message: TitleController.text,
                                type: "Admin",
                              ),
                            );
                          });
                        }
                      },
                      child: Text(
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
  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await auth.signOut();
                      preferences.clear();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AdminLogin(),), (route) => false);
                      print('Logout confirmed');
                    },
                    child: const Text('Logout'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
