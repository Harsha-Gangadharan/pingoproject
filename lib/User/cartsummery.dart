import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/orderconfirmed.dart';
import 'package:google_fonts/google_fonts.dart';

class CartSummery extends StatefulWidget {
  const CartSummery({Key? key}) : super(key: key);

  @override
  State<CartSummery> createState() => _CartSummeryState();
}

class _CartSummeryState extends State<CartSummery> {
  List<DocumentSnapshot> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await firestore.collection('cart').get();
    setState(() {
      cartItems = snapshot.docs;
    });
  }

  Future<Map<String, dynamic>?> getSellerDetails(String uid) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot sellerSnapshot = await firestore.collection('useregisteration').doc(uid).get();
    return sellerSnapshot.data() as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.green),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.green),
      ),
      CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.check, color: Colors.green),
      ),
      CircleAvatar(child: Text('4')),
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
            SizedBox(height: 20),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 100),
              painter: CircleLinePainter(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: list,
              ),
            ),
            Row(
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
              return FutureBuilder<Map<String, dynamic>?>(
                future: getSellerDetails(data['uid']),
                builder: (context, snapshot) {
                  var sellerData = snapshot.data;
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
                                  data['description'] ?? '',
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                                SizedBox(height: 10), // Add a small space
                                Container(
                                  width: 50, // Adjust the width as needed
                                  height: 50, // Adjust the height as needed
                                  color: Colors.grey[400], // Color of the container
                                  child: Image.network(
                                    data['productimage'] ?? "https://via.placeholder.com/150",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Text('₹${data['amount'] ?? 0}'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
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
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (data['qty'] > 0) data['qty'] -= 1;
                                    });
                                  },
                                  icon: const Icon(Icons.remove_circle),
                                ),
                                Text('${data['qty'] ?? 0}'),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      data['qty'] += 1;
                                    });
                                  },
                                  icon: const Icon(Icons.add_circle),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: NetworkImage(sellerData?["image"] ?? "https://via.placeholder.com/150"),
                            ),
                            SizedBox(width: 10),
                            const Text('Sold by:'),
                            Text(sellerData?['name'] ?? 'Loading...'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
                        child: Row(
                          children: const [
                            Text('free delivery'),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              );
            }).toList(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
              child: Text(
                'Deliver this location\nExample house, local area, post office.\near city, district, state, pincode\nphone number',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            const Divider(),

            // Price details section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Price Details (5 item)'),
                  Text('₹5,200'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Product Price'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('view price details'),
                  ),
                ],
              ),
            ),

            // Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderConfirm())
                  );
                },
                child: const Text('Place Order'),
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
