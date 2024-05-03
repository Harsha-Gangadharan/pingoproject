import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistConfirm extends StatefulWidget {
  const ArtistConfirm({Key? key}) : super(key: key);

  @override
  State<ArtistConfirm> createState() => _ArtistConfirmState();
}

class _ArtistConfirmState extends State<ArtistConfirm> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(149, 194, 24, 81),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Image.asset("asset/Artist.png")), // Corrected asset path
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'I, the undersigned, confirm that my works of art (paintings, statues and other works of art) are not subject to the UNESCO Convention of 14 November 1970. (Prohibition and prevention of illicit import, export and transfer of ownership of cultural property).',
                  style: GoogleFonts.inknutAntiqua(),
                ),
                leading: Radio<String>(
                  value: 'confirm',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                ),
              ),
               Center(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Color.fromARGB(174, 195, 60, 105)),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
