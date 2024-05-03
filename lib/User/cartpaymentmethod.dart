import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPayment extends StatefulWidget {
  @override
  _CartPaymentState createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  int _paymentMethod = 0;
  
  // 0 for pay online, 1 for cash on delivery

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
    CircleAvatar(child: Text('3')),
    CircleAvatar(child: Text('4')),
  ];

  // ... (rest of your code remains unchanged)



    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(183, 225, 56, 132),
        title: Text('Payment Method'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      
      body: Column(
        children: [
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
          SizedBox(height: 80,),
          ListTile(
            title: Text('Pay Online'),
            leading: Radio(
              value: 1,
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'asset/gpay.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'asset/phonepay.png',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'asset/paytm.png',
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          ListTile(
            trailing: Icon(Icons.location_on),
            title: Text('Cash on Delivery'),
            leading: Radio(
              value: 2,
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
          ),
          Divider(),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 195, 60, 105),
                ),
                child: Text(
                  'Place order',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
