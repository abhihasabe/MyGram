import 'package:flutter/material.dart';
import 'package:mygram_app/models/post_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/screens/dashboard/tabs_screen.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Emergency extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Emergency();
  }

}

class _Emergency extends State {

  var userId, villageCode;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePre();
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
    villageCode = prefs.getString("villageCode");
    userId = prefs.getString("userId");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(child: Image.asset('assets/images/sos.jpeg', width: 100, height: 100), onTap: (){
          emergency();
        }),
        SizedBox(height: 15,),
        Text("आपत्कालीन सहाय्यासाठी एसओएस वर क्लिक करा", style: TextStyle(fontWeight: FontWeight.bold),)
      ],);
  }

  void emergency() {
    Dialogs.showLoadingDialog(context);
    var profileDataJson = {

      "alertId": "",
      "createdDate": "",
      "description": "",
      "mediaURL": "",
      "photoURL": "",
      "status": "",
      "category": "EMERGENCY",
      "title": "EMERGENCY",
      "updatedDate": "",
      "userId": userId,
      "villageCode": villageCode
    };
    APICall.postJsonData(Constant.CREATE_POST_API, profileDataJson).then((value) {
      PostModel.fromJson(value).status.contains("SUCCESS")?{
        Navigator.of(context, rootNavigator: true).pop(),
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false),
        Toast.show("Successfully Emergency Call Create", context,duration: Toast.LENGTH_LONG, gravity: Toast.CENTER),
      }:{
        Navigator.of(context, rootNavigator: true).pop(),
        Toast.show("Failed to create Emergency Call", context,duration: Toast.LENGTH_LONG, gravity: Toast.CENTER),
      };
    });
  }
}