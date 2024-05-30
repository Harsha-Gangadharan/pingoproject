import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:flutter_application_1/User/Authentication/joinus.dart';
import 'package:flutter_application_1/User/Authentication/welcome.dart';

import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoPage extends StatefulWidget {
  const LogoPage({super.key});

  @override
  State<LogoPage> createState() => _LogoPageState();
}

class _LogoPageState extends State<LogoPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Timer(const Duration(seconds: 1), () => check());
    });
  }

  check() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('islogin');
    if (name != null) {
     Navigator.push(context,MaterialPageRoute(builder: (context) => Packages(indexNum: 0,),));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Welcome()));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
