import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdHome extends StatefulWidget {
  const AdHome({Key? key}) : super(key: key);

  @override
  State<AdHome> createState() => _AdHomeState();
}

class _AdHomeState extends State<AdHome> {
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
              Icon(
                Icons.logout,
                color: Colors.black,
              ),
              SizedBox(width: 20.0),
              Icon(
                Icons.palette,
                color: Colors.black,
              ),
              SizedBox(width: 20.0),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Row(
                        children: [Icon(Icons.home), Text('Home')],
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [Icon(Icons.people), Text('View Users')],
                      ),
                      value: 2,
                    ),
                  ];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
