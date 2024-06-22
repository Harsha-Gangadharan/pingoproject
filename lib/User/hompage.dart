import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/proflie.dart';
import 'package:flutter_application_1/chatroom/chatscreen.dart';
import 'package:flutter_application_1/crud/model.dart';
import 'package:google_fonts/google_fonts.dart';

import 'buynowpage.dart';
import 'cartpage.dart';
import 'expopage.dart';
import 'review.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  late List<bool> isFollowingList;
  late List<bool> isLikedList;
  bool liked = false;

  @override
  void initState() {
    super.initState();
    isFollowingList = List.generate(10, (index) => false);
    isLikedList = List.generate(10, (index) => false);
  }

  List userCategory = [];
  getuserCategory() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("useregisteration")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      userCategory = snapshot.data()!["selected category"];
      log(userCategory.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllPost() {
    // getuserCategory();
    // return FirebaseFirestore.instance.collection("productdetails").snapshots();
    return FirebaseFirestore.instance
        .collection("productdetails")
        .where("category", whereIn: List.from(userCategory))
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getSelectedUserProfile(
      String id) async {
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

    final QuerySnapshot<Map<String, dynamic>> favoriteDoc =
        await wishlistRef.get();

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

  Stream<DocumentSnapshot<Map<String, dynamic>>> cheCkTheUserIsAlreadyFollowed(
      anothorUserId) {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("useregisteration")
        .doc(currentUserId)
        .collection("Following")
        .doc(anothorUserId)
        .snapshots();
  }

  followUser(anothorUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

// final snapshot=await FirebaseFirestore.instance
//         .collection("followers")
//         .doc(currentUserId+anothorUserId).get();
// List followersList=[];
//         if(snapshot.exists){

// final foo=snapshot.data()!["Followers"] as List;
// followersList=foo.map((e) => e).toList();
//         }
// followersList.add(anothorUserId);
    final collection =
        FirebaseFirestore.instance.collection("useregisteration");
    collection
        .doc(currentUserId)
        .collection("Following")
        .doc(anothorUserId)
        .set({"id": anothorUserId});
    collection
        .doc(anothorUserId)
        .collection("Followers")
        .doc(currentUserId)
        .set({"id": currentUserId});
  }

  unFollow(anothorUserId) async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final collection =
        FirebaseFirestore.instance.collection("useregisteration");
    collection
        .doc(currentUserId)
        .collection("Following")
        .doc(anothorUserId)
        .delete();
    collection
        .doc(anothorUserId)
        .collection("Followers")
        .doc(currentUserId)
        .delete();
  }

  // void _toggleFollowing(String userId) async {
  //   final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  //   final followersRef =
  //       FirebaseFirestore.instance.collection('followers').doc(currentUserId);

  //   final followersDoc = await followersRef.get();
  //   if (followersDoc.exists) {
  //     // If the document already exists, update the "following" field
  //     List<String> followingList =
  //         List<String>.from(followersDoc.data()!['following'] ?? []);
  //     if (followingList.contains(currentUserId)) {
  //       // If the current user is already in the following list, remove them
  //       followingList.remove(currentUserId);
  //     } else {
  //       // Otherwise, add the current user to the following list
  //       followingList.add(userId);
  //     }
  //     await followersRef.update({'Followers': followingList});
  //   } else {
  //     // If the document does not exist, create a new one
  //     await followersRef.set({
  //       'following': [currentUserId]
  //     });
  //   }
  // }

  Future<bool> isProductInCart(String productId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final cartRef = FirebaseFirestore.instance
        .collection('cart')
        .where('uid', isEqualTo: uid)
        .where('productId', isEqualTo: productId);

    final cartDoc = await cartRef.get();
    return cartDoc.docs.isNotEmpty;
  }

  Future<void> _toggleCart(
      String productId, Map<String, dynamic> productData) async {
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
        'qty': 1,
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

  void reportProduct(String productId, String sellerId, String userId) async {
    // Define your report limit
    const int reportLimit = 5;

    CollectionReference reports =
        FirebaseFirestore.instance.collection('reports');

    // Check if a report already exists
    DocumentSnapshot reportDoc = await reports.doc(productId).get();

    if (reportDoc.exists) {
      // If a report already exists by this user, update the existing report
      ReportModel report =
          ReportModel.fromData(reportDoc.data() as Map<String, dynamic>);

      // Increment the count
      report.count += 1;

      // Update the report count in Firestore
      reports.doc(productId).update({'count': report.count}).then((_) {
        log('Report count incremented successfully');
      }).catchError((error) {
        log('Failed to increment report count: $error');
      });

      // Check if the report count has reached the limit
      if (report.count >= reportLimit) {
        // Delete the product from Firestore
        FirebaseFirestore.instance
            .collection('productdetails')
            .doc(productId)
            .delete()
            .then((_) {
          log('Product deleted successfully due to reports');
        }).catchError((error) {
          log('Failed to delete product: $error');
        });

        // Delete the report document from Firestore
        reports.doc(productId).delete().then((_) {
          log('Report document deleted successfully');
        }).catchError((error) {
          log('Failed to delete report document: $error');
        });
      }
    } else {
      // Create a new report if it doesn't exist
      ReportModel newReport = ReportModel(
        productId: productId,
        id: productId,
        sellerId: sellerId,
        userId: userId,
        count: 1, // Initialize count to 1
      );

      // Add the new report to Firestore
      reports.doc(productId).set(newReport.data(productId)).then((_) {
        log('Report added successfully');
      }).catchError((error) {
        log('Failed to add report: $error');
      });
    }
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
            icon: const Icon(Icons.comment_rounded),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            icon: const Icon(Icons.shopping_cart),
            color: Colors.black,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtExpo()),
              );
            },
            icon: const Icon(Icons.palette),
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder(
          future: getuserCategory(),
          builder: (context, categoryNsap) {
            if (categoryNsap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: getAllPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = snapshot.data!.docs;

                return data.isEmpty
                    ? const Center(
                        child: Text("No Posts"),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return FutureBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                  future: getSelectedUserProfile(
                                      data[index]["uid"]),
                                  builder: (context, userSnapshot) {
                                    if (userSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox();
                                    }

                                    final userData = userSnapshot.data!.data();

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfilePage(
                                                      id: userData?["id"],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    userData?["image"] ?? ""),
                                                radius: 20,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              userData?["username"] ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            data[index]["uid"] ==
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid
                                                ? const SizedBox()
                                                : StreamBuilder(
                                                    stream:
                                                        cheCkTheUserIsAlreadyFollowed(
                                                            data[index]["uid"]),
                                                    builder:
                                                        (context, snapshot) {
                                                      // bool following=false;

                                                      // if (snapshot.hasData) {
                                                      //   log("true");
                                                      //   following = true;
                                                      // } else {
                                                      //   log("false");
                                                      //   following = false;
                                                      // }
                                                      if (snapshot.hasData) {
                                                        return ElevatedButton(
                                                          onPressed: () {
                                                            if (snapshot
                                                                .data!.exists) {
                                                              unFollow(
                                                                  data[index]
                                                                      ["uid"]);
                                                            } else {
                                                              followUser(
                                                                  data[index]
                                                                      ["uid"]);
                                                            }
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                snapshot.data!
                                                                        .exists
                                                                    ? Colors
                                                                        .blue
                                                                        .shade300
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                          child: Text(
                                                            snapshot.data!
                                                                    .exists
                                                                ? 'Following'
                                                                : 'Follow',
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        );
                                                      } else {
                                                        return SizedBox();
                                                      }
                                                    }),
                                            PopupMenuButton(itemBuilder:
                                                (BuildContext context) {
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
                                                      Icon(Icons.delete),
                                                      Text('Delete')
                                                    ],
                                                  ),
                                                  value: 'Delete',
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
                                            }, onSelected: (value) {
                                              switch (value) {
                                                case 'Share':
                                                  // Handle Share action
                                                  break;
                                                case 'Unfollow':
                                                  // Handle Unfollow action
                                                  break;
                                                case 'Report':
                                                  _showReportBottomSheet(
                                                      data[index]["productId"],
                                                      data[index]["uid"],
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid);
                                                  break;
                                                default:
                                              }
                                            }),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          height: 400,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  data[index]["productimage"]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          data[index]["description"] ??
                                              "", // Fetch and display description
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            FutureBuilder<bool>(
                                              future: isProductInWishlist(
                                                  data[index].id),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const IconButton(
                                                    icon: Icon(
                                                        Icons.favorite_border),
                                                    onPressed: null,
                                                  );
                                                }
                                                bool isLiked =
                                                    snapshot.data ?? false;
                                                return IconButton(
                                                  onPressed: () {
                                                    _toggleFavorite(
                                                        data[index].id);
                                                  },
                                                  icon: Icon(
                                                    isLiked
                                                        ? Icons.favorite
                                                        : Icons.favorite_border,
                                                    color: isLiked
                                                        ? Colors.red
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReviewPage(
                                                      userProfileImage:
                                                          userData?["image"] ??
                                                              "",
                                                      userName: userData?[
                                                              "username"] ??
                                                          "",
                                                      productImage: data[index]
                                                          ["productimage"],
                                                      productId: data[index]
                                                          ['productId'], 
                                                          sellerId: data[index]['uid'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.comment_outlined),
                                            ),
                                            Text(
                                              '\u20B9 ${data[index]["amount"]}', // Add the rupee symbol as a prefix
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BuynowPage(
                                                            productId: data[
                                                                    index]
                                                                ['productId'],
                                                            userProfileImage:
                                                                userData?[
                                                                        "image"] ??
                                                                    "",
                                                            userName: userData?[
                                                                    "username"] ??
                                                                "",
                                                          )),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 195, 60, 105),
                                              ),
                                              child: Text(
                                                'Buy Now',
                                                style:
                                                    GoogleFonts.inknutAntiqua(
                                                        color: Colors.white),
                                              ),
                                            ),
                                            FutureBuilder<bool>(
                                              future: isProductInCart(
                                                  data[index].id),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const IconButton(
                                                    icon: Icon(Icons
                                                        .add_shopping_cart),
                                                    onPressed: null,
                                                  );
                                                }
                                                bool isInCart =
                                                    snapshot.data ?? false;
                                                return IconButton(
                                                  onPressed: () {
                                                    _toggleCart(data[index].id,
                                                        data[index].data());
                                                  },
                                                  icon: Icon(
                                                    isInCart
                                                        ? Icons
                                                            .remove_shopping_cart
                                                        : Icons
                                                            .add_shopping_cart,
                                                    color: isInCart
                                                        ? Colors.red
                                                        : null,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
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
            );
          }),
    );
  }

  void _showReportBottomSheet(
      String productId, String sellerId, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Report Product'),
              ElevatedButton(
                onPressed: () {
                  reportProduct(productId, sellerId, userId);
                  Navigator.pop(context);
                },
                child: Text('Report'),
              ),
            ],
          ),
        );
      },
    );
  }
}
