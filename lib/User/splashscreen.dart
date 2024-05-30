import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/welcome.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('asset/logodesign.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setVolume(0);
        });
      });
       
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
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xff1F0010),
      body: Center(
        child: SizedBox(
          height: 500,
          width: 500,
          
                  child: VideoPlayer(_controller),
                
            
        ),
      ),
    );
  }
}
