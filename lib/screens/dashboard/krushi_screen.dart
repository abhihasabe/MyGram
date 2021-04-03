import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mygram_app/models/post_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/network/network.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:mygram_app/widget/post_card.dart';
import 'package:picker/picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../content_uplode_screen.dart';

class Krushi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Krushi();
  }
}

class _Krushi extends State {
  SharedPreferences prefs;
  File url;
  List dealerListPodo = List();
  List<AlertWithUsers> dealerDataList = List<AlertWithUsers>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePre();
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("villageCode") != null) getMyGramData();
  }

  void getMyGramData() {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        Dialogs.showLoadingDialog(context);
        var serviceAndSpareJson = {
          "villageCode": prefs.getString("villageCode")
        };
        var postJSON = APICall.postJsonData(Constant.POST_API, serviceAndSpareJson);
        postJSON.then((value) => {
          PostModel.fromJson(value).status.contains("SUCCESS")
              ? {
            dealerListPodo = (value['alertWithUsers']) as List,
            setState(() {
              if (dealerListPodo != null) {
                dealerDataList = dealerListPodo
                    .map<AlertWithUsers>(
                        (json) => AlertWithUsers.fromJson(json))
                    .toList();
              }
            }),
            Navigator.of(context, rootNavigator: true).pop(),
          }
              : {
            Navigator.of(context, rootNavigator: true).pop(),
          },
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: dealerDataList!=null? ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(4.0),
          children: List.generate(dealerDataList.length, (index) {
            return Center(child: dealerDataList[index].alert.category=="Agri"?PostCard(choice: dealerDataList[index], item: dealerDataList[index]):Container());
          })):Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[900],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 180,
                  child: Column(
                    children: [
                      Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "अपलोड करा",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 4.0, right: 4.0, top: 16, bottom: 16),
                              child: Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ContentUplode()),
                                              (Route<dynamic> route) => true);
                                    },
                                    color: Colors.blue[100],
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.format_quote,
                                      size: 24,
                                      color: Colors.blue,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Text(
                                        "पोस्ट",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Center(
                                              child:
                                              Text("प्रतिमा स्त्रोत")),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                FlatButton(
                                                  onPressed: () {
                                                    Dialogs.showLoadingDialog(context);
                                                    getImageFromCamera();
                                                  },
                                                  child: Text("कॅमेरा"),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Dialogs
                                                        .showLoadingDialog(
                                                        context);
                                                    getImageFromGallary();
                                                  },
                                                  child: Text("गॅलरी"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                                  },
                                  color: Colors.purple[100],
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                    color: Colors.purple,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Text(
                                      "कॅमेरा",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    return showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: Center(
                                              child:
                                              Text("व्हिडिओ स्त्रोत")),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                FlatButton(
                                                  onPressed: () {
                                                    Dialogs
                                                        .showLoadingDialog(
                                                        context);
                                                    getVideoFromCamera();
                                                  },
                                                  child: Text("कॅमेरा"),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Dialogs
                                                        .showLoadingDialog(
                                                        context);
                                                    getVideoFromGallary();
                                                  },
                                                  child: Text("गॅलरी"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ));
                                  },
                                  color: Colors.red[100],
                                  textColor: Colors.white,
                                  child: Icon(
                                    Icons.upload_outlined,
                                    size: 24,
                                    color: Colors.red,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 2.0),
                                      child: Text(
                                        "व्हिडिओ",
                                        style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          /*Expanded(
                            child: Padding(
                              padding:
                              const EdgeInsets.only(top: 16, bottom: 16),
                              child: Column(
                                children: [
                                  MaterialButton(
                                    onPressed: () {},
                                    color: Colors.green[100],
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.audiotrack_outlined,
                                      size: 24,
                                      color: Colors.green,
                                    ),
                                    padding: EdgeInsets.all(16),
                                    shape: CircleBorder(),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 4.0),
                                        child: Text(
                                          "गाणी",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          )*/
                        ],
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  Future<void> getImageFromCamera() async {
    var pickedFile = await Picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 75);

    setState(() {
      if (pickedFile != null) {
        url = File(pickedFile.path);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContentUplode(sourceURL: url, contentType: "image")),
                (Route<dynamic> route) => true);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> getImageFromGallary() async {
    var pickedFile =
    await Picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        url = File(pickedFile.path);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContentUplode(sourceURL: url, contentType: "image")),
                (Route<dynamic> route) => true);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> getVideoFromCamera() async {
    var pickedFile = await Picker.pickVideo(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        url = File(pickedFile.path);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();


        /*AlbumSaver.saveToAlbum(filePath: url.path).then((value) async {
          String _dcimPath = await AlbumSaver.getDcimPath();
          print("_dcimPath $_dcimPath");
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ContentUplode(sourceURL: url, contentType: "video")),
                  (Route<dynamic> route) => true);
        });*/
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> getVideoFromGallary() async {
    var pickedFile = await Picker.pickVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        url = File(pickedFile.path);
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.of(context, rootNavigator: true).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContentUplode(sourceURL: url, contentType: "video")),
                (Route<dynamic> route) => true);
      } else {
        print('No image selected.');
      }
    });
  }
}