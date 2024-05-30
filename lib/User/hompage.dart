import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buynowpage.dart';
import 'cartpage.dart';
import 'chatscreen.dart';
import 'expopage.dart';
import 'review.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<bool> isFollowingList;
  late List<bool> isLikedList;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    isFollowingList = List.generate(10, (index) => false);
    isLikedList = List.generate(10, (index) => false);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPost() {
    return FirebaseFirestore.instance.collection("productdetails").snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSelectedUserProfile(String id) async {
    return await FirebaseFirestore.instance
        .collection("useregisteration")
        .doc(id)
        .get();
  }

  Future<bool> isProductInWishlist(String productId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final wishlistRef = FirebaseFirestore.instance
        .collection('wishlist')
        .where('uid', isEqualTo: uid)
        .where('productId', isEqualTo: productId);

    final favoriteDoc = await wishlistRef.get();
    return favoriteDoc.docs.isNotEmpty;
  }

  Future<void> _toggleFavorite(String productId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final wishlistRef = FirebaseFirestore.instance
        .collection('wishlist')
        .where('uid', isEqualTo: uid)
        .where('productId', isEqualTo: productId);

    final QuerySnapshot<Map<String, dynamic>> favoriteDoc = await wishlistRef.get();

    if (favoriteDoc.docs.isNotEmpty) {
      // Remove from wishlist
      await favoriteDoc.docs.first.reference.delete();
    } else {
      // Add to wishlist
      await FirebaseFirestore.instance.collection('wishlist').add({
        'productId': productId,
        'uid': uid,
      });
    }

    setState(() {
      // Refresh the state to update the UI
    });
  }

  Future<void> checkIsLikedOrNot(String productId) async {
    final isLiked = await isProductInWishlist(productId);
    setState(() {
      liked = isLiked;
    });
  }
  void _toggleFollowing(String userId) async {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final followersRef = FirebaseFirestore.instance.collection('followers').doc(userId);

  final followersDoc = await followersRef.get();
  if (followersDoc.exists) {
    // If the document already exists, update the "following" field
    List<String> followingList = List<String>.from(followersDoc.data()!['following'] ?? []);
    if (followingList.contains(currentUserId)) {
      // If the current user is already in the following list, remove them
      followingList.remove(currentUserId);
    } else {
      // Otherwise, add the current user to the following list
      followingList.add(currentUserId);
    }
    await followersRef.update({'following': followingList});
  } else {
    // If the document does not exist, create a new one
    await followersRef.set({'following': [currentUserId]});
  }
}
Future<bool> isProductInCart(String productId) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final cartRef = FirebaseFirestore.instance
      .collection('cart')
      .where('uid', isEqualTo: uid)
      .where('productId', isEqualTo: productId);

  final cartDoc = await cartRef.get();
  return cartDoc.docs.isNotEmpty;
}
Future<void> _toggleCart(String productId, Map<String, dynamic> productData) async {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final cartRef = FirebaseFirestore.instance
      .collection('cart')
      .where('uid', isEqualTo: uid)
      .where('productId', isEqualTo: productId);

  final QuerySnapshot<Map<String, dynamic>> cartDoc = await cartRef.get();

  if (cartDoc.docs.isNotEmpty) {
    // Remove from cart
    await cartDoc.docs.first.reference.delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item removed from cart'),
        duration: Duration(seconds: 2),
      ),
    );
  } else {
    // Add to cart
    await FirebaseFirestore.instance.collection('cart').doc(productId).set({
      'productId': productId,
      'uid': uid,
      'productData': productData,
      'qty':1,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added to cart'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  setState(() {
    // Refresh the state to update the UI
  });
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
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Chatscreen()),
              );
            },
            icon: Icon(Icons.comment_rounded),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
             Navigator.push(
                context,
               MaterialPageRoute(builder: (context) => CartPage())
              );
            },
            icon: Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtExpo()),
              );
            },
            icon: Icon(Icons.palette),
            color: Colors.black,
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.docs;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      future: getSelectedUserProfile(data[index]["uid"]),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox();
                        }

                        final userData = userSnapshot.data!.data();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(userData?["image"] ?? ""),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  userData?["username"] ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
ElevatedButton(
  onPressed: () {
    _toggleFollowing(data[index]["uid"]); // Call _toggleFollowing with the target user's ID
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
    isFollowingList[index]
      ? 'Following'
      : 'Follow',
    style: TextStyle(color: Colors.black),
  ),
),

                                PopupMenuButton(
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      const PopupMenuItem(
                                        child: Row(
                                          children: [
                                            Icon(Icons.share),
                                            Text('Share')
                                          ],
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
                                            Icon(Icons.message),
                                            Text('Send Message')
                                          ],
                                        ),
                                        value: 'Send Message',
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
                                image: DecorationImage(
                                  image: NetworkImage(data[index]["productimage"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                              SizedBox(height: 10),
    Text(
      data[index]["description"] ?? "", // Fetch and display description
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FutureBuilder<bool>(
                                  future: isProductInWishlist(data[index].id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return IconButton(
                                        icon: Icon(Icons.favorite_border),
                                        onPressed: null,
                                      );
                                    }
                                    bool isLiked = snapshot.data ?? false;
                                    return IconButton(
                                      onPressed: () {
                                        _toggleFavorite(data[index].id);
                                      },
                                      icon: Icon(
                                        isLiked ? Icons.favorite : Icons.favorite_border,
                                        color: isLiked ? Colors.red : null,
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewPage(
                                          userProfileImage: userData?["image"] ?? "",
                                          userName: userData?["username"] ?? "",
                                          productImage: data[index]["productimage"],
                                          productId: data[index]['productId'],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.comment_outlined),
                                ),
                                Text(
                                  '\u20B9 ${data[index]["amount"]}', // Add the rupee symbol as a prefix
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BuynowPage( productId: data[index]['productId'],userProfileImage: userData?["image"] ?? "",userName: userData?["username"] ?? "",
                                          )),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 195, 60, 105),
                                  ),
                                  child: Text(
                                    'Buy Now',
                                    style: GoogleFonts.inknutAntiqua(color: Colors.white),
                                  ),
                                ),
                               FutureBuilder<bool>(
  future: isProductInCart(data[index].id),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: null,
      );
    }
    bool isInCart = snapshot.data ?? false;
    return IconButton(
      onPressed: () {
        _toggleCart(data[index].id, data[index].data());
      },
      icon: Icon(
        isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
        color: isInCart ? Colors.red : null,
      ),
    );
  },
),

                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
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
}
