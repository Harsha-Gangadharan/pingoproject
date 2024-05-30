import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/proflie.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _search() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    List<Map<String, dynamic>> users = [];
    List<Map<String, dynamic>> products = [];

    // Search in useregisteration collection by username
    QuerySnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('useregisteration')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    users = userSnapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;  // Store document ID for navigation
      return data;
    }).toList();

    // Search in productdetails collection by category and description
    QuerySnapshot productSnapshot = await FirebaseFirestore.instance
        .collection('productdetails')
        .where('category', isGreaterThanOrEqualTo: query)
        .where('category', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    products = productSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    productSnapshot = await FirebaseFirestore.instance
        .collection('productdetails')
        .where('description', isGreaterThanOrEqualTo: query)
        .where('description', isLessThanOrEqualTo: query + '\uf8ff')
        .get();
    products.addAll(productSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());

    setState(() {
      _searchResults = [...users, ...products];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(192, 255, 64, 128),
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.5),
            hintText: 'Search',
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide.none,
            ),
            hintStyle: TextStyle(color: Colors.black),
          ),
          onChanged: (value) {
            _search();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: _search,
          ),
       
        ],
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final result = _searchResults[index];
          final isUser = result.containsKey('username');

       // In your ListView.builder, update the ListTile as follows:

return ListTile(
  leading: isUser
      ? result['image'] != null
          ? CircleAvatar(
              backgroundImage: NetworkImage(result['image']),
            )
          : CircleAvatar(
              child: Text(result['username'][0].toUpperCase()),
            )
      : result.containsKey('productimage')
          ? Image.network(result['productimage'], fit: BoxFit.cover, width: 50, height: 50)
          : CircleAvatar(child: Text('P')),
  title: Text(result['username'] ?? result['category'] ?? 'Unknown'),
  subtitle: Text(result['description'] ?? ''),
  onTap: isUser
      ? () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        }
      : () {
          // Handle product tap if needed
        },
);

        },
      ),
    );
  }
}


