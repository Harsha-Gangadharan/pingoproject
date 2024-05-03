import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/Signup.dart';
import 'package:flutter_application_1/Admin/home.dart';
import 'package:flutter_application_1/Admin/login.dart';
import 'package:flutter_application_1/Admin/manageuser.dart';
import 'package:flutter_application_1/User/Authentication/createprofile.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:flutter_application_1/User/Authentication/joinus.dart';
import 'package:flutter_application_1/User/Editprofile.dart';
import 'package:flutter_application_1/User/Following.dart';
import 'package:flutter_application_1/User/addaddress.dart';
import 'package:flutter_application_1/User/addbankdetail.dart';
import 'package:flutter_application_1/User/addedsuccessfully.dart';
import 'package:flutter_application_1/User/artistconfirmation.dart';
import 'package:flutter_application_1/User/blockmessage.dart';
import 'package:flutter_application_1/User/buynowpage.dart';
import 'package:flutter_application_1/User/cancelorder.dart';
import 'package:flutter_application_1/User/cartpage.dart';
import 'package:flutter_application_1/User/cartpaymentmethod.dart';
import 'package:flutter_application_1/User/cartsummery.dart';
import 'package:flutter_application_1/User/chatscreen.dart';
import 'package:flutter_application_1/User/expopage.dart';
import 'package:flutter_application_1/User/expovote.dart';
import 'package:flutter_application_1/User/followerspage.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:flutter_application_1/User/message.dart';
import 'package:flutter_application_1/User/newpost.dart';
import 'package:flutter_application_1/User/notification.dart';
import 'package:flutter_application_1/User/order.dart';
import 'package:flutter_application_1/User/orderconfirmed.dart';
import 'package:flutter_application_1/User/orderdetails.dart';
import 'package:flutter_application_1/User/Authentication/otpverification.dart';
import 'package:flutter_application_1/User/paymentmethod.dart';
import 'package:flutter_application_1/User/proflie.dart';
import 'package:flutter_application_1/User/review.dart';
import 'package:flutter_application_1/User/search.dart';
import 'package:flutter_application_1/User/viewallreview.dart';
import 'package:flutter_application_1/User/Authentication/welcome.dart';
import 'package:flutter_application_1/User/wishlist.dart';
import 'package:flutter_application_1/User/Authentication/worldofarts.dart';
import 'package:flutter_application_1/User/yourorders.dart';
import 'package:flutter_application_1/bisiness_logic/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
Future<void> main() async {
// ...
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home: Chatscreen()
    );
    
  }
}
