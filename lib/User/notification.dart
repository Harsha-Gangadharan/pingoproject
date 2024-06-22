import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/crud/notification_model.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isOrdersSelected = false;
  bool _isActivitiesSelected = false;
  int _selectedIndex = 0;

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotifcation() {
    return FirebaseFirestore.instance
        .collection("Notifications")
        .where("type", isEqualTo: "Admin")
        .snapshots();
  }

  Stream<QuerySnapshot> getCurrentUserNotification() {
    return FirebaseFirestore.instance
        .collection("Notifications")
        .where("fromId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> getCurrentUserNotificationadmin() {
    return FirebaseFirestore.instance
        .collection("Notifications")
        .where("type", isEqualTo: 'Admin')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Notification',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon pressed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOrdersSelected = true;
                    _isActivitiesSelected = false;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isOrdersSelected ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Orders',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOrdersSelected = false;
                    _isActivitiesSelected = true;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isActivitiesSelected ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Activities',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Add your main content here
          Expanded(
            child: Center(
              child: _isOrdersSelected
                  ? Column(
                      children: [
                        StreamBuilder(
                          stream: getCurrentUserNotification(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }

                            List<NotificationModel> notifi;

                            notifi = snapshot.data!.docs.map((e) {
                              return NotificationModel.fromJson(
                                  e.data() as Map<String, dynamic>);
                            }).toList();

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: notifi.length,
                              itemBuilder: (context, index) {
                                final user = notifi[index].fromId;

                                final userdetail = db
                                    .collection('useregisteration')
                                    .doc(user)
                                    .snapshots();

                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Material(
                                    elevation: 4,
                                    child: Column(
                                      children: [
                                        Text('Your Item Order By '),
                                        StreamBuilder(
                                          stream: userdetail,
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            }
                                            if (snapshot.hasData) {
                                              return Text(
                                                  'NAME : ${snapshot.data!['name']}  ');
                                            }
                                            return Container();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 50,
                                );
                              },
                            );
                          },
                        )
                      ],
                    )
                  : _isActivitiesSelected
                      ? Column(
                          children: [
                            StreamBuilder(
                              stream: getCurrentUserNotificationadmin(),
                              builder: (context, snapshot) {


                                List<NotificationModel> notifi;

                            notifi = snapshot.data!.docs.map((e) {
                              return NotificationModel.fromJson(
                                  e.data() as Map<String, dynamic>);
                            }).toList();
                                  
                                return ListView.separated(
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: notifi.length,
                                  itemBuilder: (context, index) {
                                    return Material(
                                      elevation: 4,
                                      child: Column(
                                        children: [
                                          Text(' ${notifi[index].message.toString()} EXPO ADDED'),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 50,
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        )
                      : Text('Select a title above'),
            ),
          ),
        ],
      ),
    );
  }
}

final auth = FirebaseAuth.instance;

final db = FirebaseFirestore.instance;
