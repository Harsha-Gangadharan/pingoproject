import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/joinus.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body:SingleChildScrollView( 
     child:  Padding(
        padding: const EdgeInsets.all(20.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Container(),
            Center(child: Image.asset("asset/welcome.png")),
             const SizedBox(height: 20.0,),
               Center(
                 child: SizedBox(height: 50.0,
                   child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Joinus(),));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 195, 60, 105) ),
                    child: Text('create an account',
                   style:GoogleFonts.inknutAntiqua(color: Colors.white) ,)
                   ),
                 ),
               ),
              
                  SizedBox(height: 50.0,
                   child: Center(
                     child: ElevatedButton(
                      onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context) => Getstart(),));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor:const Color.fromARGB(255, 195, 60, 105) ),
                      child:  Text('Sign in',
                     style:GoogleFonts.inknutAntiqua(color: Colors.white),
                     ),
                                    ),
                                  
                   ),
                 ),
          ],
        ),
     ),
      ),
    );
  }
}