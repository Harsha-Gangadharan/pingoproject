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
  List<bool> isSelected = [false, false, false, false, false, false];

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
                        isSelected[0] = !isSelected[0];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected[0] ? Colors.pink : const Color.fromARGB(142, 123, 120, 121),
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
                        isSelected[1] = !isSelected[1];
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected[1] ? Colors.pink : const Color.fromARGB(142, 123, 120, 121),
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
                      isSelected[2] = !isSelected[2];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected[2] ? Colors.pink : const Color.fromARGB(142, 123, 120, 121),
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
                      isSelected[3] = !isSelected[3];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected[3] ? Colors.pink : const Color.fromARGB(142, 123, 120, 121),
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
                      isSelected[4] = !isSelected[4];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected[4] ? Colors.pink : const Color.fromARGB(142, 123, 120, 121),
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
                      isSelected[5] = !isSelected[5];
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected[5] ? Colors.pink : Color.fromARGB(142, 123, 120, 121),
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
                 Navigator.push(context,MaterialPageRoute(builder: (context) => packages(indexnum: 0,),));
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
