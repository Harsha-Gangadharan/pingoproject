import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/expopayment.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/Admin/expo.dart';
import 'package:flutter_application_1/Admin/manageuser.dart';
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
                onTap: _logout,
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
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      child: GestureDetector(
                        onTap: _navigateToHome,
                        child: Row(
                          children: [
                            Icon(Icons.home),
                            SizedBox(width: 8.0),
                            Text('Home')
                          ],
                        ),
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(Icons.people),
                          SizedBox(width: 8.0),
                          Text('View Users')
                        ],
                      ),
                      value: 2,
                    ),
                  ];
                },
                onSelected: (value) {
                  if (value == 2) {
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
}
