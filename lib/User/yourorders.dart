import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer';

import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:flutter_application_1/model/ordersmodel.dart';

class YourOrderDetails extends StatefulWidget {
  final Map<String, dynamic> product;
  String id;

  YourOrderDetails({required this.product,required this.id});

  @override
  State<YourOrderDetails> createState() => _YourOrderDetailsState();
}

class _YourOrderDetailsState extends State<YourOrderDetails> {
  final status = ['Processing', 'Pending', 'Completed'];
  String? selectedStatus;

  Stream  getProductid() {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchCartSummerye() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('cart_summary')
        .where('uid', isEqualTo: auth.currentUser!.uid)
        .get();

    return snapshot.docs;
  }

  List<OrderModel> list = [];
  Future getOrder() async {
    final snapshot = await db.collection('orders').get();

    list = snapshot.docs.map((e) {
      return OrderModel.fromjsone(e.data());
    }).toList();
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
                FutureBuilder(
                  future: fetchCartSummerye(),
                  builder: (context, snapshot) {
                    return Text('');
                  },
                ),
                SizedBox(height: 10),
                Text('Seller Name: ${widget.product['sellerName']}'),
                Image.network(widget.product['productImage']),
                Text(
                    ' userName:: ${widget.product['buyerAddress']['address']['name']}'),
                Text(
                    'City: ${widget.product['buyerAddress']['address']['city']}'),
                Text(
                    'Near Famous Place: ${widget.product['buyerAddress']['address']['nearFamousPlace']}'),
                Text(
                    'PINCODE: ${widget.product['buyerAddress']['address']['pincode']}'),
                     Text(
                    ' contactNumber: ${widget.product['buyerAddress']['address']['contactNumber']}'),
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
StreamBuilder(
  stream: getProductid(),
  builder: (context, snapshot) {
    return ElevatedButton(
      onPressed: () {
        // Update the status in Firestore
        db.collection('cart_summary').doc(widget.id).update({
          'Status': selectedStatus.toString(),
        }).then((_) {
          // Navigate to the desired screen after the update

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>Packages(
                                        indexNum: 4,
                                      )),
                              (route) => false);
        }).catchError((error) {
          // Handle any errors here if needed
          print("Failed to update status: $error");
        });
      },
      child: Text('Update Status'),
    );
  },
),

                SizedBox(height: 50,)
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
