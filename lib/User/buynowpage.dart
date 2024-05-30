import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/addaddress.dart';
import 'package:flutter_application_1/User/paymentmethod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuynowPage extends StatefulWidget {
  final String productId; // Add a parameter for the product ID
  final String userProfileImage;
  final String userName;
  
  BuynowPage({required this.productId, required this.userProfileImage, required this.userName});

  @override
  _BuynowPageState createState() => _BuynowPageState();
}

class _BuynowPageState extends State<BuynowPage> {
  int quantity = 1;
  double itemPrice = 700.0;
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
  }

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  double calculateTotalPrice() {
    return quantity * itemPrice;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails() {
    return FirebaseFirestore.instance.collection("productdetails").doc(widget.productId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAddress() {
    return FirebaseFirestore.instance.collection("addressdetails").doc(currentUserId).get();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> getSellerDetails(String userId) {
  return FirebaseFirestore.instance.collection("useregisteration").doc(userId).get();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Buy your Product'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getProductDetails(),
        builder: (context, productSnapshot) {
          if (productSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!productSnapshot.hasData || !productSnapshot.data!.exists) {
            return Center(
              child: Text('No product available'),
            );
          }
          final productData = productSnapshot.data!.data();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(productData?["productimage"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productData?["description"] ?? "",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        '₹ ${itemPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: Row(
                    children: [
                      Text(
                        'Size: Free size',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: decrementQuantity,
                      ),
                      Text('Qty: $quantity'),
                      IconButton(
                        icon: Icon(Icons.add_circle),
                        onPressed: incrementQuantity,
                      ),
                    ],
                  ),
                ),
FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
  future: getSellerDetails(productData?["uid"]),
  builder: (context, sellerSnapshot) {
    if (sellerSnapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
      return Center(
        child: Text('No seller details available'),
      );
    }
    final sellerData = sellerSnapshot.data!.data();
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(sellerData?["image"] ?? ""),
        ),
        SizedBox(width: 8),
        Text(
          'Sold by: ${sellerData?["username"] ?? ""}',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  },
),

                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: getUserAddress(),
                  builder: (context, addressSnapshot) {
                    if (addressSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!addressSnapshot.hasData || !addressSnapshot.data!.exists) {
                      return Center(
                        child: Text('No address available'),
                      );
                    }
                    final addressData = addressSnapshot.data!.data();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                          child: Row(
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(width: 8),
                              Text(
                                'Deliver to this location',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                          child: Text(
                            '${addressData?["address.houseNumber"] ?? ""}, ${addressData?["address.roadAreaColony"] ?? ""},${addressData?["address.nearFamousPlace"] ?? ""}, ${addressData?["address.city"] ?? ""}, ${addressData?["address.state"] ?? ""}, ${addressData?["address.pincode"] ?? ""}\n${addressData?["address.contactNumber"] ?? ""}\n${addressData?["address.name"] ?? ""}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddAddressPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit, color: Colors.pink, size: 16.0),
                          SizedBox(width: 8),
                          Center(
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween
,
                    children: [
                      Text(
                        'Price Details ($quantity items)',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        '₹ ${calculateTotalPrice().toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Product Price',
                        style: TextStyle(fontSize: 12.0),
                      ),
                      TextButton(
                        onPressed: () => {},
                        child: Text(
                          'view price details',
                          style: TextStyle(fontSize: 12.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentPage()),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 195, 60, 105),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
