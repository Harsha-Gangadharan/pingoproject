import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

import 'package:flutter_application_1/User/notification.dart';

class Yourpage extends StatefulWidget {
  final Map<String, dynamic> product;

  Yourpage({required this.product});

  @override
  State<Yourpage> createState() => _YourpageState();
}

class _YourpageState extends State<Yourpage> {
  final status = ['Processing', 'Pending', 'Completed'];
  String? selectedStatus;

  Stream<QuerySnapshot<Map<String, dynamic>>> getProductid() {
    return FirebaseFirestore.instance
        .collection('cart_summary')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchCartSummerye() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('cart_summary')
        .where('uid',isEqualTo: auth.currentUser!.uid)
        .get();

    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your Order Details'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(future: fetchCartSummerye(), builder: (context, snapshot) {
                  return Text(
                    '');
                },),
                SizedBox(height: 10),
                Text('Seller Name: ${widget.product['sellerName']}'),
                Image.network(widget.product['productImage']),
                Text(
                    'City: ${widget.product['buyerAddress']['address']['city']}'),
                Text(
                    'Near Famous Place: ${widget.product['buyerAddress']['address']['nearFamousPlace']}'),
                Text(
                    'PINCODE: ${widget.product['buyerAddress']['address']['pincode']}'),
                Text('Payment Mode: ${widget.product['paymentMode']}'),
                Text('Delivery Date: within one month'),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Select Status',
                  ),
                  value: selectedStatus,
                  items: status.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value as String?;
                    });
                  },
                ),
                SizedBox(height: 20),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: getProductid(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No data found');
                    }

                    final docs = snapshot.data!.docs;
                    return ElevatedButton(
                      onPressed: () {
                        
                        for (var doc in docs) {
                          log('Document ID: ${doc.id}');
                          // FirebaseFirestore.instance.collection("cart_summary").doc().update(data);
                           
                        }
 
                      },
                      child: Text('Update Status'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateOrderStatus(String orderId, String? status) {
    // Implement your logic to update order status in Firestore
    // For example:
    FirebaseFirestore.instance.collection('cart_summary').doc(orderId).update({
      'Status': status,
    }).then((value) {
      log('Order status updated successfully');
      // Optionally, you can navigate back or show a success message
    }).catchError((error) {
      log('Failed to update order status: $error');
      // Handle errors here
    });
  }
}
