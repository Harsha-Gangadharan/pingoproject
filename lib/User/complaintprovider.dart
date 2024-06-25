import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/model/compainmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ComplaintProvider with ChangeNotifier {
  int _complaintsCount = 0;

  int get complaintsCount => _complaintsCount;

  void incrementComplaints(String uid,  prdocuctid ) {
    _complaintsCount += 1;
   
   addComplaint(Complaints(sellerId: uid, productid: prdocuctid, count: complaintsCount, ));
     

    notifyListeners();
  }

  

   Future addComplaint( Complaints complaints)async{
    final snapshot =   db.collection('useregisteration').doc(auth.currentUser!.uid).collection('Raisedissue').doc(auth.currentUser!.uid);

      snapshot.set(complaints.toJson());
   }
  
}
