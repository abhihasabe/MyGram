import 'package:flutter/material.dart';
import 'package:mygram_app/models/user_profile_model.dart';
import 'package:mygram_app/models/villages_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/network/network.dart';
import 'package:mygram_app/screens/dashboard/tabs_screen.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../user_profile_screen.dart';

class PinCode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PinCode();
  }
}

class _PinCode extends State{
  PostOffice selectedSource;
  bool vissible= false;
  TextEditingController _pincodecontroller = TextEditingController();
  List<PostOffice> data = List<PostOffice>();
  var textData, rest;
  List restState = List();
  List restSource = List();
  List<DropdownMenuItem<PostOffice>> _dropdownMenuSource;
  var mobileNo;
  UserProfileModel userProfileModelData;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStringValuesSF();
    sharePre();
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
  }

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
                  'गाव चे पिन कोड प्रविष्ट करा',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, color: Colors.green[900]),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40, right: 22, left: 22),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    textData = text;
                    if(text.length==6){
                      selectedSource= null;
                      FocusScope.of(context).requestFocus(new FocusNode());
                      getvillageName();
                    }
                  });
                },
                decoration: InputDecoration(hintText: 'पिन कोड'),
                keyboardType: TextInputType.number,
                controller: _pincodecontroller,
              ),
            ),
            Visibility(
              visible: vissible,
              child: _dropdownMenuSource!=null?
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  child: SearchableDropdown?.single(
                    items: _dropdownMenuSource,
                    value: selectedSource,
                    isCaseSensitiveSearch: false,
                    displayClearIcon: false,
                    searchHint: "गाव नाव निवडा *",
                    label: Text("गाव नाव निवडा*", style: TextStyle(color: Colors.black54)),
                    onChanged: onChangeDropdownModelItem,
                    underline: Container(
                      height: 1.0,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black38,
                                  width: 1.0))),
                    ),
                    isExpanded: true,
                  ),
                ),
              ):Container(),
            ),
            Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: FlatButton(
                color: Colors.green[900],
                onPressed: () {
                  if(_pincodecontroller.text.isEmpty){
                    Toast.show("कृपया पिन कोड प्रविष्ट करा", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                  }else if(selectedSource==null){
                    Toast.show("कृपया गावचे नाव निवडा", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                  }else{
                    prefs.setString("pincode", _pincodecontroller.text);
                    prefs.setString("villageName", selectedSource.name);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => UserProfile(value: false,)), (Route<dynamic> route) => false);
                    //getUserProfile();
                  }
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

  void getvillageName() {
    Network().check().then((intenet) async {
      if (intenet != null && intenet){
        Dialogs.showLoadingDialog(context);
        var villageNameJSON = APICall.getJsonData(Constant.VILLAGENAMEBYPINCODE,_pincodecontroller.text );
        villageNameJSON.then((value) => {
          if(VillageName.fromJson(value).status.contains("Success")){
            restSource = (value['PostOffice']) as List,
            this.setState(() {
              vissible = true;
              data = restSource.map<PostOffice>((json) => PostOffice.fromJson(json)).toList();
              if(data!= null)
                _dropdownMenuSource = buildDropdownSource(data);
            }),
            Navigator.of(context, rootNavigator: true).pop(),
          }else{
            this.setState(() {
              vissible = false;
            }),
            Navigator.of(context, rootNavigator: true).pop(),
            Toast.show("कृपया वैध पिन कोड प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER)
          }
        });
      }else{
        Toast.show("कृपया इंटरनेट कनेक्शन तपासा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    });
  }

  static List<DropdownMenuItem<PostOffice>> buildDropdownSource(List<PostOffice> data) {
    List<DropdownMenuItem<PostOffice>> items = List();
    for (PostOffice project in data) {
      items.add(
        DropdownMenuItem(
          value: project,
          child: Text(project.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownModelItem(PostOffice selectedVillage) {
    setState(() {
      if (selectedSource != null) {
        selectedSource = null;
      } else {
        selectedSource = selectedVillage;
      }
    });
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    mobileNo = prefs.getString('mobileNo');
  }
}