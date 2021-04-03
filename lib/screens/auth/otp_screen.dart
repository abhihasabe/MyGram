import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygram_app/models/user_profile_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/network/network.dart';
import 'package:mygram_app/screens/auth/pincode_screen.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard/tabs_screen.dart';
import '../user_profile_screen.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  OTPScreen(this.phone);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  UserProfileModel userProfileModelData;
  SharedPreferences prefs;
  var mobileNo;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.green[900],
    ),
  );

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            /*if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PinCode()),
                      (route) => false);
            }*/

            if (value.user != null) {
              getUserProfile();
              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PinCode()), (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePre();
    _verifyPhone();
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
    mobileNo = prefs.getString('mobileNo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'सत्यापित करा +91-${widget.phone}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green[900]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      getUserProfile();
                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PinCode()), (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void getUserProfile() {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        Dialogs.showLoadingDialog(context);
        var serviceAndSpareJson = {"phoneNumber": mobileNo};
        var pincodeValidationJSON =
            APICall.postJsonData(Constant.PHONE_NO_API, serviceAndSpareJson);
        pincodeValidationJSON.then((value) => {
              userProfileModelData = UserProfileModel?.fromJson(value),
              if (userProfileModelData.user != null)
                {
                  prefs.setString("villageCode",
                      '${userProfileModelData.user.villageCode}'),
                  prefs.setString(
                      "villageName", '${userProfileModelData.user.village}'),
                  prefs.setString(
                      'pincode', "${userProfileModelData.user.pincode}"),
                  prefs.setString(
                      "userId", "${userProfileModelData.user.userId}"),
                  prefs.setString("id", "${userProfileModelData.user.id}"),
                  prefs.setString(
                      "uniqueId", "${userProfileModelData.user.uniqueId}"),
                  prefs.setString("role", "${userProfileModelData.user.role}"),
                  prefs.setString(
                      "status", "${userProfileModelData.user.status}"),
                  Navigator.of(context, rootNavigator: true).pop(),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false)
                }
              else
                {
                  Navigator.of(context, rootNavigator: true).pop(),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PinCode()),
                      (Route<dynamic> route) => false)
                }
            });
      }
    });
  }
}
