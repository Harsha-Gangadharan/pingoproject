import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/order.dart';
import 'package:flutter_application_1/User/orderconfirmed.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:flutter_application_1/crud/notification_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class CartSummary extends StatefulWidget {
  const CartSummary({Key? key, required int selectedOption}) : super(key: key);

  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  List<DocumentSnapshot> cartItems = [];
  late String currentUserId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, int> quantities = {};
  Map<String, double> itemPrices = {};
  double total = 0.0;

  int selectedOption = -1;

  @override
  void initState() {
    super.initState();
    User? user = _auth.currentUser;
    if (user != null) {
      currentUserId = user.uid;
      fetchCartItems();
    }
  }

  Future<void> fetchCartItems() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore
        .collection('cart')
        .where('uid', isEqualTo: currentUserId)
        .get();
    setState(() {
      cartItems = snapshot.docs;
      cartItems.forEach((cartItem) {
        var data = cartItem.data() as Map<String, dynamic>;
        quantities[cartItem.id] = data['qty'];
      });
    });
    calculateTotalAm();
  }

  Future<void> calculateTotalAm() async {
    double totPrice = 0.0;
    for (var cartItem in cartItems) {
      var data = cartItem.data() as Map<String, dynamic>;
      var productId = data['productId'];
      DocumentSnapshot productSnapshot = await getProductDetails(productId);
      if (productSnapshot.exists) {
        var productData = productSnapshot.data() as Map<String, dynamic>;
        double itemPrice = productData['amount'].toDouble();
        itemPrices[productId] = itemPrice;
        totPrice += quantities[cartItem.id]! * itemPrice;
      }
    }
    setState(() {
      total = totPrice;
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(
      String productId) {
    return FirebaseFirestore.instance
        .collection('productdetails')
        .doc(productId)
        .get();
  }

  Future<Map<String, dynamic>?> getSellerDetails(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot sellerSnapshot =
        await firestore.collection('useregisteration').doc(uid).get();
    return sellerSnapshot.data() as Map<String, dynamic>?;
  }

  Future<void> updateCartQuantity(String productId, int incrementBy) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('cart').doc(productId);
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        int currentQty = doc['qty'];
        int newQty = currentQty + incrementBy;

        await docRef.update({'qty': newQty});
        setState(() {
          quantities[productId] = newQty;
        });
        calculateTotalAm();
      }
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  String sellerUIDDDD = "";

  Future<String> saveCartSummary() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

    List<Map<String, dynamic>> items = [];
    for (var item in cartItems) {
    var data = item.data() as Map<String, dynamic>;
    var productId = data['productId'];
    var qty = quantities[item.id]!;
    var amount = itemPrices[productId]!;

    // Fetch product details
    DocumentSnapshot productSnapshot = await getProductDetails(productId);
    if (productSnapshot.exists) {
      var productData = productSnapshot.data() as Map<String, dynamic>;
      String productImage = productData['productimage'];

      // Fetch seller details
      var sellerData = await getSellerDetails(productData['uid']);
      String sellerImage = sellerData?['image'] ?? '';
      String sellerName = sellerData?['name'] ?? '';
      String sellerUid = productData['uid'] ?? '';

      // Add buyer address
      final addressSnapshot = await getUserAddress();
      if (addressSnapshot.exists && addressSnapshot.data != null) {
        final addressData = addressSnapshot.data() as Map<String, dynamic>;
        items.add({
          'productId': productId,
          'qty': qty,
          'amount': amount,
          'productImage': productImage,
          'sellerImage': sellerImage,
          'sellerName': sellerName,
          'sellerUid': sellerUid,
          'buyerAddress': {
            'name': addressData?["address.name"] ?? "",
            'address': {
              'houseNumber': addressData?["address.houseNumber"] ?? "",
              'roadAreaColony': addressData?["address.roadAreaColony"] ?? "",
              'nearFamousPlace': addressData?["address.nearFamousPlace"] ?? "",
              'city': addressData?["address.city"] ?? "",
              'state': addressData?["address.state"] ?? "",
              'pincode': addressData?["address.pincode"] ?? "",
            },
            'contactNumber': addressData?["address.contactNumber"] ?? "",
          },
          'paymentMode': selectedOption == 0 ? "Cash on Delivery" : "Wallet/UPI",
        });
      }
    }
  }

  // Save cart summary
  DocumentReference docRef = firestore.collection('cart_summary').doc();
  String docId = docRef.id; // Get the generated document ID
  await docRef.set({
    'uid': currentUserId,
    'items': items,
    'total': total,
    'orderPlacedDate': FieldValue.serverTimestamp(),
    'deliveryDate': 'within one month',
    'Status': 'processing',
    'id': docId, // Store the document ID in the document
    'paymentMode': selectedOption == 0 ? "Wallet/UPI" : "Cash on Delivery",
  });

  // Return the document ID to be used elsewhere if needed
  return docId;
}


  String getCurrentDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(now);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserAddress() {
    return FirebaseFirestore.instance
        .collection("addressdetails")
        .doc(currentUserId)
        .get();
  }

  Future<void> _removefromcart(String productId) async {
    await FirebaseFirestore.instance.collection('cart').doc(productId).delete();
    // Re-fetch the cart items to update the state
  }

  Future removeFromCartList(List<DocumentSnapshot<Object?>> cartItems) async {
    for (var i in cartItems) {
      await _removefromcart(i["productId"]);
    }
    fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.green),
      ),
      const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.green),
      ),
      const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.green),
      ),
      const CircleAvatar(child: Text('4')),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Summary',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: const Color.fromARGB(255, 14, 14, 14),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 100),
              painter: CircleLinePainter(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: list,
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
            // Product details section
            ...cartItems.map((item) {
              var data = item.data() as Map<String, dynamic>;
              var productId = data['productId'];
              var qty = data['qty'];
              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: getProductDetails(productId),
                builder: (context, productSnapshot) {
                  if (productSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!productSnapshot.hasData ||
                      !productSnapshot.data!.exists) {
                    return const Center(child: Text('Product not available'));
                  }
                  final productData = productSnapshot.data!.data();
                  if (productData == null) {
                    return const Center(
                        child: Text('Product data not available'));
                  }
                  itemPrices[productId] = productData["amount"].toDouble();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productData['description'] ?? '',
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  width: 50,
                                  height: 50,
                                  color: Colors.grey[400],
                                  child: Image.network(
                                    productData['productimage'] ??
                                        "https://via.placeholder.com/150",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Text('₹${productData['amount'] ?? 0}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                        child: Row(
                          children: [
                            const Text('Size:'),
                            Text(
                              'Free size',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    if (qty > 0) {
                                      await updateCartQuantity(productId, -1);
                                      setState(() {
                                        if (qty > 0) qty--;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                ),
                                Text('Qty: $qty'),
                                IconButton(
                                  onPressed: () async {
                                    await updateCartQuantity(productId, 1);
                                    setState(() {
                                      qty++;
                                    });
                                  },
                                  icon: const Icon(Icons.add_circle),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FutureBuilder<Map<String, dynamic>?>(
                          future: getSellerDetails(productData['uid']),
                          builder: (context, sellerSnapshot) {
                            if (sellerSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            var sellerData = sellerSnapshot.data;
                            if (sellerData == null) {
                              return const Text('Loading...');
                            }
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                      sellerData["image"] ??
                                          "https://via.placeholder.com/150"),
                                ),
                                const SizedBox(width: 10),
                                const Text('Sold by:'),
                                Text(sellerData['name'] ?? 'Loading...'),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text('Order Place Date '),
                                Text('\n${getCurrentDate()}'),
                              ],
                            ),
                            const Divider(), // Add a divider here
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }).toList(),

            // Total amount section
            Container(
              color: Colors.pink[100],
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('₹${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // Proceed button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      removeFromCartList(cartItems).then((value) async {
                        saveCartSummary().then((value) {
                          //-----------------------------------Notification
                          sendNotiifcation(
                            NotificationModel(
                              fromId: FirebaseAuth.instance.currentUser!.uid,
                              message: "Your Product is order by ${FirebaseAuth.instance.currentUser!.uid}",
                              toID: sellerUIDDDD,
                              type: "User",
                            ),
                          );
                          //-----------------------------------Notification

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => Packages(
                                        indexNum: 3,
                                      )),
                              (route) => false);
                        });
                      });

                      // .then((value) {

                      // //  removefromcart(productId);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>  OrderPage()),
                      // );
                      // });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 180, 203, 222)),
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ],
        ),
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
