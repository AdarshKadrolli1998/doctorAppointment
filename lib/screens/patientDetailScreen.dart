import 'package:doctor/common/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientDetails extends StatefulWidget {
  @override
  _PatientDetailsState createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  bool isSwitched = false;
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
                          onChanged: (value){
                            setState(() {
                              isSwitched=value;
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
                          onPressed: () {  },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: MyColors.themeColor,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.mic,color: Colors.white,size: 40,),
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () { final action = CupertinoActionSheet(
                            actions: [
                              CupertinoActionSheetAction(
                                child: Row(
                                  children: [
                                    Icon(Icons.camera_alt, color: Colors.blue),
                                    Container(
                                      padding: EdgeInsets.only(left: 150),
                                        child: Text("Camera"
                                        )
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  print("Camera clicked");
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Row(
                                  children: [
                                     Icon(Icons.photo,
                                       color: Colors.blue),
                                    Container(
                                        padding: EdgeInsets.only(left: 125),
                                        child: Text("Photo Library")),
                                  ],
                                ),
                                onPressed: () {
                                  print("Photo Library clicked");
                                },
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          );

                          showCupertinoModalPopup(
                              context: context, builder: (context) => action); },
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: MyColors.themeColor,
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.camera_alt,color: Colors.white,size: 40,),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15,bottom: 15),
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
                          leading: Icon(Icons.file_copy,color: MyColors.themeColor,size: 40,),
                          title: Text("Super Bill",style: TextStyle(color: MyColors.themeColor,fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      color: Color.fromRGBO(237, 243, 245, 1),
                      child: ListTile(
                        leading: Icon(Icons.file_copy,color: MyColors.themeColor,size: 40,),
                        title: Text("Super Bill",style: TextStyle(color: MyColors.themeColor,fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Container(
                      color: Color.fromRGBO(237, 243, 245, 1),
                      child: ListTile(
                        leading: Icon(Icons.file_copy,color: MyColors.themeColor,size: 40,),
                        title: Text("Super Bill",style: TextStyle(color: MyColors.themeColor,fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
// CupertinoActionSheet()