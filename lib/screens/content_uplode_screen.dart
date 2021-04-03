
import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mygram_app/models/post_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';
import 'dashboard/tabs_screen.dart';

class ContentUplode extends StatefulWidget{
  File sourceURL;
  String contentType;

  ContentUplode({this.sourceURL, this.contentType});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContentUplode(url:sourceURL, contentType:contentType);
  }
}

class _ContentUplode extends State {

  TextEditingController _postcontroller = TextEditingController();
  static bool showHelpBGColor= true;
  static bool showSaleBGColor= false;
  static bool showFarmerBGColor= false;
  File url;
  String contentType, categoryName="Help";
  SharedPreferences prefs;
  var userId, villageCode;
  List<int> imageBytes;

  _ContentUplode({this.url, this.contentType});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePre();

    print("mediaURL - $url");
    if(url!=null){
      imageBytes = url.readAsBytesSync();

      print("mediaURL-base64 - ${base64Encode(imageBytes)}");
    }
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
    villageCode = prefs.getString("villageCode");
    userId = prefs.getString("userId");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
        },),
        title: Text("पोस्ट बनवा"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'पोस्ट लिहा',border: InputBorder.none),
                  textCapitalization: TextCapitalization.words,
                  controller: _postcontroller,
                ),
                SizedBox(height: 25,),
                url != null && contentType.contains("image")?
                Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), child: Container(height: 65,width: 80,
                    child: Image.file(url, height: 65,width: 80,))) :url != null && contentType.contains("video")?
                    Container(
                  height: 65,
                  child: Chewie(
                    controller: ChewieController(
                      videoPlayerController: VideoPlayerController.asset('$url'),
                      autoPlay: true,
                      looping: true,
                      errorBuilder: (context, errorMessage) {
                        return Center(
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ):Container(),
              ],
            ),
          ),
        ),
          Divider(thickness: 1,color: Colors.black38,),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("पोस्ट श्रेणी निवडा", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
        ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left:18.0, right: 18),
            child: Container(
              width: double.infinity,
              height: 40.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(child: Container(width: 60.0,color:showHelpBGColor==true?Colors.green[900]:Colors.white, child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("मदत", style: TextStyle(color:showHelpBGColor==true?Colors.white:Colors.green[900])),
                  ))), onTap: (){
                    setState(() {
                      categoryName="Help";
                      showHelpBGColor= true;
                      showSaleBGColor= false;
                      showFarmerBGColor= false;
                    });},),
                  InkWell(child: Container(width: 60.0, color:showSaleBGColor==true?Colors.green[900]:Colors.white, child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("विक्री", style: TextStyle(color:showSaleBGColor==true?Colors.white:Colors.green[900])),
                  ))), onTap: (){
                    setState(() {
                      categoryName="Sale";
                      showHelpBGColor= false;
                      showSaleBGColor= true;
                      showFarmerBGColor= false;
                    });}),
                  InkWell(child: Container(width: 60.0, color:showFarmerBGColor==true?Colors.green[900]:Colors.white, child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("कृषी", style: TextStyle(color:showFarmerBGColor==true?Colors.white:Colors.green[900])),
                  ))),onTap: (){
                    setState(() {
                      categoryName="Agri";
                      showHelpBGColor= false;
                      showSaleBGColor= false;
                      showFarmerBGColor= true;
                    });
                  }),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right:18.0),
              child: FlatButton(
                color: Colors.green[900],
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text('Post', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                onPressed: (){
                  addPost();
                },
              ),
            ),
          ),
      ],),
    );
  }

  void addPost() {
    Dialogs.showLoadingDialog(context);
    var profileDataJson = {
      "alertId": "",
      "category": categoryName,
      "createdDate": "",
      "description": "",
      "mediaURL": imageBytes!=null?base64Encode(imageBytes):"",
      "photoURL": "",
      "status": "",
      "title": _postcontroller.text,
      "updatedDate": "",
      "userId": userId,
      "villageCode": villageCode
    };
    APICall.postJsonData(Constant.CREATE_POST_API, profileDataJson).then((value) {
      PostModel.fromJson(value).status.contains("SUCCESS")?{
        Navigator.of(context, rootNavigator: true).pop(),
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false)
      }:{
        Navigator.of(context, rootNavigator: true).pop(),
        Toast.show("Failed to create Post", context,duration: Toast.LENGTH_LONG, gravity: Toast.CENTER),
      };
    });
  }
}