import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/home.dart';
import 'package:flutter_application_1/User/cartsummery.dart';
import 'package:flutter_application_1/controller/payment_controller.dart';
import 'package:flutter_application_1/main.dart';

class ShowPaymentoptions extends StatelessWidget {
  double totalAMount;
  String page;
 ShowPaymentoptions({super.key,required this.totalAMount,required this.page});

  @override
  Widget build(BuildContext context) {
    log(totalAMount.toString());
    return FutureBuilder(
          future: PaymentController().initializeUpiIndia(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    PaymentController()
                        .initiateTransaction(context,
                            app: snapshot.data![index],
                            receiverUpiId:RECEIVERUPIID,
                            receiverName: "Pingo",
                            amount: totalAMount)
                        .then((value) async {
                                                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartSummery()));

                      // for (var i in widget.productModel) {
                      //   DBService().afterCompletPayment(BuyProductModel(
                      //       boughtDate: date,
                      //       renewelDate: dateAfter1Year,
                      //       uid: FirebaseAuth.instance.currentUser!.uid,
                      //       productModel: i,
                      //       totalAmount: widget.amount));
                      //   if (widget.fromCart == true) {
                      //     DBService().removeFromCar();
                      //   }
                      // }
                
                      // log(value.toString());
                      // return transaction = value as Future<UpiResponse>?;
                    }).catchError((error) {
                      if(page=="Admin"){
Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>AdHome()), (route) => false);

                      }else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartSummary()));

                      }

                      
                    //   for (var i in widget.productModel) {
                    //     // log(date);
                    //     // log(message)
                    //     DBService()
                    //         .afterCompletPayment(BuyProductModel(
                    //             boughtDate: date,
                    //             renewelDate: dateAfter1Year,
                    //             uid: FirebaseAuth.instance.currentUser!.uid,
                    //             productModel: i,
                    //             totalAmount: widget.amount))
                    //         .then((value) {
                    //       if (widget.fromCart == true) {
                    //         DBService().removeFromCar();
                    //       }
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //           const SnackBar(
                    //               content: Text("Order Successful")));
                    //     });
                    //   }
                    //   log("Error");
                    });
                    // log("out");
                  },
                  leading: Image.memory(snapshot.data![index].icon),
                  title: Text(
                    snapshot.data![index].name,
                    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                );
              },
            );
          },
        );
  }
}