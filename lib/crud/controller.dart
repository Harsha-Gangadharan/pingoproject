import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/crud/model.dart';
class Controller {
  final db=FirebaseFirestore.instance;
  Future adduser(ReportModel userModel) async{
    final docRef= db.collection('user cart').doc();
    dynamic id = docRef.id;
    docRef.set(userModel.data(id));
    fetchAllUser();
  }
  List<ReportModel>listofData=[];
  Future<List<ReportModel>>fetchAllUser() async{
    print('Data Fetching');
    final snapshot = await db.collection('user cart').get();
    listofData=snapshot.docs.map((e) {
      return ReportModel.fromData(e.data());
    }).toList();
    return listofData;
  }
  ReportModel?singleUserData;
  Future fechSingleUserData(id)async{
    final snapshot= await db.collection('user cart').doc(id).get();

    singleUserData=ReportModel.fromData(snapshot.data()!);
  }
  Future deleteUser(id)async{
    db.collection('user cart').doc(id).delete();
  }
  update(id,age)async{
    db.collection('user cart').doc(id).update({"age":age});
  }
}