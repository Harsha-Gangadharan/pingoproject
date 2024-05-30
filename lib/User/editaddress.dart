import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/cartpage.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({Key? key}) : super(key: key);

  @override
  _EditAddressPageState createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final houseNumberController = TextEditingController();
  final roadAreaColonyController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final nearFamousPlaceController = TextEditingController();
  final nameController = TextEditingController();
  final contactNumberController = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getSelectedUserProfile() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return firestore.collection("addressdetails").doc(uid).get();
  }
  void _updateAddressDetails() async {
  if (_formKey.currentState!.validate()) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("addressdetails").doc(uid).update({
      'houseNumber': houseNumberController.text,
      'roadAreaColony': roadAreaColonyController.text,
      'pincode': pincodeController.text,
      'city': cityController.text,
      'state': stateController.text,
      'nearFamousPlace': nearFamousPlaceController.text,
      'name': nameController.text,
      'contactNumber': contactNumberController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Address details updated successfully'),
      ),
    );
    //   Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => CartPage()),
    // );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Edit Address'),
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
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: getSelectedUserProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('No address available'));
                }
                Map<String, dynamic> data = snapshot.data!.data()!;
                houseNumberController.text = data['houseNumber'] ?? '';
                roadAreaColonyController.text = data['roadAreaColony'] ?? '';
                pincodeController.text = data['pincode'] ?? '';
                cityController.text = data['city'] ?? '';
                stateController.text = data['state'] ?? '';
                nearFamousPlaceController.text = data['nearFamousPlace'] ?? '';
                nameController.text = data['name'] ?? '';
                contactNumberController.text = data['contactNumber'] ?? '';

                return Column(
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
  onPressed: _updateAddressDetails,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
