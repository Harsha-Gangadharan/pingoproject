import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/cartpaymentmethod.dart';
import 'package:flutter_application_1/User/paymentpage.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpoPayment extends StatefulWidget {
  final Map<String, dynamic> expo;

  const ExpoPayment({Key? key, required this.expo}) : super(key: key);

  @override
  State<ExpoPayment> createState() => _ExpoPaymentState();
}

class _ExpoPaymentState extends State<ExpoPayment> {
  List<bool> isSelected = [false, false, false, false, false, false];
  List<int> voteCount = [0, 0, 0, 0, 0, 0];
  late List<bool> isLikedList;
  int index = 0;
  
  get g => null;
   int selectedOption = 0;
   
    

  @override
  void initState() {
    super.initState();
    isLikedList = List.generate(10, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: const Color.fromARGB(255, 212, 94, 133),
        title: Text(
          "EXPO PAY",
          style: GoogleFonts.aclonica(
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(widget.expo['title']),
            SizedBox(height: 10), // Adjust spacing
            Text(
              'Arts that is added in this topic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
          
            

            // Container for the middle section
            const SizedBox(height: 16.0),
            Text('66 art works'),
            const SizedBox(height: 2.0),
            SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*.2,
             child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
               stream:  FirebaseFirestore.instance.collection('expo').doc(widget.expo["expoId"]).collection("Participants").snapshots(),
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
                      Divider(),
                      const SizedBox(height: 25),
              PaymentOption(
                title: "Winner upi number",
                selected: selectedOption == 2,
                onTap: () {
                  setState(() {
                    selectedOption=2;
                  });
                },
              ),
          SizedBox(height: 20,),
          PaymentOption(
                      title: "Wallet/UPI",
                      selected: selectedOption == 0,
                      onTap: () {

                      
// log(widget.totalPay.toString());
                        showModalBottomSheet(

                     
                          showDragHandle: true,
                          context: context, builder: (context) =>ShowPaymentoptions(totalAMount:double.parse(widget.expo["Price"],) ,page: "Admin",selectedOption: 0,),
                          );
                    
                      },
                    ),
          ],
          
        ),
      ),
    );
  }

   Widget buildIconButton(int buttonIndex,List vote,docId) {
    return Row(
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                // likeExpo(docId,vote);
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
                
                    
                     Icons.thumb_up_alt_outlined,
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
