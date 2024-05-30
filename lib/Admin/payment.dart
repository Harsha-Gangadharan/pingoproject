import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/orderconfirmed.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpoPayment extends StatefulWidget {
  @override
  _ExpoPaymentState createState() => _ExpoPaymentState();
}

class _ExpoPaymentState extends State<ExpoPayment> {
  int _paymentMethod = 0; // 0 for pay online, 1 for cash on delivery
int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 94, 133),
        title: Text(
          "Pingo",
          style: GoogleFonts.aclonica(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
         actions: [
          Row(
            children: [
              SizedBox(width: 20.0),
              Icon(
                Icons.logout,
                color: Colors.black,
              ),
              SizedBox(width: 20.0),
              Icon(
                Icons.palette,
                color: Colors.black,
              ),
              SizedBox(width: 20.0),
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Row(
                        children: [Icon(Icons.home), Text('Home')],
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: [Icon(Icons.people), Text('View Users')],
                      ),
                      value: 2,
                    ),
                  ];
                },
              ),
            ],
          ),
        ],
    
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
                    child: const Text('Proceed',
                   style:TextStyle(color: Colors.white) ,)
                   ),
                 ),
               ),
        ],
      ),
     
    );
  }
}
