import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/addaddress.dart';
import 'package:flutter_application_1/User/paymentmethod.dart';
import 'package:google_fonts/google_fonts.dart';

class Buynow extends StatefulWidget {
  @override
  _BuynowState createState() => _BuynowState();
}

class _BuynowState extends State<Buynow> {
  int quantity = 1;
  double itemPrice = 700.0;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  double calculateTotalPrice() {
    return quantity * itemPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Buy your Product'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order details section
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                children: [
                  // Product image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                            'asset/product_image.png'), // Path to your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between image and text
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Art Name',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(width: 16), // Spacer
                  Text(
                    '₹ ${itemPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
              child: Row(
                children: [
                  Text(
                    'Size: Free size',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: decrementQuantity,
                  ),
                  Text('Qty: $quantity'),
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    onPressed: incrementQuantity,
                  ),
                ],
              ),
            ),
            // Sold by section
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(
                        'asset/profile.png'), // Path to your seller avatar
                  ),
                  SizedBox(width: 8), // Add space between avatar and text
                  Text(
                    'Sold by: example',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Spacer(),
                  Text(
                    'free delivery',
                    style: TextStyle(fontSize: 12.0, color: Colors.green),
                  ),
                ],
              ),
            ),
            // Delivery details section
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(), // Add a line
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on), // Location icon
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        'Deliver this location',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: Text(
                    'Example house, local area, post office,\near city, district, state, pincode\nphone number',
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
Center(
  child: SizedBox(
    height: 50.0,
    width: 120,
    child: ElevatedButton(
      onPressed: () { Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>AddAddressPage ()),
                    );
        
      },
      style: ElevatedButton.styleFrom(
      
      ),
      child: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit, color: Colors.pink, size: 16.0),
            SizedBox(width: 8), // Add some space between icon and text
            Center(
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

            // Price details section
            Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price Details ($quantity items)',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    '₹ ${calculateTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
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
            // Button
           const SizedBox(height: 20.0,),
               Center(
                 child: SizedBox(height: 50.0,
                   child: ElevatedButton(
                    onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>PaymentPage()),
                    );},
                    style: TextButton.styleFrom(backgroundColor:const Color.fromARGB(255, 195, 60, 105) ),
                    child: const Text('Continue',
                   style:TextStyle(color: Colors.white) ,)
                   ),
                 ),
               ),
          ],
        ),
      ),
    );
  }
}
