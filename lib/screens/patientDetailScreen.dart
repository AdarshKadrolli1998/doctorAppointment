import 'package:doctor/common/MyColors.dart';
import 'package:doctor/screens/audiDemo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'audioDemo1.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  bool isSwitched = false;
  List<String> dictationType =[
    'Surgery',
    'Non-Surgery',
    'MRI',
    'Operative'
  ];
  String selectDictation = 'Surgery';
  String dropdownValue = 'One';
  String selectedItem = '1';
  final List<String> items = <String>['1', '2', '3'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Kevin Peterson"),
        backgroundColor: MyColors.themeColor,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 100,
                        height: 105,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                              height: 90,
                              width: 90,
                              child: Image.network(
                                  "https://cdn1.vectorstock.com/i/thumb-large/77/30/default-avatar-profile-icon-grey-photo-placeholder-vector-17317730.jpg")),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("02-12-2021",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("PC-MD"),
                          Text(
                            "Kevin Peterson\n(Male, 120)",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Dictation Completed"),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Start File"),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightBlue[100],
                      activeColor: Colors.blue,
                      inactiveThumbColor: MyColors.themeColor,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Card(
                              child: Container(
                                height: 500,
                                child: RecorderExample(),
                              ),
                            );
                          },
                        );
                        Alert(
                          context: context,
                          title: "Select a Dictation Type",
                          content: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromRGBO(92, 136, 217, 1),
                            ),
                            margin: EdgeInsets.only(top: 25),
                            width: 230,
                            child: DropdownButton<String>(
                              value: selectedItem,
                              onChanged: (String string) => setState(() => selectedItem = string),
                              selectedItemBuilder: (BuildContext context) {
                                return items.map<Widget>((String item) {
                                  return Text(item);
                                }).toList();
                              },
                              items: items.map((String item) {
                                return DropdownMenuItem<String>(
                                  child: Text('Log $item'),
                                  value: item,
                                );
                              }).toList(),
                            ),
                          ),
                          buttons: [
                            DialogButton(
                              color: Color.fromRGBO(230, 27, 35, 1),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: MyColors.themeColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp1(),),
                        );
                        // final action = CupertinoActionSheet(
                        //   actions: [
                        //     CupertinoActionSheetAction(
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.camera_alt, color: Colors.blue),
                        //           Container(
                        //               padding: EdgeInsets.only(left: 150),
                        //               child: Text("Camera")),
                        //         ],
                        //       ),
                        //       onPressed: () {
                        //         print("Camera clicked");
                        //       },
                        //     ),
                        //     CupertinoActionSheetAction(
                        //       child: Row(
                        //         children: [
                        //           Icon(Icons.photo, color: Colors.blue),
                        //           Container(
                        //               padding: EdgeInsets.only(left: 125),
                        //               child: Text("Photo Library")),
                        //         ],
                        //       ),
                        //       onPressed: () {
                        //         print("Photo Library clicked");
                        //       },
                        //     )
                        //   ],
                        //   cancelButton: CupertinoActionSheetAction(
                        //     child: Text("Cancel"),
                        //     onPressed: () {
                        //       Navigator.pop(context);
                        //     },
                        //   ),
                        // );
                        //
                        // showCupertinoModalPopup(
                        //     context: context, builder: (context) => action);
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: MyColors.themeColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text("Date of Birth"),
                          trailing: Text("02-17-1992"),
                        ),
                        ListTile(
                          leading: Text("Case No."),
                          trailing: Text("Y210243271_1"),
                        ),
                        ListTile(
                          leading: Text("PC-MO"),
                          trailing: Text("Checked out"),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: Color.fromRGBO(237, 243, 245, 1),
                  child: ListTile(
                    leading: Icon(
                      Icons.file_copy,
                      color: MyColors.themeColor,
                      size: 40,
                    ),
                    title: Text(
                      "Super Bill",
                      style: TextStyle(
                          color: MyColors.themeColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  color: Color.fromRGBO(237, 243, 245, 1),
                  child: ListTile(
                    leading: Icon(
                      Icons.file_copy,
                      color: MyColors.themeColor,
                      size: 40,
                    ),
                    title: Text(
                      "Super Bill",
                      style: TextStyle(
                          color: MyColors.themeColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(237, 243, 245, 1),
                  child: ListTile(
                    leading: Icon(
                      Icons.file_copy,
                      color: MyColors.themeColor,
                      size: 40,
                    ),
                    title: Text(
                      "Super Bill",
                      style: TextStyle(
                          color: MyColors.themeColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
