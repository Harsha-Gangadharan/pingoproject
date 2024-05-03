import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/orderconfirmed.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _paymentMethod = 0; // 0 for pay online, 1 for cash on delivery
int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text('Pay Online'),
            leading: Radio(
              value: 0,
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
                  'asset/gpay.png', // Replace with your Google Pay icon image path
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'asset/phonepay.png', // Replace with your PhonePe icon image path
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'asset/paytm.png', // Replace with your Paytm icon image path
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
              value: 1,
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
           // Location icon
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
            // Button
           const SizedBox(height: 20.0,),
               Center(
                 child: SizedBox(height: 50.0,
                   child: ElevatedButton(
                    onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>OrderConfirm()),
                    );},
                    style: TextButton.styleFrom(backgroundColor:const Color.fromARGB(255, 195, 60, 105) ),
                    child: const Text('Place order',
                   style:TextStyle(color: Colors.white) ,)
                   ),
                 ),
               ),
        ],
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
