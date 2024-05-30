import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/cartsummery.dart';
import 'package:flutter_application_1/User/paymentmethod.dart';
import 'package:flutter_application_1/User/paymentpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upi_india/upi_india.dart';

class CartPayment extends StatefulWidget {
  double totalPay;
  CartPayment({  required this.totalPay});
  @override
  _CartPaymentState createState() => _CartPaymentState();
}

class _CartPaymentState extends State<CartPayment> {
  int _paymentMethod = 0;
    int selectedOption = 0; 

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

          
          Divider(),
          SizedBox(height: 20,),
          PaymentOption(
                      title: "Wallet/UPI",
                      selected: selectedOption == 0,
                      onTap: () {
log(widget.totalPay.toString());
                        showModalBottomSheet(
                          showDragHandle: true,
                          context: context, builder: (context) =>ShowPaymentoptions(totalAMount: widget.totalPay,),);
                      //   setState(() {
                      //     selectedOption = 0;
                      //   });
                      //   paymentController.initiateTransaction(
                      //     price: widget.totalPay,
                      //     receiverName: "logitrack",
                      //   );
                      },
                    ),
          // FutureBuilder<UpiApp>(
          //       future: paymentController.appOpen(),
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const Center(child: CircularProgressIndicator());
          //         } else if (snapshot.hasError) {
          //           return Center(child: Text('Error: ${snapshot.error}'));
          //         } else if (!snapshot.hasData) {
          //           return const Center(child: Text('No UPI app found'));
          //         } else {
          //           return 
                    
          //         }
          //       },
          //     ),
              const SizedBox(height: 25),
              PaymentOption(
                title: "Cash on delivery",
                selected: selectedOption == 2,
                onTap: () {
                  setState(() {
                    selectedOption=2;
                  });
                },
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
                      // PaymentController().create(widget.totalPay);
                  // Navigator.push(
                  //             context,
                  //             MaterialPageRoute(builder: (context) => CartSummery()),
                  //           );
                            },
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


class PaymentOption extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const PaymentOption({
    Key? key,
    required this.title,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? Colors.pink : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: selected ? Colors.transparent : Colors.grey),
        ),
        child: TextButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.inder(color: selected ? Colors.white : Colors.black),
              ),
              Icon(
                selected ? Icons.check_circle : Icons.circle_outlined,
                color: selected ? Colors.white : Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
