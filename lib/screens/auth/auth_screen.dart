
import 'package:flutter/material.dart';
import 'package:mygram_app/screens/auth/pincode_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _mobilenocontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'फोन प्रमाणीकरण',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.green[900]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 22, left: 22),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    if(text.length==10){
                      FocusScope.of(context).requestFocus(new FocusNode());
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'फोन नंबर',
                  prefix: Padding(
                    padding: EdgeInsets.all(4),
                    child: Text('+91'),
                  ),
                ),
                keyboardType: TextInputType.number,
                controller: _mobilenocontroller,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: FlatButton(
                color: Colors.green[900],
                onPressed: () {
                  _mobilenocontroller.text.isEmpty?{
                    Toast.show("कृपया मोबाइल नंबर प्रविष्ट करा", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER)
                  }:{
                    addStringToSF(),
                    /*Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => PinCode()),
                            (Route<dynamic> route) => false)*/
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(_mobilenocontroller.text)))
                  };
                  /*Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OTPScreen(_controller.text)));*/
                },
                child: Text(
                  'प्रस्तुत करणे',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }

  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobileNo', _mobilenocontroller.text);
  }
}