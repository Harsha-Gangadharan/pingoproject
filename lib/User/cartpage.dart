import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isOrderPlaced = false;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      isOrderPlaced
          ? CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.check, color: Colors.green),
            )
          : CircleAvatar(child: Text('1')),
      CircleAvatar(child: Text('2')),
      CircleAvatar(child: Text('3')),
      CircleAvatar(child: Text('4')),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Cart'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.symmetric(vertical: 16.0),
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
            child: ListView(
              children: [
                buildShoppingCartItem(
                    'Art Name', 700, 'Free size', 'example', Colors.red),
                buildShoppingCartItem(
                    'Art Name', 1000, 'Free size', 'example', Colors.green),
                buildShoppingCartItem(
                    'Art Name', 1500, 'Free size', 'example', Colors.blue),
              ],
            ),
          ),
          SizedBox(height: 10),
          buildTotalSection(),
          const SizedBox(
            height: 10.0,
          ),
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
                        return Container(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                  'Example house, local area, post office, near city, district, state, pincode, phone number'),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Edit'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: Text('Deliver to this address'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink),
                                    child: const Text('Cancel',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                      backgroundColor: const Color.fromARGB(255, 195, 60, 105)),
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
    );
  }

  Widget buildShoppingCartItem(
      String name, int price, String size, String seller, Color color) {
    int quantity = 1;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 40),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text('₹$price'),
                  Text('Size: $size'),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (quantity > 1) {
                        quantity--;
                      }
                    },
                  ),
                  Text('Qty$quantity'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      quantity++;
                    },
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            CircleAvatar(
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sold by: Seller Name'),
                Text('Free delivery'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildTotalSection() {
    int totalPrice = 0;

    totalPrice += 700 + 1000 + 1500;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Total Price: ₹ $totalPrice',
          style: GoogleFonts.abhayaLibre(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
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
