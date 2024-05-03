


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:flutter_application_1/User/Editprofile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  final List<String> posts = [
    'asset/product_image.png',
    'asset/product_image.png',
  ];
  final firestore=FirebaseFirestore.instance;
final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String id=auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: StreamBuilder(stream: firestore.collection('useregisteration').doc(id).snapshots(),
         builder: (context,snapshot)
         {
          DocumentSnapshot data=snapshot.data!;
           return  Text('${data['username']}',style: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: const Color.fromARGB(255, 14, 14, 14),
        ),);
              
         }
         ),
       
     
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(width: 10),
                    Text('Wishlist'),
                  ],
                ),
                value: 'wishlist',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
                value: 'logout',
              ),
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
                value: 'settings',
              ),
            ],
            onSelected: (value) {
              // Handle menu item selection
              switch (value) {
                case 'wishlist':
                  print('Wishlist selected');
                  break;
                case 'logout':
                  print('Logout selected');
                  _showLogoutBottomSheet(); // Show logout confirmation bottom sheet
                  break;
                case 'settings':
                  _showSettingsBottomSheet(); // Show settings bottom sheet
                  break;
                default:
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder(stream:firestore.collection('useregisteration').doc(id).snapshots() ,
               builder: (context,snapshot)
               {
                DocumentSnapshot data=snapshot.data!;
                return  Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('asset/profile.png'), // Replace with your image path
                  ),
                  SizedBox(height: 16),
                  Text(
                    '${data['username']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('Bio description here'),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatColumn('Posts', '100'),
                      _buildStatColumn('Followers', '10K'),
                      _buildStatColumn('Following', '50'),
                    ],
                  ),
                ],
              );

               }
               )
             
            ),
            // Edit Profile Button
            TextButton(
              onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>EditProfile(),));
                print('Edit Profile button pressed');
              },
              child: Text('Edit Profile'),
            ),
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0, // Adjust the gap between images vertically
                crossAxisSpacing: 20.0, // Adjust the gap between images horizontally
              ),
              itemBuilder: (context, index) {
                return Image.asset(
                  posts[index],
                  fit: BoxFit.cover,
                  height: 100, // Adjust the height of the images
                  width: 100, // Adjust the width of the images
                );
              },
            ),
          ],
        ),
      ),
      
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notification'),
                onTap: () {
                  print('Notification tapped');
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text('Add Your Bank Details'),
                onTap: () {
                  print('Add Your Bank Details tapped');
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Saved Address'),
                onTap: () {
                  print('Saved Address tapped');
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Your Orders'),
                onTap: () {
                  print('Your Orders tapped');
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: ()async {
                      SharedPreferences preferences=await SharedPreferences.getInstance();
                      auth.signOut().then((value) =>Navigator.push(context,MaterialPageRoute(builder: (context)=> Getstart())));
                      preferences.clear();
                     // log('logout successfully' as num);
                      
                      print('Logout confirmed');
                      Navigator.pop(context);
                    },
                    child: Text('Logout'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
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
