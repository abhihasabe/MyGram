import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/screens/dashboard/tabs_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/auth_screen.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Splash();
  }
}

class _Splash extends State {
  SharedPreferences prefs;
  var userId,tokenStr;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin fltNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePre();
    notitficationPermission();
    initMessaging();
    try {
      Timer(Duration(seconds: 8), () => getStringValuesSF());
    } catch (e) {
      print(e);
    }
  }

  void notitficationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  void initMessaging() {
    var androiInit = AndroidInitializationSettings('noti');

    var iosInit = IOSInitializationSettings();

    var initSetting = InitializationSettings(androiInit, iosInit);

    fltNotification = FlutterLocalNotificationsPlugin();

    fltNotification.initialize(initSetting);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification();
    });
  }

  void showNotification() async {
    var androidDetails = AndroidNotificationDetails('1', 'channelName', 'channel Description');

    var iosDetails = IOSNotificationDetails();

    var generalNotificationDetails = NotificationDetails(androidDetails, iosDetails);

    await fltNotification.show(0, 'title', 'body', generalNotificationDetails, payload: 'Notification');
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    _firebaseMessaging.getToken().then((token) {
      tokenStr = token.toString();
      // do whatever you want with the token here
      prefs.setString("token", tokenStr);
      var profileDataJson = {
        "token": tokenStr,
        "userId": userId
      };
      print("userId: $profileDataJson");
      APICall.postJsonData(Constant.UPDATE_TOKEN_API, profileDataJson).then((value) => {
        getStringValuesSF()
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.green[900],
        body: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset.center,
              child: Image(
                image: AssetImage("assets/images/as.png"),
                width: 90,
                height: 90,
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "MyGram",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ));
  }

  Future navigateToLoginPage(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  Future navigateToDashbordPage(context) async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
  }

  getStringValuesSF() async {
    if (prefs.getString("villageCode") != null) {
      if (mounted)
      navigateToDashbordPage(context);
    } else {
      navigateToLoginPage(context);
    }
  }
}
