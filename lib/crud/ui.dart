import 'package:flutter/material.dart';
import 'package:flutter_application_1/crud/controller.dart';
import 'package:flutter_application_1/crud/model.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Controller controller = Controller();

  @override
  void initState() {
    super.initState();
    controller.fetchAllUser().then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                trailing: IconButton(
                  onPressed: () {
                    controller.update(controller.listofData[index].id, 33).then((value) => setState(() {
                      controller.fetchAllUser();
                    }));
                  },
                  icon: Icon(Icons.delete),
                ),
                onTap: () {
                  controller.fechSingleUserData(controller.listofData[index].id).then((value) => setState(() {}));
                },
                leading: Text("${index + 1}"),
                title: Text(controller.listofData[index].name.toString()),
              ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: controller.listofData.length,
            ),
          ),
          controller.singleUserData == null
              ? Text("No data")
              : Column(
                  children: [
                    Text(controller.singleUserData!.name),
                    Text(controller.singleUserData!.age.toString()),
                    Text(controller.singleUserData!.occupation),
                    Text(controller.singleUserData!.email),
                  ],
                ),
          TextButton(
            onPressed: () {
              controller.adduser(UserModel(
                name: "anil",
                age: 22,
                email: "email.com",
                occupation: "software",
              )).then((value) => setState(() {}));
            },
            child: Text("Upload data"),
          ),
        ],
      ),
    );
  }
}
