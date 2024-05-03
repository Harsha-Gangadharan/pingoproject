import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YourOrder extends StatelessWidget {
  const YourOrder({Key? key}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Your Orders'),
    ),
    body: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _orderIdRow(),
          _paymentModeRow(),
          Divider(),
          _receiverAddressRow(),
          _productDetailsRow(),
          _soldByRow(),
          _orderTrackingRow(),
          _orderDetailsRow(context), // Pass context here
          _priceDetailsRow(),
        ],
      ),
    ),
  );
}


  Widget _orderIdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Sub Order ID:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('77595935'),
      ],
    );
  }

  Widget _paymentModeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Payment Mode:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Cash on delivery/Online Payment'),
      ],
    );
  }

  Widget _receiverAddressRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Receiver Address:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Example house, local arva, post office.\near city, district, state, pincode, phone number'),
      ],
    );
  }

  Widget _productDetailsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(), 
        Text('Art Name'),
        SizedBox(height: 8), 
        Container( 
          width: 50,
          height: 50,
          color: Colors.grey[200],
        ),
        Text('Size: Free size'),
        Divider(), // Line under Size
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Qty-1'),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => print('Remove button pressed'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _soldByRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Sold by:'),
        Text('example'),
        Text('free delivery'),
      ],
    );
  }

  Widget _orderTrackingRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text('Order Tracking:'),
        Row(
          children: [
            Text('Order Placed:'),
            Text('1117 AM, 12 February, 2024'),
          ],
        ),
        Row(
          children: [
            Text('Shipped:'),
            Text('Enter shipping Date'),
          ],
        ),
        Row(
          children: [
            Text('Delivered:'),
            Text('Enter Deliver Date'),
          ],
        ),
        Divider(), 
      ],
    );
  }
Widget _orderDetailsRow(BuildContext context) { // Add context argument here
  String? _selectedOption;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Divider(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Order Status:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                context: context, // Use the context passed from the outer method
                builder: (BuildContext context) {
                  return Container(
                    height: 200.0,
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text('Processing'),
                          value: 'Processing',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            _selectedOption = value;
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Pending'),
                          value: 'Pending',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            _selectedOption = value;
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Completed'),
                          value: 'Completed',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            _selectedOption = value;
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('Select Status'),
          ),
        ],
      ),
      Divider(),
    ],
  );
}


  Widget _priceDetailsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text('Price Details (1 item)'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Product Price'),
            Text('₹700'),
          ],
        ),
        TextButton(
          onPressed: () => print('View price details pressed'),
          child: Text('view price details'),
        ),
      ],
    );
  }
}
