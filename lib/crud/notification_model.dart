import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationModel {
  String ?notid;
  String message;
  String fromId;
  String toID;
  String type;

  NotificationModel(
      {required this.fromId,
      required this.message,
       this.notid,
      required this.toID,
      required this.type});

  Map<String, dynamic> toJson(id) => {
        "notid": id,
        "message": message,
        "fromId": fromId,
        "toID": toID,
        "type": type
      };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        fromId: json["fromId"],
        message: json["message"],
        notid: json["notid"],
        toID: json["toID"],
        type: json["type"]);
  }
}


sendNotiifcation(NotificationModel notificationModel)async{

final docs=  FirebaseFirestore.instance.collection("Notifications").doc();
docs.set(notificationModel.toJson(docs.id));


}
getNotifcation(){

return  FirebaseFirestore.instance.collection("Notifications").where("type",isEqualTo: "Admin").snapshots();
}

getCurrentUserNotification(){
  return  FirebaseFirestore.instance.collection("Notifications").where("toID",isEqualTo:FirebaseAuth.instance.currentUser!.uid).snapshots();

}
