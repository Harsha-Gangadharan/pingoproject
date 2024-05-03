import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/buynowpage.dart';
import 'package:flutter_application_1/User/cartpage.dart';
import 'package:flutter_application_1/User/chatscreen.dart';
import 'package:flutter_application_1/User/expopage.dart';
import 'package:flutter_application_1/User/review.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<bool> isFollowingList;
  late List<bool> isLikedList;
  final List<String> comments = ['Comment 1', 'Comment 2', 'Comment 3'];

  @override
  void initState() {
    super.initState();
    isFollowingList = List.generate(10, (index) => false);
    isLikedList = List.generate(10, (index) => false);
  }

  void _selectRandomIndex() {
    final Random random = Random();
    setState(() {
    
    });
  }

  void _showReportBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.report),
                title: Text('Report'),
                onTap: () {
                  // Handle Report tap
                  print('Report tapped');
                  Navigator.pop(context); // Close the bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('You reported this account'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.block),
                title: Text('Block'),
                onTap: () {
                  // Handle Block tap
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
                child: Text('Close'),
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
          SizedBox(width: 20.0),
          IconButton(
            onPressed: () { Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Chatscreen()),
                            );},
            icon: Icon(Icons.comment_rounded),
            color: Colors.black,
          ),
          SizedBox(width: 20.0),
          IconButton(
            onPressed: () { Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CartPage()),
                            );},
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
          SizedBox(width: 20.0),
          IconButton(
            onPressed: () { Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ArtExpo()),
                            );},
            icon: Icon(Icons.palette),
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Profile Name $index',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isFollowingList[index] = !isFollowingList[index];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFollowingList[index]
                                ? Colors.blue.shade300
                                : Colors.grey,
                          ),
                          child: Text(
                            isFollowingList[index] ? 'Following' : 'Follow',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        PopupMenuButton(
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                child: Row(
                                  children: [Icon(Icons.share), Text('Share')],
                                ),
                                value: 'Share',
                              ),
                              const PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.person_off),
                                    Text('Unfollow')
                                  ],
                                ),
                                value: 'Unfollow',
                              ),
                              const PopupMenuItem(
                                child: Row(
                                  children: [
                                    Icon(Icons.report),
                                    Text('Report')
                                  ],
                                ),
                                value: 'Report',
                              ),
                            ];
                          },
                          onSelected: (value) {
                            switch (value) {
                              case 'Share':
                                // Handle Share action
                                break;
                              case 'Unfollow':
                                // Handle Unfollow action
                                break;
                              case 'Report':
                                _showReportBottomSheet(); // Show bottom sheet for report
                                break;
                              default:
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 400,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text('Post $index'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isLikedList[index] = !isLikedList[index];
                            });
                          },
                          icon: Icon(
                            isLikedList[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isLikedList[index] ? Colors.red : null,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewPage()),
                            );
                          },
                          icon: Icon(Icons.comment_outlined),
                        ),
                        const Text(
                          'Price: ₹XX.XX',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Buynow()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 195, 60, 105)),
                          child: Text(
                            'Buy Now',
                            style:
                                GoogleFonts.inknutAntiqua(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Item added to cart'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          icon: Icon(Icons.add_shopping_cart),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
