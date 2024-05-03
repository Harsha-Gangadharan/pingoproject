import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OrderPage extends StatefulWidget {
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('ORDERS'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
    
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Order item 1
            OrderListItem(
              orderId: '123445577',
              userName: 'username',
              artName: 'Art Name',
              artPrice: 700,
              size: 'Free size',
              quantity: 1,
              sellerName: 'example',
              hasDeliveryFee: false,
            ),
            // Order item 2
            OrderListItem(
              orderId: '123445578',
              userName: 'username',
              artName: 'Art Name',
              artPrice: 1000,
              size: 'Free size',
              quantity: 2,
              sellerName: 'example',
              hasDeliveryFee: false,
            ),
            // Order item 3
            OrderListItem(
              orderId: '123445579',
              userName: 'username',
              artName: 'Art Name',
              artPrice: 1500,
              size: '',
              quantity: 3,
              sellerName: 'example',
              hasDeliveryFee: false,
            ),
          ],
        ),
      ),
       
    );
  }
}

class OrderListItem extends StatelessWidget {
  final String orderId;
  final String userName;
  final String artName;
  final int artPrice;
  final String size;
  final int quantity;
  final String sellerName;
  final bool hasDeliveryFee;

  const OrderListItem({
    Key? key,
    required this.orderId,
    required this.userName,
    required this.artName,
    required this.artPrice,
    required this.size,
    required this.quantity,
    required this.sellerName,
    required this.hasDeliveryFee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order ID: $orderId'),
              Text('02th February'),
            ],
          ),
          SizedBox(height: 10.0),
          Text('Sold to: $userName'),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(artName),
              Spacer(),
              Text('\$$artPrice'),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              Text(size.isEmpty ? 'Size: Free size' : 'Size: $size'),
              Spacer(),
              Text('Qty: $quantity'),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text('Sold by:'),
              Text(sellerName),
              Spacer(),
              if (!hasDeliveryFee) Text('Free delivery'),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle remove button press
                },
                child: Text('Remove'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
