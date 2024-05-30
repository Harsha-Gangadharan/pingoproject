import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // List to keep track of liked items
  List<bool> isLikedList = [];

  Stream<QuerySnapshot> getAllPost() {
    String uid = _auth.currentUser!.uid;
    return FirebaseFirestore.instance.collection('wishlist').where('uid', isEqualTo: uid).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSellerDetails(String userId) {
    return FirebaseFirestore.instance.collection("useregisteration").doc(userId).get();
  }

  Future<DocumentSnapshot> getProductDetails(String productId) {
    return FirebaseFirestore.instance.collection('productdetails').doc(productId).get();
  }

  void handleLikeButtonPress(String docId, int index) async {
    final itemRef = FirebaseFirestore.instance.collection('wishlist').doc(docId);
    final doc = await itemRef.get();
    if (doc.exists) {
      final isLiked = doc['isLiked'] ?? false;
      await itemRef.update({'isLiked': !isLiked});
      setState(() {
        isLikedList[index] = !isLikedList[index];
      });
    }
  }

  void handleDeleteButtonPress(String docId) async {
    await FirebaseFirestore.instance.collection('wishlist').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text('Wishlist'),
        titleTextStyle: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          color: Color.fromARGB(255, 14, 14, 14),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getAllPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data!.docs;
          if (isLikedList.length != data.length) {
            isLikedList = List<bool>.filled(data.length, false);
          }
        
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              final docId = item.id;
              return FutureBuilder<DocumentSnapshot>(
                future: getProductDetails(item["productId"]),
                builder: (context, productSnapshot) {
                  if (productSnapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(); // Return a placeholder widget while waiting for data
                  }
                  if (productSnapshot.hasError) {
                    return ListTile(
                      title: Text('Error: ${productSnapshot.error}'),
                    ); // Handle error case
                  }
                  final productData = productSnapshot.data?.data() as Map<String, dynamic>? ?? {};
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: getSellerDetails(productData?["uid"]),
                        builder: (context, sellerSnapshot) {
                          if (sellerSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!sellerSnapshot.hasData || !sellerSnapshot.data!.exists) {
                            return Center(
                              child: Text('No seller details available'),
                            );
                          }
                          final sellerData = sellerSnapshot.data!.data();
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(sellerData?["image"] ?? ""),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Sold by: ${sellerData?["username"] ?? ""}',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 20,),
                      Stack(
                        children: [
                          Image.network(
                            productData['productimage'] ?? '',
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.grey,
                                child: Center(
                                  child: Text('Image not available'),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black54,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.white),
                                    onPressed: () => handleDeleteButtonPress(docId),
                                  ),
                                  Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        productData['description'] ?? 'No description available', // Display product description
                      ),
                      Text(
                        '\u20B9 ${productData["amount"] ?? 'N/A'}', // Display product amount
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      SizedBox(height: 30,),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
