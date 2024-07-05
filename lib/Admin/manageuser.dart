import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/expo.dart';
import 'package:flutter_application_1/Admin/home.dart';
import 'package:flutter_application_1/Admin/login.dart';
import 'package:flutter_application_1/User/complaintprovider.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/model/compainmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageUser extends StatelessWidget {
  ManageUser({Key? key}) : super(key: key);

  final CollectionReference users =
      FirebaseFirestore.instance.collection('useregisteration');

  get context => null;

  void _showReportBottomSheet(
      BuildContext context, String userId, String userName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('useregisteration')
              .doc(userId)
              .collection('Raisedissue')
              .doc(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text('No data found');
            }

            if (snapshot.data!.exists) {
              return Container(
                height: 300,
                child: Column(
                  children: [
                    Divider(),
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                            'THE RAISED COUND ${snapshot.data!['count'].toString()}'),

                        // Text('THE SELLER ID ${snapshot.data!['sellerId']}')
                      ],
                    )),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      child: Text('Close'),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  void _deleteUser(String userId) {
    users.doc(userId).delete().then((_) {
      print("User deleted");
      ScaffoldMessenger.of(context!).showSnackBar(
        const SnackBar(
          content: Text('User deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }).catchError((error) {
      print("Failed to delete user: $error");
    });
  }

  void _logout() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AdHome()));
  }

  void _navigateToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdHome()));
  }

  @override
  Widget build(BuildContext context) {
    int complaintsCount =
        Provider.of<ComplaintProvider>(context).complaintsCount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 94, 133),
        title: Text(
          "Pingo - Complaints: $complaintsCount",
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
                  _showLogoutBottomSheet(
                      context); // Pass context to show bottom sheet
                },
                child: Icon(
                  Icons.logout,
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
      body: StreamBuilder(
        stream: users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('No users found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var user = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(user['image']),
                    backgroundColor: Colors.grey[200],
                  ),
                  title: Text(
                    user['name'],
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _deleteUser(user.id);
                        },
                        child: Text('Delete'),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          print('Complaints box tapped for ${user['name']}');
                          _showReportBottomSheet(
                              context, user.id, user['name']);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Complaints',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
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
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLogin(),
                          ),
                          (route) => false);
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
