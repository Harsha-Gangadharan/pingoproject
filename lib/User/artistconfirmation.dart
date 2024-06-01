import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Editbankdetails.dart';
import 'package:flutter_application_1/User/addbankdetail.dart';
import 'package:flutter_application_1/User/newpost.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtistConfirm extends StatefulWidget {
  String expoId;
   ArtistConfirm({Key? key,required this.expoId}) : super(key: key);

  @override
  State<ArtistConfirm> createState() => _ArtistConfirmState();
}

int? _selectedValue;

class _ArtistConfirmState extends State<ArtistConfirm> {
  int? _selectedOption;

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
              Center(child: Image.asset("asset/Artist.png")),
              SizedBox(height: 20),
              ListTile(
                title: Text(
                  'I, the undersigned, confirm that my works of art (paintings, statues and other works of art) are not subject to the UNESCO Convention of 14 November 1970. (Prohibition and prevention of illicit import, export and transfer of ownership of cultural property).',
                  style: GoogleFonts.inknutAntiqua(),
                ),
              ),
              ListTile(
                leading: Radio(
                  value: 1,
                  groupValue: _selectedOption,
                  toggleable: true,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value as int?;
                      log(_selectedOption.toString());
                    });
                  },
                ),
                title: Text('Confirm'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectedOption == 1
                      ? Center(
                          child: SizedBox(
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Do you want to edit the bank details?',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditBankDetails()),
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Color.fromARGB(
                                                      174, 195, 60, 105),
                                                ),
                                                child: Text('Edit'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                     Navigator.push(context, MaterialPageRoute(builder: (context) => NewPost(expoId: widget.expoId,)));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey,
                                                ),
                                                child: Text('No'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(174, 195, 60, 105),
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          height: 50.0,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            child: const Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
