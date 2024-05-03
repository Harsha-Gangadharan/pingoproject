import'package:firebase_core/firebase_core.dart';
import'package:cloud_firestore/cloud_firestore.dart';
class firebaseHelper{
  final _firebase=FirebaseFirestore.instance;
  Future addfirebase(Map<String,dynamic>registerreduserinfomap,String userid)async{
    return _firebase
    .collection('firebase')
    .doc(userid)
    .set(registerreduserinfomap);
  }
}