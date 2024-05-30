import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/package.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  final ammountController = TextEditingController();
  final descriptionController = TextEditingController();
  File? uploadImage;
  List<bool> isSelected = [false, false, false, false, false, false];
  String selectedCategory = '';

  Future<void> productTable() async {
    try {
      String uid = _auth.currentUser!.uid;
      var docRef = FirebaseFirestore.instance.collection('productdetails').doc();
      String docId = docRef.id;

      await docRef.set({
        'amount': int.parse(ammountController.text),
        'description': descriptionController.text,
        'productimage': '',
        'uid': uid,
        'category': selectedCategory,
        'productId': docId
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product added successfully'),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Packages(indexNum: 0)));

      if (uploadImage != null) {
        SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('productimage/product_$docId')
            .putFile(uploadImage!, metadata);
        TaskSnapshot snapshot = await uploadTask;
        String url = await snapshot.ref.getDownloadURL();

        await docRef.update({'productimage': url});
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => Packages(indexNum: 0)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product: $e'),
        ),
      );
    }
  }

  Future<void> _pickedImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    setState(() {
      uploadImage = File(pickedImage.path);
    });
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Photo Library'),
              onTap: () {
                Navigator.of(context).pop();
                _pickedImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickedImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'NEW POST',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _showImageSourceActionSheet(context);
              },
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: uploadImage != null
                            ? FileImage(uploadImage!)
                            : AssetImage('asset/addpost.png') as ImageProvider<Object>,
                      ),
                      shape: BoxShape.rectangle,
                      color: Colors.grey[300],
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: IconButton(
                      onPressed: () {
                        _showImageSourceActionSheet(context);
                      },
                      icon: Icon(Icons.add_a_photo_rounded),
                      color: Colors.black,
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.currency_rupee, color: Colors.grey),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: ammountController,
                      decoration: InputDecoration(
                        hintText: 'Enter amount',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Enter description',
                          labelText: 'Description',
                        ),
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      alignment: WrapAlignment.center,
                      children: [
                        for (int i = 0; i < 6; i++)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectCategory(i, categories[i]);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected[i]
                                  ? Colors.pink
                                  : const Color.fromARGB(142, 123, 120, 121),
                            ),
                            child: Text(
                              categories[i],
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    productTable();
                  },
                  child: Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final List<String> categories = [
    'Photo Realism',
    'Abstract',
    'Composite',
    'Whimsical',
    'Sculpture',
    'Cubism'
  ];

  void _selectCategory(int index, String category) {
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      isSelected[buttonIndex] = buttonIndex == index;
    }
    selectedCategory = category;
  }
}
