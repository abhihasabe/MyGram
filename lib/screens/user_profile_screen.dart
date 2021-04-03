import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mygram_app/models/profile_model.dart';
import 'package:mygram_app/models/user_profile_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/network/network.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:picker/picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dashboard/tabs_screen.dart';

class UserProfile extends StatefulWidget{
  bool value;
  UserProfile({this.value});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserProfile(value:value);
  }

}

class _UserProfile extends State with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  File _image;
  TextEditingController fNamecontroller = TextEditingController();
  TextEditingController mNamecontroller = TextEditingController();
  TextEditingController lNamecontroller = TextEditingController();
  TextEditingController pNocontroller = TextEditingController();
  TextEditingController emailIdcontroller = TextEditingController();
  TextEditingController professioncontroller = TextEditingController();
  TextEditingController bloodGroupcontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  TextEditingController villagecontroller = TextEditingController();
  TextEditingController address1controller = TextEditingController();
  TextEditingController address2controller = TextEditingController();
  TextEditingController address3controller = TextEditingController();
  var _selectedItem;
  SharedPreferences prefs;
  bool value;
  UserProfileModel userProfileModelData;
  bool _status = false;
  String mobileNo, pinCode, villageName,token,id, userId, villageCode, uniqueId, role, status;

  _UserProfile({this.value});

  Future getImage() async {
    final pickedFile = await Picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        /*_image = File(pickedFile.path);*/
      } else {
        print('कोणतीही प्रतिमा निवडलेली नाही');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharePre();
    if(value==true){
      setState(() {
        _status = true;
      });
      getUserProfile();
    }
  }

  void getUserProfile() {
    Network().check().then((intenet) async {
      if (intenet != null && intenet){
        Dialogs.showLoadingDialog(context);
        var serviceAndSpareJson = {"phoneNumber": prefs.getString('mobileNo')};
        var pincodeValidationJSON = APICall.postJsonData(Constant.PHONE_NO_API,serviceAndSpareJson);
        pincodeValidationJSON.then((value) => {
          userProfileModelData = UserProfileModel.fromJson(value),
          Navigator.of(context, rootNavigator: true).pop(),
          userProfileModelData?.user?.firstName!=null?fNamecontroller.text=userProfileModelData?.user?.firstName:"",
          userProfileModelData?.user?.middleName!=null?mNamecontroller.text=userProfileModelData?.user?.middleName:"",
          userProfileModelData?.user?.lastName!=null?lNamecontroller.text=userProfileModelData?.user?.lastName:"",
          userProfileModelData?.user?.phoneNumber!=null?pNocontroller.text=userProfileModelData?.user?.phoneNumber:"",
          userProfileModelData?.user?.email!=null?emailIdcontroller.text=userProfileModelData?.user?.email:"",
          userProfileModelData?.user?.profession!=null?professioncontroller.text=userProfileModelData?.user?.profession:"",
          userProfileModelData?.user?.bloodGroup!=null?bloodGroupcontroller.text=userProfileModelData?.user?.bloodGroup:"",
          userProfileModelData?.user?.pincode!=null?pincodecontroller.text=userProfileModelData?.user?.pincode:"",
          userProfileModelData?.user?.village!=null?villagecontroller.text=userProfileModelData?.user?.village:"",
          userProfileModelData?.user?.addressLine1!=null?address1controller.text=userProfileModelData?.user?.addressLine1:"",
          userProfileModelData?.user?.addressLine2!=null?address2controller.text=userProfileModelData?.user?.addressLine2:"",
          userProfileModelData?.user?.addressLine3!=null?address3controller.text=userProfileModelData?.user?.addressLine3:"",
        });
      }
    });
  }

  Future<void> sharePre() async {
    prefs = await SharedPreferences.getInstance();
    mobileNo = prefs.getString('mobileNo');
    pinCode = prefs.getString('pincode');
    villageName = prefs.getString('villageName');
    token = prefs.getString('token');
    userId = prefs.getString('userId');
    villageCode = prefs.getString('villageCode');
    uniqueId = prefs.getString('uniqueId');
    role = prefs.getString('role');
    status = prefs.getString('status');
    id = prefs.getString('id');
  }

  Future<bool> _onWillPop() async {
    if(value==true){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: new Container(
            color: Colors.white,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: 250.0,
                      color: Colors.white,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 20.0, top: 20.0),
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  IconButton(
                                    icon: new Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    onPressed:() {
                                      if(value==true){
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false);
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 25.0,top: 10.0),
                                    child: new Text('वापरकर्ता प्रोफाइल',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            fontFamily: 'sans-serif-light',
                                            color: Colors.black)))
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 35.0),
                            child: new Stack(fit: StackFit.loose, children: <Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Container(
                                      width: 140.0,
                                      height: 140.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                          image: _image==null?ExactAssetImage('assets/images/as.png'):FileImage(_image),
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 90.0, right: 100.0),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                      onTap: () {
                                        getImage();
                                      },
                                        child: new CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 25.0,
                                          child: new Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      color: Color(0xffFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 15.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'वैयक्तिक माहिती',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status ? _getEditIcon() : new Container(),
                                      ],
                                    )
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text('पहिले नाव *', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: fNamecontroller,
                                        decoration: const InputDecoration(hintText: "आपले प्रथम नाव प्रविष्ट करा",),
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                        enabled: !_status,
                                        autofocus: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text('मधले नाव *', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: mNamecontroller,
                                        decoration: const InputDecoration(
                                          hintText: "आपले मध्यम नाव प्रविष्ट करा",
                                        ),
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                        enabled: !_status,
                                        autofocus: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'आडनाव *',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: lNamecontroller,
                                        decoration: const InputDecoration(
                                          hintText: "आपले आडनाव प्रविष्ट करा",
                                        ),
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                        enabled: !_status,
                                        autofocus: !_status,

                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'लिंग *',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 25.0, right: 25.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: DropdownButton<String>(
                                  underline: Container(
                                    height: 1,
                                    color: Colors.black38,
                                  ),
                                  hint: Text("लिंग निवडा"),
                                  isExpanded: true,
                                  items: <String>['नर', 'स्त्री'].map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  value: _selectedItem,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedItem = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'रक्त गट',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: bloodGroupcontroller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला रक्त गट प्रविष्ट करा"),
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                        enabled: !_status,
                                      ),
                                    ),
                                  ],
                                )),
                            /*Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'फोन नंबर',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        controller: pNocontroller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला फोन नंबर प्रविष्ट करा"),
                                        enabled: !_status,
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                      ),
                                    ),
                                  ],
                                )),*/
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text('व्यवसाय', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: professioncontroller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला व्यवसाय प्रविष्ट करा"),
                                        enabled: !_status,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'ई - मेल आयडी *',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        controller: emailIdcontroller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला ईमेल आयडी प्रविष्ट करा"),
                                        enabled: !_status,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                      ),
                                    ),
                                  ],
                                )),
                            /*Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'पिन कोड',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'गाव',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextField(
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization.words,
                                          controller: pincodecontroller,
                                          decoration: const InputDecoration(
                                              hintText: "पिन कोड प्रविष्ट करा"),
                                          enabled: !_status,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () => node.nextFocus(),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: villagecontroller,
                                        decoration: const InputDecoration(
                                            hintText: "गाव नाव प्रविष्ट करा"),
                                        enabled: !_status,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),*/
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'पत्ता 1 *',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: address1controller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला पत्ता 1 प्रविष्ट करा"),
                                        enabled: !_status,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'पत्ता 2',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: address2controller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला पत्ता 2 प्रविष्ट करा"),
                                        enabled: !_status,
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () => node.nextFocus(),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'पत्ता 3',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        textCapitalization: TextCapitalization.words,
                                        controller: address3controller,
                                        decoration: const InputDecoration(
                                            hintText: "आपला पत्ता 3 प्रविष्ट करा"),
                                        enabled: !_status,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                  ],
                                )),
                            !_status ? _getActionButtons() : new Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("जतन करा"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        if(fNamecontroller.text.isEmpty){
                          Toast.show("कृपया प्रथम नाव प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }else if(mNamecontroller.text.isEmpty){
                          Toast.show("कृपया मिडल नाव प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }else if(lNamecontroller.text.isEmpty){
                          Toast.show("कृपया आडनाव प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }/*else if(pNocontroller.text.isEmpty){
                          Toast.show("कृपया फोन नंबर प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }else if(pincodecontroller.text.isEmpty){
                          Toast.show("कृपया पिन कोड प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }else if(villagecontroller.text.isEmpty){
                          Toast.show("कृपया गावचे नाव प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }*/else if(address1controller.text.isEmpty){
                          Toast.show("कृपया पत्ता प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }else if(_selectedItem==null){
                          Toast.show("कृपया लिंग प्रविष्ट करा", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                        }else{
                          addProfile();
                        }
                      }); 
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                    child: new Text("रद्द करा"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
  void addProfile () {

    Dialogs.showLoadingDialog(context);
    var profileDataJson = {
      "firstName": fNamecontroller.text,
      "middleName": mNamecontroller.text,
      "lastName": lNamecontroller.text,
      "phoneNumber": mobileNo,
      "gender": _selectedItem,
      "email": emailIdcontroller.text,
      "bloodGroup": bloodGroupcontroller.text,
      "pincode": pinCode,
      "profession": professioncontroller.text,
      "village": villageName,
      "addressLine1": address1controller.text,
      "addressLine2": address2controller.text,
      "addressLine3": address3controller.text,
      "photoURL": _image,
      "admin": false,
      "createdDate": "",
       value==true?"id": "":id,
      "role": role,
      "status": status,
      "token": token,
      "uniqueId": uniqueId!=null?uniqueId:"",
      "updatedDate": "",
      value==true?"userId":"": userId,
      "villageCode": villageCode!=null?villageCode:""
    };

    APICall.postJsonData(Constant.PROFILE_CREATE_API, profileDataJson).then((value) => {
          ProfileModel.fromJson(value)?.status?.contains("SUCCESS")?{
            prefs.setString("villageCode", "${ProfileModel.fromJson(value).user.villageCode}"),
            prefs.setString("userId", "${ProfileModel.fromJson(value).user.userId}"),
            prefs.setString("id", "${ProfileModel.fromJson(value).user.id}"),
            prefs.setString("uniqueId", "${ProfileModel.fromJson(value).user.id}"),
            prefs.setString("role", "${ProfileModel.fromJson(value).user.role}"),
            prefs.setString("status", "${ProfileModel.fromJson(value).user.status}"),
            Navigator.of(context, rootNavigator: true).pop(),
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (Route<dynamic> route) => false),
            Toast.show("प्रोफाइल यशस्वीरित्या जोडले", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER)
          }:{
            Navigator.of(context, rootNavigator: true).pop(),
            Toast.show("वापरकर्ता प्रोफाइल जोडण्यात अयशस्वी", context, duration: Toast.LENGTH_LONG, gravity: Toast.CENTER),
          }
    });
  }
  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}