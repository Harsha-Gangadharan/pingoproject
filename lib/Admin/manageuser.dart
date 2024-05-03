import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageUser extends StatelessWidget {
  ManageUser({Key? key}) : super(key: key);

  final List<String> userProfile = [
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
    'asset/profile.png',
  ];

  final List<String> userNames = [
    'User1',
    'User2',
    'User3',
    'User4',
    'User5',
    'User6',
  ];

  void _showReportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(),
              ListTile(
                leading: Icon(Icons.block),
                title: Text('Block'),
                onTap: () {
                  print('Block tapped');
                  Navigator.pop(context); // Close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You blocked this account'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

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
                onSelected: (value) {
                  if (value == 1) {
                    // Navigate to Home
                  } else if (value == 2) {
                    // Navigate to View Users
                  }
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userProfile.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(userProfile[index]),
                backgroundColor: Colors.grey[200],
              ),
              title: Text(
                userNames[index],
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Delete button pressed for ${userNames[index]}');
                    },
                    child: Text('Delete'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      print('Block button pressed for ${userNames[index]}');
                      _showReportBottomSheet(context);
                    },
                    child: Text('Block'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
