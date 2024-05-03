import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OrderDetailsPage extends StatefulWidget {
  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('ORDER DETAILS'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
        ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sub Order ID: 778989sh'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('Paycoons Mode: '),
                Text('Cash on delivery/Online Payment'),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Text('Order Date: '),
                Text('12th February'),
              ],
            ),
            SizedBox(height: 20.0),

            // Sold to info
            Text('Sold to:'),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('username'),
                Text('Free delivery'),
              ],
            ),
            SizedBox(height: 20.0),

            // Product details
            Text('Product Details'),
            SizedBox(height: 10.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(10.0),
              ),
             child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 80.0,  // Specify desired width
        height: 80.0, // Specify desired height
        child: Image.asset(
          "asset/product_image.png",
          fit: BoxFit.cover, // Make the image cover its container
        ),
      ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Art Name'),
                        SizedBox(height: 5.0),
                        Text('\$200'),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Size:'),
                            Text('nee str'),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text('Qty:'),
                            Text('1'),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle remove button press
                              },
                              child: Text('Remove'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),

            // Order Tracking
            Text('Order Tracking'),
            SizedBox(height: 10.0),
            _buildOrderTrackingRow('Order Placed', '13:17 AM, 12 February, 2004'),
            SizedBox(height: 5.0),
            _buildOrderTrackingRow('Shipped', 'Expected by 15 February 20'),
            SizedBox(height: 5.0),
            _buildOrderTrackingRow('Delivered', 'Expected by 22 February 20'),
            SizedBox(height: 20.0),

            // Cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle cancel order button press
                  },
                  child: Text('Cancel Order'),
                ),
              ],
            ),
          ],
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

  Widget _buildOrderTrackingRow(String status, String details) {
    return Row(
      children: [
        Icon(Icons.brightness_1, color: Colors.green),
        SizedBox(width: 10.0),
        Text(status),
        Spacer(),
        Text(details),
      ],
    );
  }
}
