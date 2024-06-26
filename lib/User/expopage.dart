import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/expovote.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtExpo extends StatefulWidget {
  @override
  State<ArtExpo> createState() => _ArtExpoState();
}

class _ArtExpoState extends State<ArtExpo> {
  // List<String> expoTitles = [];
  List<Map<String, dynamic>> data=[];
  

  @override
  void initState() {
    super.initState();
    fetchExpoTitles();
  }

  Future<void> fetchExpoTitles() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    var querySnapshot = await FirebaseFirestore.instance.collection('expo').get();
    setState(() {
       data= querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Art Expo',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Explore Themes In Art',
              style: GoogleFonts.inknutAntiqua(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Expovote(expoId: data[index]["expoId"],)),
                    );
                  },
                  title: Text(data[index]["title"]),
                );
              },
            ),
          ),
        ],
      ),
       bottomNavigationBar: MyNav(index:0, onTap: (index){
  setState(() {
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Packages(indexNum: index)))   ;       });
       }, firestore:  FirebaseFirestore.instance, auth: FirebaseAuth.instance),
    );
  }
}
