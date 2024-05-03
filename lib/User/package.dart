import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/artistconfirmation.dart';
import 'package:flutter_application_1/User/cartpage.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/message.dart';
import 'package:flutter_application_1/User/order.dart';
import 'package:flutter_application_1/User/proflie.dart';
import 'package:flutter_application_1/User/search.dart';


class packages extends StatefulWidget {
   int indexnum=0;
   packages({super.key,required this.indexnum});

  @override
  State<packages> createState() => _packagesState();
}

class _packagesState extends State<packages> {
 final _pages=[
    
    const Home(),
     SearchPage(),
     ArtistConfirm(),
     OrderPage(),
    const ProfilePage(),
     
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
  body: _pages[widget.indexnum],
      bottomNavigationBar:mynav(
        index:widget.indexnum,
        onTap:(index){
        setState(() {
          widget.indexnum=index;
        });
      }
        )

    );
  }
}
Widget mynav({
  int? index,
  void Function(int)?onTap,
  selectedcolor,
})
{
  return BottomNavigationBar(
    showUnselectedLabels: true,
    currentIndex: index!,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.white,
    showSelectedLabels: true,
    onTap: onTap ,
    items: const [
      BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home, color: Color.fromARGB(255, 12, 12, 12)),
          ),
     BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search, color: Color.fromARGB(255, 12, 12, 12)),
          ),
          BottomNavigationBarItem(
            label: "Upload",
            icon: Icon(Icons.add_box, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: "Order",
            icon: Icon(Icons.card_giftcard,
                color: Color.fromARGB(255, 12, 12, 12)),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle,
                color: Color.fromARGB(255, 12, 12, 12)),
          ),
      
    ]);
    

}
      