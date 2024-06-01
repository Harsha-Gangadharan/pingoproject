import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/User/artistconfirmation.dart';
import 'package:google_fonts/google_fonts.dart';

class Expovote extends StatefulWidget {
  String expoId;
Expovote({required this.expoId});
  @override
  State<Expovote> createState() => _ExpovoteState();
}

class _ExpovoteState extends State<Expovote> {
  List<bool> isSelected = [false, false, false, false, false, false];
  List<int> voteCount = [0, 0, 0, 0, 0, 0];
  late List<bool> isLikedList;
  String? profileImageUrl;
  String? expoTitle;
  // String? expoId;
  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    isLikedList = List.generate(10, (index) => false);
    fetchUserProfile();
    fetchExpoTitle();
  }

  Future<void> fetchUserProfile() async {
    if (user != null) {
      var userProfile = await FirebaseFirestore.instance.collection('useregistration').doc(user!.uid).get();
      setState(() {
        profileImageUrl = userProfile['image'];
      });
    }
  }

  Future<void> fetchExpoTitle() async {
    // String uid = FirebaseAuth.instance.currentUser!.uid;
    var expoDocument = await FirebaseFirestore.instance.collection('expo').doc(widget.expoId).get();
    setState(() {
      expoTitle = expoDocument['title'];
      // expoId=expoDocument['expoId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(183, 225, 56, 132),
        title: Text(
          'Themes In Art',
          style: GoogleFonts.inknutAntiqua(
            fontSize: 26,
            color: Color.fromARGB(255, 14, 14, 14),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection('useregisteration')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.hasError) {
                    return const Center(child: Text('No data available'));
                  }
                  DocumentSnapshot data = snapshot.data!;
                  if (!data.exists) {
                    return const Center(child: Text('No data available'));
                  }
                  String imageUrl = data.get('image') ?? '';

                  return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              expoTitle ?? 'Loading...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Art can be added to this topic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: 10),
             CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(imageUrl),
                      ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Here a new one for you!\n Add art from your experiences on this topic',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtistConfirm(expoId: widget.expoId,),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 60, 155, 195),
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text('66 art works'),
            const SizedBox(height: 2.0),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height*.2,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:  FirebaseFirestore.instance.collection('expo').doc(widget.expoId).collection("Participants").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  final data=snapshot.data!.docs;
                  if(snapshot.hasData){
                    return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(image: NetworkImage(data[index]["productimage"]))),
                              
                            ),
                              buildIconButton(index,data[index]["Likes"],data[index]["uid"]),
                      ],
                    );
                  }, separatorBuilder: (context, index) => SizedBox(width: 20,), itemCount: data.length);

                  }else{
                    return Center(child: Text("NO PARTICIPANT"),);
                  }
                  
                }
              ),
            ),
            // const SizedBox(height: 16.0),
           
          ],
                
      );
                }
    ),
            )
          ]
        )
      )
    );
  }
  likeExpo(participantId,List list){
    if(!(list.contains(FirebaseAuth.instance.currentUser!.uid))){
     list.add(FirebaseAuth.instance.currentUser!.uid);
          FirebaseFirestore.instance.collection('expo').doc(widget.expoId).collection("Participants").doc(participantId).update({"Likes":list});

    }

  }

  Widget buildIconButton(int buttonIndex,List vote,docId) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                likeExpo(docId,vote);
                // setState(() {
                //   isSelected[buttonIndex] = !isSelected[buttonIndex];
                //   if (isSelected[buttonIndex]) {
                //     voteCount[buttonIndex]++;
                //   } else {
                //     voteCount[buttonIndex]--;
                //   }
                // });
              },
              icon: Icon(
                vote.contains(FirebaseAuth.instance.currentUser!.uid)
                    ? Icons.thumb_up
                    : Icons.thumb_up_alt_outlined,
                color: isSelected[buttonIndex] ? Colors.black : null,
              ),
            ),
            Text('Votes: ${vote.length}'),
          ],
        ),
      ],
    );
  }
}
