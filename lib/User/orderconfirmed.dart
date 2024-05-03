import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderConfirm extends StatefulWidget {
  const OrderConfirm({super.key});

  @override
  State<OrderConfirm> createState() => _OrderConfirmState();
}

class _OrderConfirmState extends State<OrderConfirm> {
  int _selectedIndex = 0;
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
              Center(child: Image.asset("asset/tick.png")),
              Center(
                child: Text(
                  'Order Confirmed ',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 10, 147, 53),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search, color: Color.fromARGB(255, 12, 12, 12)),
          ),
          BottomNavigationBarItem(
            label: "Upload",
            icon: Icon(Icons.add_box, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.card_giftcard,
                color: Color.fromARGB(255, 12, 12, 12)),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle,
                color: Color.fromARGB(255, 12, 12, 12)),
          ),
        ]
       ),
    );
  }
}
