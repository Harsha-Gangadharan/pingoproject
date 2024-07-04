import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:flutter_application_1/User/Editprofile.dart';
import 'package:flutter_application_1/User/Following.dart';
import 'package:flutter_application_1/User/addaddress.dart';
import 'package:flutter_application_1/User/addbankdetail.dart';
import 'package:flutter_application_1/User/followerspage.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:flutter_application_1/User/sellerorder.dart';
import 'package:flutter_application_1/User/wishlist.dart';
import 'package:flutter_application_1/User/yourorders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String id;
  ProfilePage({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getSelectedUserProfile(
      String id) async {
    return firestore
        .collection("productdetails")
        .where("uid", isEqualTo: id)
        .get();
  }

  Future<int> getUserPostCount(String userId) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("productdetails")
        .where("uid", isEqualTo: userId)
        .get();
    return snapshot.size;
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: StreamBuilder<DocumentSnapshot>(
          stream: firestore
              .collection('useregisteration')
              .doc(widget.id)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.hasError) {
              return const Center(child: Text('No data available'));
            }
            DocumentSnapshot data = snapshot.data!;
            if (!data.exists) {
              return const Center(child: Text('No data available'));
            }
            String username = data.get('username') ?? 'No Username';
            return Text(
              username,
              style: GoogleFonts.inknutAntiqua(
                fontSize: 26,
                color: const Color.fromARGB(255, 14, 14, 14),
              ),
            );
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'wishlist',
                child: Row(
                  children: [
                    Icon(Icons.favorite),
                    SizedBox(width: 10),
                    Text('Wishlist'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text('Settings'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'wishlist':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WishlistPage()));
                  break;
                case 'logout':
                  _showLogoutBottomSheet();
                  break;
                case 'settings':
                  _showSettingsBottomSheet();
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
              child: StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection('useregisteration')
                    .doc(widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.hasError) {
                    return const Center(child: Text('No data available'));
                  }
                  DocumentSnapshot data = snapshot.data!;
                  if (!data.exists) {
                    return const Center(child: Text('No data available'));
                  }
                  String imageUrl = data.get('image') ?? '';
                  String name = data.get('username') ?? 'No Name';
                  String bio = data.get('bio') ?? 'No Bio';
                  return Column(
                    children: [
                      CircleAvatar(
  radius: 50,
  backgroundColor: Colors.grey, // Placeholder background color
  child: imageUrl != null && imageUrl!.isNotEmpty && Uri.parse(imageUrl!).isAbsolute
      ? ClipOval(
          child: Image.network(
            imageUrl!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        )
      : const Icon(
          Icons.account_circle,
          size: 100,
          color: Colors.white,
        ),
),

                      const SizedBox(height: 16),
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(bio),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FutureBuilder<int>(
                            future: getUserPostCount(widget.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              int postCount = snapshot.data ?? 0;
                              return Column(
                                children: [
                                  Text(
                                    '$postCount',
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    'Posts',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              );
                            },
                          ),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('useregisteration')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Followers")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                if (snapshot.hasData) {
                                  return _buildStatColumn('Followers',
                                      snapshot.data!.docs.length.toString(),
                                      () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FollowingList()),
                                    );
                                  });
                                } else {
                                  return const SizedBox();
                                }
                              }),
                          StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('useregisteration')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("Following")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const SizedBox();
                                }
                                if (snapshot.hasData) {
                                  return _buildStatColumn('Following',
                                      snapshot.data!.docs.length.toString(),
                                      () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FollowingListPage()),
                                    );
                                  });
                                } else {
                                  return const SizedBox();
                                }
                              }),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditProfile()));
                    print('Edit Profile button pressed');
                  },
                  child: const Text('Edit Profile'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    print('Follow button pressed');
                    // Add follow functionality here
                  },
                  child: const Text('Follow'),
                ),
              ],
            ),
            const Divider(),
            FutureBuilder(
              future: getSelectedUserProfile(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                final userData = snapshot.data!.docs;

                return SizedBox(
                  height: 500,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (userData[index]["uid"] == currentUserId) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete'),
                                content: const SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('Would you like to delete your product?'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("productdetails")
                                          .doc(userData[index]["productId"])
                                          .delete()
                                          .then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Packages(
                                                    indexNum: 0,
                                                  )),
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'You are not authorized to delete this product.')),
                            );
                          }
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(userData[index]["productimage"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildStatColumn(String label, String value, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label),
      ],
    ),
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
                leading: const Icon(Icons.notifications),
                title: const Text('Notification'),
                onTap: () {
                  print('Notification tapped');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.account_balance),
                title: const Text('Add Your Bank Details'),
                onTap: () {
                  print('Add Your Bank Details tapped');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BankDetailsPage()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Saved Address'),
                onTap: () {
                  print('Saved Address tapped');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddAddressPage()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Your Orders'),
                onTap: () {
                  print('Your Orders tapped');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SellerOrderPage(
                                uid: widget.id,
                              )));
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
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
                          builder: (context) => Getstart(),
                        ),
                        (route) => false,
                      );
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
