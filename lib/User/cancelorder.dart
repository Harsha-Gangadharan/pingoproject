import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({super.key});

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Image.asset("asset/cancel.png")),
              Center(
                child: Text(
                  'Order Cancelled ',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 202, 13, 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
