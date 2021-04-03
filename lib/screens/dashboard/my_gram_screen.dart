import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mygram_app/models/gram_model.dart';
import 'package:mygram_app/network/Constant.dart';
import 'package:mygram_app/network/apicall.dart';
import 'package:mygram_app/network/network.dart';
import 'package:mygram_app/utils/Dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGrams extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyGrams();
  }
}

class _MyGrams extends State {
  SharedPreferences prefs;
  GramModel gramModel;
  List dealerListPodo = List();
  List<GovtRepresentativeList> dealerDataList = List<GovtRepresentativeList>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getGram();
  }

  void getGram() {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        prefs = await SharedPreferences.getInstance();
        Dialogs.showLoadingDialog(context);
        var gramJSON = APICall.getJsonData1(
            Constant.GET_GRAM_API, prefs.getString("villageCode"));
        gramJSON.then((value) => {
          GramModel.fromJson(value).status.contains("SUCCESS")
                  ? {
                      setState(() {
                        dealerDataList = GramModel.fromJson(value).mainGramPanchayat.govtRepresentativeList.toList();
                        /*dealerDataList = GramModel.fromJson(value).mainGramPanchayat.govtRepresentativeList.map<GovtRepresentativeList>((json) => GovtRepresentativeList.fromJson(json))
                            .toList();*/
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
    // TODO: implement build
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(children: [
          ExpandablePanel(
            theme: const ExpandableThemeData(
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              tapBodyToExpand: true,
              tapBodyToCollapse: true,
              hasIcon: false,
            ),
            header: Container(
              color: Colors.red[700],
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  children: [
                    ExpandableIcon(
                      theme: const ExpandableThemeData(
                        expandIcon: Icons.arrow_right,
                        collapseIcon: Icons.arrow_drop_down,
                        iconColor: Colors.white,
                        iconSize: 28.0,
                        iconPadding: EdgeInsets.only(right: 5),
                        hasIcon: false,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                        child: Text(
                          "Gram Panchayat",
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expanded: dealerDataList != null ? gramPanchayat() : "",
          )
        ]),
      ),
    );
  }

  gramPanchayat() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: dealerDataList.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Row(
                children: [
                  Text('Name : '),
                  Text('${dealerDataList[index].name}'),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Department : '),
                  Text('${dealerDataList[index].department}'),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Phone Number : '),
                  Text('${dealerDataList[index].phoneNumber}'),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Text('Role : '),
                  Text('${dealerDataList[index].role}'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
