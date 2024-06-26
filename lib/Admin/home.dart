import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/expopayment.dart';
import 'package:flutter_application_1/Admin/login.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Admin/expo.dart';
import 'package:flutter_application_1/Admin/manageuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
 // Import the new page

class AdHome extends StatefulWidget {
  const AdHome({Key? key}) : super(key: key);

  @override
  State<AdHome> createState() => _AdHomeState();
}

class _AdHomeState extends State<AdHome> {
  void _navigateToPalette() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminExpo()));
  }

  void _logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdHome()));
  }

  void _navigateToHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdHome()));
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
            _navigateToHome();
          } else if (value == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ManageUser()));
          }
        },
      ),
    ],
  ),
],

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('expo').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Expo Found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var expo = snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return ListTile(
                title: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExpoPayment(expo: expo)),
                    );
                  },
                  child: Text(expo['title']),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ${expo['Price']}'),
                    Text('Vote: ${expo['Vote']}'),
                    Text('Date: ${expo['date']}'),
                    Text('Expo ID: ${expo['expoId']}'),
                    Text('UID: ${expo['uid']}'),
                  ],
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


