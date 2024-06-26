import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_1/User/Authentication/joinus.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xffE13884),
         title: const Text('WELCOME'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: const Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: Stack(
        children: [Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/wl.png"), // Replace with your image path
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // Change the opacity value here (0.5 for 50% opacity)
              BlendMode.dstATop, // Adjust the blend mode as needed
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        
      ),
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 300,),
            child: Center( // Wrap the Column with Center
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: double.infinity, // Make the button take the full width
                    child: Center(
                      child: ElevatedButton(
                        
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Joinus()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:   Color(0xff971352),
                          fixedSize: Size(250, 50)
                        ),
                        child: Text(
                          'Create an Account',
                          style: GoogleFonts.inknutAntiqua(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Add some space between the buttons
                  SizedBox(
                    height: 50.0,
                    width: double.infinity, // Make the button take the full width
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Getstart()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Color(0xff971352),
                          fixedSize: Size(250, 50)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign In',
                            style: GoogleFonts.inknutAntiqua(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ]
    ),
    );
  }
}
