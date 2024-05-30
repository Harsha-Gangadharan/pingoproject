import 'package:flutter/material.dart';
import 'package:flutter_application_1/crud/model.dart';

class NewPage extends StatelessWidget {
  UserModel userModel;
  NewPage({super.key,required this.userModel});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(userModel.name),
          Text(userModel.age.toString()),
          Text(userModel.occupation),
          Text(userModel.email),
        ],
      ),
    );
  }
}