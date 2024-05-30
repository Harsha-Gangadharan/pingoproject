import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _isOrdersSelected = false;
  bool _isActivitiesSelected = false;
int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Notification',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon pressed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOrdersSelected = true;
                    _isActivitiesSelected = false;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isOrdersSelected ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Orders',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(width: 30,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOrdersSelected = false;
                    _isActivitiesSelected = true;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _isActivitiesSelected ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Activities',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Add your main content here
          Expanded(
            child: Center(
              child: _isOrdersSelected
                  ? Text('Orders content goes here')
                  : _isActivitiesSelected
                      ? Text('Activities content goes here')
                      : Text('Select a title above'),
            ),
          ),
        ],
      ),
     
    );
  }
}
