import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressPage extends StatefulWidget {
  

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final houseNumberController = TextEditingController();
  final roadAreaColonyController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final nearFamousPlaceController = TextEditingController();
  final nameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;

Future<void> AddressDetailsadd() async {
  try {
    String uid = _auth.currentUser!.uid;
    await FirebaseFirestore.instance.collection('addressdetails').doc(uid).set({
      'address.houseNumber': houseNumberController.text,
      'address.roadAreaColony': roadAreaColonyController.text,
      'address.pincode': pincodeController.text,
      'address.city': cityController.text,
      'address.state': stateController.text,
      'address.nearFamousPlace': nearFamousPlaceController.text,
      'address.name': nameController.text,
      'address.contactNumber': contactNumberController.text,
      'address.timestamp': FieldValue.serverTimestamp(),
      'uid': uid,
    });

    print('Address details added successfully');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address details added successfully'),
      ),
    );

    Navigator.push(context, MaterialPageRoute(builder: (context) =>Packages(indexNum: 0,)));
  } catch (e) {
    print('Failed to add address details: $e');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to add address details: $e'),
      ),
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Add Address'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on), // Location icon
                    const SizedBox(width: 8.0),
                    const Text('Address'),
                  ],
                ),
                TextFormField(
                  controller: houseNumberController,
                  decoration: const InputDecoration(
                    labelText: 'House no./Building Name',
                    hintText: 'Example house',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter house number or building name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: roadAreaColonyController,
                  decoration: const InputDecoration(
                    labelText: 'Road Name/ Area/Colony',
                    hintText: 'Example post office',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter road name, area or colony';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: pincodeController,
                  decoration: const InputDecoration(
                    labelText: 'Pincode',
                    hintText: 'Example pincode',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pincode';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                          labelText: 'City',
                          hintText: 'Example city',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: stateController,
                        decoration: const InputDecoration(
                          labelText: 'State',
                          hintText: 'Example district',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter state';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: nearFamousPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'Near Famous Place/Shop/School.etc.(optional)',
                    hintText: 'Example City',
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.call), // Call icon
                    const SizedBox(width: 8.0),
                    const Text('Contact Details'),
                  ],
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: (){
                             if (_formKey.currentState!.validate()) {
                        AddressDetailsadd();
                      }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 195, 60, 105),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
