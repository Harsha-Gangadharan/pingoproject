import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/addbankdetail.dart';
import 'package:flutter_application_1/User/artistconfirmation.dart';
import 'package:flutter_application_1/User/cartpage.dart';
import 'package:flutter_application_1/User/risktask.dart';
import 'package:flutter_application_1/chatroom/chatscreen.dart';
import 'package:flutter_application_1/User/expopage.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/chatroom/message.dart';
import 'package:flutter_application_1/User/order.dart';
import 'package:flutter_application_1/User/proflie.dart';
import 'package:flutter_application_1/User/search.dart';

class Packages extends StatefulWidget {
  int indexNum = 0;
  Packages({Key? key, required this.indexNum});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<Widget> _pages = [
  const HomePage(),
  SearchPage(),
  ArtistConfirm(expoId: "",),
  OrderPage(),
   ProfilePage(id: FirebaseAuth.instance.currentUser!.uid,),
  // ArtistConfirm(),
  Chatscreen(),
//  BankDetailsPage(),
 CartPage(),
 ArtExpo()
 

];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.indexNum],
      bottomNavigationBar: MyNav(
        index: widget.indexNum,
        onTap: (index) {
          setState(() {
            widget.indexNum = index;
          });
        },
        firestore: _firestore,
        auth: _auth,
      ),
    );
  }
}

class MyNav extends StatefulWidget {
  final int index;
  final void Function(int)? onTap;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  const MyNav({
    Key? key,
    required this.index,
    required this.onTap,
    required this.firestore,
    required this.auth,
  }) : super(key: key);

  @override
  _MyNavState createState() => _MyNavState();
}

class _MyNavState extends State<MyNav> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _fetchProfileImage();
  }

  @override
  void didUpdateWidget(covariant MyNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.auth.currentUser != widget.auth.currentUser) {
      _fetchProfileImage();
    }
  }

  Future<void> _fetchProfileImage() async {
    String id = widget.auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await widget.firestore.collection('useregisteration').doc(id).get();
    setState(() {
      _imageUrl = userSnapshot.data()?['image'];
    });
  }



  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      currentIndex: widget.index,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      showSelectedLabels: true,
      onTap: widget.onTap,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home, color: Color.fromARGB(255, 12, 12, 12)),
        ),
        BottomNavigationBarItem(
          label: "Search",
          icon: Icon(Icons.search, color: Color.fromARGB(255, 12, 12, 12)),
        ),
        BottomNavigationBarItem(
          label: "Upload",
          icon: Icon(Icons.add_box, color: Colors.black),
        ),
        BottomNavigationBarItem(
          label: "Order",
          icon: Icon(Icons.card_giftcard,
              color: Color.fromARGB(255, 12, 12, 12)),
        ),
       BottomNavigationBarItem(
  label: "Profile",
  icon: CircleAvatar(
    radius: 12,
    backgroundColor: Color.fromARGB(255, 12, 12, 12),
    child: (_imageUrl != null && _imageUrl!.isNotEmpty && Uri.tryParse(_imageUrl!)?.hasAbsolutePath == true)
        ? ClipOval(
            child: Image.network(
              _imageUrl!,
              width: 24,
              height: 24,
              fit: BoxFit.cover,
            ),
          )
        : Icon(Icons.account_circle, color: Colors.white),
  ),
),

      ],
    );
  }
}
