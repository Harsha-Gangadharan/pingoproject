import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/User/newpost.dart';
import 'package:flutter_application_1/User/package.dart';

class BankDetailsPage extends StatefulWidget {
  @override
  _BankDetailsPageState createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();
  final gpayPhoneController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  int maxLength = 10;

  Future<void> bankDetailsadd() async {
    try {
      final gpay = gpayPhoneController.text;

      String uid = _auth.currentUser!.uid;
      await FirebaseFirestore.instance.collection('bankdetails').doc(uid).set({
        'name': nameController.text,
        'accountNumber': accountNumberController.text,
        'ifccode': ifscCodeController.text,
        'gpayphonenumber': gpay,
        'uid': uid,
       
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bank details added successfully'),
        ),
      );
      
      Navigator.push(context, MaterialPageRoute(builder: (context) => Packages(indexNum: 0,),));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add bank details: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.account_balance),
            SizedBox(width: 10),
            Text('Add Bank Details'),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: accountNumberController,
                  decoration: InputDecoration(
                    labelText: 'Account Number',
                    suffixIcon: Icon(Icons.remove_red_eye),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Account Number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: ifscCodeController,
                  decoration: InputDecoration(
                    labelText: 'IFSC Code',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter IFSC code';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  controller: gpayPhoneController,
                  inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
                  decoration: InputDecoration(
                    labelText: 'Gpay Phone Number',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Gpay Phone Number';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 195, 60, 105),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        bankDetailsadd();
                      }
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
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
