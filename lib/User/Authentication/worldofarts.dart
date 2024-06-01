import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';

class Worldofarts extends StatefulWidget {
  const Worldofarts({Key? key}) : super(key: key);

  @override
  State<Worldofarts> createState() => _WorldofartsState();
}

class _WorldofartsState extends State<Worldofarts> {
  // Track which buttons are clicked
  final _auth = FirebaseAuth.instance;
  // List<bool> isSelected = [false, false, false, false, false, false];
  // List<String> isSelectedItem = [
  //   'Photo Realism',
  //   'Abstract',
  //   'Composite',
  //   'Whimsical',
  //   'Sculpture',
  //   'Cubism',
  // ];

  List<Map<String, dynamic>> items = [
    {"isSelected": false, "item": "Photo Realism"},
    {"isSelected": false, "item": "Abstract"},
    {"isSelected": false, "item": "Composite"},
    {"isSelected": false, "item": "Whimsical"},
    {"isSelected": false, "item": "Sculpture"},
    {"isSelected": false, "item": "Cubism"}
  ];
Future updateUserCategory(List category)async{
  FirebaseFirestore.instance.collection("useregisteration").doc(FirebaseAuth.instance.currentUser!.uid).update({"selected category":category});
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'World Of Arts',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffF04D6D),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Image.asset("asset/Pingo.png"),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        items[0]["isSelected"] = !items[0]["isSelected"];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: items[0]["isSelected"]
                          ? Colors.pink
                          : const Color.fromARGB(142, 123, 120, 121),
                    ),
                    child: const Text(
                      'Photo Realism',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        items[1]["isSelected"] = !items[1]["isSelected"];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: items[1]["isSelected"]
                          ? Colors.pink
                          : const Color.fromARGB(142, 123, 120, 121),
                    ),
                    child: const Text(
                      'Abstract',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items[2]["isSelected"] = !items[2]["isSelected"];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: items[2]["isSelected"]
                        ? Colors.pink
                        : const Color.fromARGB(142, 123, 120, 121),
                  ),
                  child: const Text(
                    'Composite',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items[3]["isSelected"] = !items[3]["isSelected"];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: items[3]["isSelected"]
                        ? Colors.pink
                        : const Color.fromARGB(142, 123, 120, 121),
                  ),
                  child: const Text(
                    'Whimsical',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]),
              const SizedBox(height: 20.0),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items[4]["isSelected"] = !items[4]["isSelected"];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: items[4]["isSelected"]
                        ? Colors.pink
                        : const Color.fromARGB(142, 123, 120, 121),
                  ),
                  child: const Text(
                    'Sculpture',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items[5]["isSelected"] = !items[5]["isSelected"];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: items[5]["isSelected"]
                        ? Colors.pink
                        : Color.fromARGB(142, 123, 120, 121),
                  ),
                  child: const Text(
                    'Cubism',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  final selectedItemslist = items
                      .where((element) => element["isSelected"] == true)
                      .toList();
                  List<String> myList = [];
                  for (var i in selectedItemslist) {
                    myList.add(i["item"]);
                  }
                  log(myList.toString());
updateUserCategory(myList).then((value) => 
 Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Packages(
                          indexNum: 0,
                        ),
                      )));
                  
                
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(142, 123, 120, 121),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
