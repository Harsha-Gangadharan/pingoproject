import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/User/cartpaymentmethod.dart';
import 'package:flutter_application_1/User/editaddress.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isOrderPlaced = false;
  late String currentUserId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, int> quantities = {};
  Map<String, double> itemPrices = {};
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    if (user != null) {
      currentUserId = user.uid;
    }
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    FirebaseFirestore.instance
        .collection('cart')
        .where('uid', isEqualTo: currentUserId)
        .snapshots()
        .listen((snapshot) async {
      double newTotal = 0.0;
      Map<String, int> newQuantities = {};
      Map<String, double> newItemPrices = {};

      for (var cartItem in snapshot.docs) {
        var productId = cartItem['productId'];
        var qty = cartItem['qty'];
        newQuantities[productId] = qty;

        var productSnapshot = await getProductDetails(productId);
        var productData = productSnapshot.data();
        if (productData != null) {
          newItemPrices[productId] = productData["amount"].toDouble();
          newTotal += qty * productData["amount"].toDouble();
        }
      }

      setState(() {
        quantities = newQuantities;
        itemPrices = newItemPrices;
        total = newTotal;
      });
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(String productId) {
    return FirebaseFirestore.instance.collection('productdetails').doc(productId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAddress() {
    return FirebaseFirestore.instance.collection("addressdetails").doc(currentUserId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSellerDetails(String userId) {
    return FirebaseFirestore.instance.collection("useregisteration").doc(userId).get();
  }

  Future<void> removeProduct(String productId) async {
    await FirebaseFirestore.instance.collection('cart').doc(productId).delete();
    fetchCartItems(); // Re-fetch the cart items to update the state
  }

  Future<void> updateCartQuantity(String productId, int incrementBy) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection('cart').doc(productId);
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        int currentQty = doc['qty'];
        int newQty = currentQty + incrementBy;

        await docRef.update({'qty': newQty});
        fetchCartItems(); // Re-fetch the cart items to update the state
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      isOrderPlaced
          ? const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.check, color: Colors.green),
            )
          : const CircleAvatar(child: Text('1')),
      const CircleAvatar(child: Text('2')),
      const CircleAvatar(child: Text('3')),
      const CircleAvatar(child: Text('4')),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: const Text('Cart'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: const Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 100),
              painter: CircleLinePainter(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: list,
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cart'),
              Text('Address'),
              Text('Payment'),
              Text('Summary'),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('cart')
                  .where('uid', isEqualTo: currentUserId)
                  .snapshots(),
              builder: (context, cartSnapshot) {
                if (cartSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!cartSnapshot.hasData || cartSnapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No items in the cart'));
                }

                return ListView.builder(
                  itemCount: cartSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var cartItem = cartSnapshot.data!.docs[index];
                    var productId = cartItem['productId'];
                    var qty = cartItem['qty'];

                    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getProductDetails(productId),
                      builder: (context, productSnapshot) {
                        if (productSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!productSnapshot.hasData || !productSnapshot.data!.exists) {
                          return const Center(child: Text('Product not available'));
                        }
                        final productData = productSnapshot.data!.data();
                        if (productData == null) {
                          return const Center(child: Text('Product data not available'));
                        }

                        itemPrices[productId] = productData["amount"].toDouble();

                        return buildShoppingCartItem(productData, productId, qty);
                      },
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          buildTotalSection(),
          const SizedBox(height: 10.0),
          Center(
            child: SizedBox(
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          future: getUserAddress(),
                          builder: (context, addressSnapshot) {
                            if (addressSnapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if (!addressSnapshot.hasData || !addressSnapshot.data!.exists) {
                              return const Center(child: Text('No address available'));
                            }
                            final addressData = addressSnapshot.data!.data();
                            return Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    addressData?["name"] ?? "",
                                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${addressData?["address.houseNumber"] ?? ""}, '
                                    '${addressData?["address.roadAreaColony"] ?? ""}, '
                                    '${addressData?["address.nearFamousPlace"] ?? ""}, '
                                    '${addressData?["address.city"] ?? ""}, '
                                    '${addressData?["address.state"] ?? ""}, '
                                    '${addressData?["address.pincode"] ?? ""}\n'
                                    '${addressData?["address.contactNumber"] ?? ""}\n'
                                    '${addressData?["address.name"] ?? ""}',
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const EditAddressPage()),
                                          );
                                        },
                                        child: const Text('Edit'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => CartPayment(totalPay: total)),
                                          );
                                        },
                                        child: const Text('Deliver to this address'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isOrderPlaced = true;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ).then((value) {
                      if (value != null) {
                        setState(() {
                          isOrderPlaced = value;
                        });
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 195, 60, 105),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.inknutAntiqua(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
        bottomNavigationBar: MyNav(index:0, onTap: (index){
  setState(() {
Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Packages(indexNum: index)))   ;       });
       }, firestore:  FirebaseFirestore.instance, auth: FirebaseAuth.instance),
    );
  }

  Widget buildShoppingCartItem(Map<String, dynamic>? productData, String productId, int qty) {
    if (productData == null || productData.isEmpty) {
      return const SizedBox.shrink(); // Return an empty SizedBox if product data is null
    }
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(productData["productimage"]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productData["description"] ?? "",
                    style: const TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '\u20B9 ${productData["amount"]}',
                style: const TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
            child: Row(
              children: [
                const Text(
                  'Size: Free size',
                  style: TextStyle(fontSize: 16.0),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () async {
                    if (qty > 0) {
                      await updateCartQuantity(productId, (-1));
                      setState(() {
                        qty--;
                        quantities[productId] = qty; // Update the quantities map
                      });
                    }
                  },
                ),
                Text('Qty: $qty'),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () async {
                    await updateCartQuantity(productId, 1);
                    setState(() {
                      qty++;
                      quantities[productId] = qty; // Update the quantities map
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await removeProduct(productId);
                  },
                ),
              ],
            ),
          ),
          FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: getSellerDetails(productData["uid"]),
            builder: (context, sellerSnapshot) {
              if (sellerSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                return const Center(child: Text('No seller details available'));
              }
              final sellerData = sellerSnapshot.data!.data();
              return Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(sellerData?["image"] ?? ""),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Sold by: ${sellerData?["username"] ?? ""}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildTotalSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Total Price: \u20B9$total',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CircleLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    double circleRadius = 20;
    double startX = circleRadius;
    double startY = size.height / 2;

    double circleSpacing = (size.width - circleRadius * 2 * 4) / 3;
    double lineY = size.height / 2;

    for (int i = 0; i < 3; i++) {
      double currentX = startX + (circleRadius * 2 + circleSpacing) * i;
      double nextX = currentX + circleRadius * 2 + circleSpacing;

      canvas.drawCircle(Offset(currentX, startY), circleRadius, paint);
      if (i < 3 - 1) {
        canvas.drawLine(
          Offset(currentX + circleRadius, lineY),
          Offset(nextX - circleRadius, lineY),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(currentX + circleRadius, lineY),
          Offset(nextX - circleRadius, lineY),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
