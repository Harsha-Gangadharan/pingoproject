import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/yourorders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SellerOrderPage extends StatelessWidget {
  final String uid;

  SellerOrderPage({required this.uid});

  Future<List<Map<String, dynamic>>> fetchSellerOrders() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('cart_summary')
        .where('items', arrayContainsAny: [
      {'sellerId': uid}
    ]).get();

    List<Map<String, dynamic>> orders = [];
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data();
      data['id'] = doc.id; // Adding the document ID for reference
      orders.add(data);
    }
    return orders;
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchCartSummery() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('cart_summary').get();

    return snapshot.docs;
  }

  Future<List<dynamic>> getAllItems() async {
    List<dynamic> fullItems = [];
    List<dynamic> sortedList = [];

    await fetchCartSummery().then((list) {
      for (var i in list) {
        if (i["items"] != null || i["items"].isNotEmpty) {
          for (var j in i["items"]) {
            fullItems.add(j);
            sortedList = fullItems
                .where((element) =>
                    element["sellerUid"] ==
                    FirebaseAuth.instance.currentUser!.uid)
                .toList();
          }
        }
      }
    },
    );

    log(sortedList.length.toString());

    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Seller Orders',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: const Color.fromARGB(255, 14, 14, 14),
          ),
        ),
      ),
      body: FutureBuilder(
        future: getAllItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data;
          return data!.isEmpty
              ? Center(
                  child: Text("No Orders"),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          // Navigate to the product details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YourOrderDetails(
                                product: data[index],
                              ),
                            ),
                          );
                         
                        },
                        child: Image.network(data[index]['productImage']),
                      ),
                      // title: Text(data[index]['description']),
                      subtitle: Text(
                          'Qty: ${data[index]['qty']} - ₹${data[index]['amount']}             '),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: data.length);
        },
      ),
    );
  }
}
