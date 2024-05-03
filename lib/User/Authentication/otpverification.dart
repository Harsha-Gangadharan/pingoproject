import 'package:flutter/material.dart';
import 'package:flutter_application_1/User/Authentication/changepassword.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPVerificationPage extends StatefulWidget {
  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: SizedBox(
                  width: 200, 
                  height: 200, 
                  child: Image.asset("asset/otp.png"),
                ),
              ),
              const SizedBox(height: 20.0,),
              Center(
                child: Text(
                  'Verify Your Security Code',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 50,
                  height: 50,
                  child: TextField(
                    controller: controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.length == 1 && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  controllers.forEach((controller) {
                  });
                     Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePassword(),));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 195, 60, 105)),
                child: Text(
                  'Verify',
                  style: GoogleFonts.inknutAntiqua(color: Colors.white),
                ),
              ),
            ),
            Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OTPVerificationPage()),
                    );
                  },
                  child: Text(
                    'Resend Your Code!',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
    );
  }
}
