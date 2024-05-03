import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartSummery extends StatefulWidget {
  const CartSummery({Key? key}) : super(key: key);

  @override
  State<CartSummery> createState() => _CartSummeryState();
}

class _CartSummeryState extends State<CartSummery> {
  int quantity = 0;

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
          children:  [
          SizedBox(height: 20,),
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Art Name',
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 10), // Add a small space
                      Container(
                        width: 50, // Adjust the width as needed
                        height: 50, // Adjust the height as needed
                        color: Colors.grey[400], // Color of the container
                      ),
                    ],
                  ),
                  const Text('₹700'),
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
                        onPressed: () => setState(() => quantity -= 1),
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Text('$quantity'),
                      IconButton(
                        onPressed: () => setState(() => quantity += 1),
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

            // Seller details section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(),
                  SizedBox(width: 10,),
                  const Text('Sold by:'),
                  Text('example'),
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
                onPressed: () {},
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
