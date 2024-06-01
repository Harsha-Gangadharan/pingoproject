import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'ORDERS',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: const Color.fromARGB(255, 14, 14, 14),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('cart_summary').where("uid",isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var data = documents[index].data() as Map<String, dynamic>;
                var items = data['items'] as List<dynamic>? ?? [];
                log(items.length.toString());
                return ListView.separated(
                  shrinkWrap: true,
                  physics:const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index2) {
                      var item = items[index2] as Map<String, dynamic>? ?? {};
                      var description = item['description'] as String? ?? 'No description';
                      var productImage = item['productImage'] as String? ?? 'https://via.placeholder.com/150';
                      var amount = (item['amount'] as num?)?.toDouble() ?? 0.0;
                      var qty = (item['qty'] as num?)?.toInt() ?? 0;
                      var sellerName = item['sellerName'] as String? ?? 'Unknown seller';
                      var sellerImage = item['sellerImage'] as String? ?? 'https://via.placeholder.com/150';

                      return Container(
                        // height: 20,
                        color: Colors.white,
                        child: OrderListItem(
                          description: description,
                          productImage: productImage,
                          amount: amount,
                          qty: qty,
                          sellerName: sellerName,
                          sellerImage: sellerImage,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: items.length);
              },
            );
          },
        ),
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  final String description;
  final String productImage;
  final double amount;
  final int qty;
  final String sellerName;
  final String sellerImage;

  const OrderListItem({
    Key? key,
    required this.description,
    required this.productImage,
    required this.amount,
    required this.qty,
    required this.sellerName,
    required this.sellerImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '02th February'), // Static date, you can replace with dynamic value if needed
            ],
          ),
          const SizedBox(height: 10.0),
          Text('Sold to: $sellerName'),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Text(description),
              const Spacer(),
              Text('\u20B9$amount'),
            ],
          ),
          const SizedBox(height: 5.0),
          Row(
            children: [
              Image.network(productImage,
                  width: 50, height: 50), // Using product image from network
              const Spacer(),
              Text('Qty: $qty'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(sellerImage),
              ),
              const SizedBox(width: 10),
              Text('Sold by: $sellerName'),
              const Spacer(),
              const Text('Free delivery'),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle remove button press
                },
                child: const Text('Remove'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
