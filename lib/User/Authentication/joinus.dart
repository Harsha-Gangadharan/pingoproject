import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/User/Authentication/createprofile.dart';
import 'package:flutter_application_1/User/Authentication/getstart.dart';
import 'package:flutter_application_1/User/Authentication/worldofarts.dart';
import 'package:flutter_application_1/User/hompage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Joinus extends StatefulWidget {
  const Joinus({Key? key}) : super(key: key);
  // check(BuildContext context)async{
  //   SharedPreferences preferences=await SharedPreferences.getInstance();
  //   String? name=preferences.getString('is login');
  //   if(name!=null){
  //     Navigator.push(context,MaterialPageRoute(builder:(context)=>Home()));
  //   }else
  //   {
  //           Navigator.push(context,MaterialPageRoute(builder:(context)=>Getstart()));

  //   }
  // }

  @override
  State<Joinus> createState() => _JoinusState();
}

class _JoinusState extends State<Joinus> {
  final _formkey = GlobalKey<FormState>();
  final _UsernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _EmailIdController = TextEditingController();
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _auth = FirebaseAuth.instance;
bool obscure=true;
void toggile(){
  setState(() {
    obscure=!obscure;
  });
}
  String email = '';
  String password = '';
  Future addfirebase(
      Map<String, dynamic> registerreduserinfomap, String userid) async {
    return FirebaseFirestore.instance
        .collection('useregisteration')
        .doc(userid)
        .set(registerreduserinfomap);
  }

  registration() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      preferences.setString('islogin', credential.user!.uid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration Success'),
        ),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Worldofarts()));
      //String registered_user_id=randomString(10);
      String uid = _auth.currentUser!.uid;
      Map<String, dynamic> registerinfomap = {
        "username": _UsernameController.text,
        "email": _EmailIdController.text,
        "password": _passwordController.text,
        "image":'',
        "bio": '',
        "id": uid,
      };
      await addfirebase(registerinfomap, uid);
      const SnackBar(content: Text('details added to firebase successfully'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Weak password'),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email already in use'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF04D6D),
      ),
      body: Stack(
        children: [
         Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage("asset/background.png"), // Replace with your image path
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5), // Change the opacity value here (0.5 for 50% opacity)
        BlendMode.dstATop, // Adjust the blend mode as needed
      ),
    ),
  ),
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,
),
SingleChildScrollView(
       
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               
                Center(
                  child: Text(
                    'JOIN US',
                    style: GoogleFonts.inknutAntiqua(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color:Colors.black
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _UsernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _EmailIdController,
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Email Id';
                    } else if (!_emailRegex.hasMatch(value)) {
                      return 'Please Enter a Valid Email Id';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(onPressed:(){
                      toggile();
                    },icon: Icon(obscure? Icons.visibility:Icons.visibility_off)),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            email = _EmailIdController.text;
                            password = _passwordController.text;
                          });
                          registration();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Invalid username, password, or EmailId'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xffF04D6D),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Center(
                    child: Text(
                      'or\ncontinue with',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: Image.asset("asset/google.png"),
                      ),
                     
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                  child: Center(
                    child: Text(
                      'Already have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 100.0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Getstart(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            const Color(0xffF04D6D),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
        ],
    ),
    );
  }
}
