import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mygram_app/screens/dashboard/sales_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/auth_screen.dart';
import '../user_profile_screen.dart';
import 'emergency_screen.dart';
import 'help_screen.dart';
import 'krushi_screen.dart';
import 'my_gram_screen.dart';
import 'mygram_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedIndex = 0;
  SharedPreferences prefs;
  List<Widget> list = [
    Tab(text: 'मुख्यपृष्ठ'),
    Tab(text: 'मदत'),
    Tab(text: 'विक्री'),
    Tab(text: 'कृषी'),
    Tab(text: 'आणीबाणी'),
    Tab(text: 'माझे ग्राम'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);
    sharePre();
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green[900],
        //Changing this will change the color of the TabBar
        accentColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.green[300],
          bottom: TabBar(
            isScrollable: true,
            onTap: (index) {},
            controller: _controller,
            tabs: list,
          ),
          title: Text('MyGram'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right:4),
              child: InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => UserProfile(value: true)), (
                      Route<dynamic> route) => false);
                },
                child: Image(
                  image: AssetImage("assets/images/as.png"),
                  width: 27,
                  height: 27,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 14),
              child: IconButton(icon: Icon(Icons.login), onPressed: () {
                _onWillPop();
              }),
            ),
          ],
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            MyGram(),
            Help(),
            Sales(),
            Krushi(),
            Emergency(),
            MyGrams()
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: ()  {
              prefs.clear();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (Route<dynamic> route) => false);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }
}