import 'dart:convert';

import 'package:doctor/common/MyColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class DoctorAppointment extends StatefulWidget {
  @override
  _DoctorAppointmentState createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  DatePickerController _controller = DatePickerController();
  DateTime _selectedValue = DateTime.now();

  final String url = "assets/doctorAppointment.json";
  List<dynamic> allData = [];
  List<dynamic> appointmentData = [];
  Map<String, dynamic> appointment;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    this.getjsondata();
  }

  Future<String> getjsondata() async {
    String jsonData = await DefaultAssetBundle.of(context)
        .loadString("assets/doctorAppointment.json");
    final List<dynamic> jsonResult = json.decode(jsonData);

    allData = jsonResult;
    appointmentData = allData;
    setState(() {});
  }

  getSelectedDateAppointments() {
    // for (var i = 0; i < appointmentData.length; i++) {
    //   Map<String, dynamic> appItem = appointmentData[i].toList();
    //   if (appItem['date'] == _selectedValue.toString()) {
    //     print(appItem);
    //   }
    // }
    appointmentData = allData.where((element) {
      Map<String, dynamic> appItem = element;
      return appItem['date'] == _selectedValue.toString();
    }).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Container(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: MyColors.themeColor,
          title: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  height: 35,
                  width: 35,
                  child: Image.network(
                      "https://image.freepik.com/free-vector/doctor-character-background_1270-84.jpg")),
            ),
            title: Text(
              "Welcome Dr. Scilaris",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.menu_open,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            //color: Colors.black,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.06,
                  color: MyColors.themeColor,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.03,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 4.0,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Container(
                            //margin: EdgeInsets.only(top: 0.0),
                            height: 56.0,
                            width: 320.0,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                ListTile(
                                  title: TextFormField(
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.only(bottom: 0),
                                        hintText: "Search Patients"),
                                  ),
                                  trailing: Container(
                                    child: Icon(
                                      Icons.search,
                                    ),
                                    padding: const EdgeInsets.only(bottom: 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: DatePicker(
                            DateTime.now(),
                            width: 50,
                            height: 80,
                            controller: _controller,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: MyColors.themeColor,
                            selectedTextColor: Colors.white,
                            onDateChange: (date) {
                              // New date selected

                              setState(() {
                                _selectedValue = date;
                                getSelectedDateAppointments();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      SafeArea(
                        bottom: false,
                        child: Stack(
                          children: <Widget>[
                            DraggableScrollableSheet(
                              maxChildSize: .7,
                              initialChildSize: .7,
                              // minChildSize: .6,
                              builder: (context, scrollController) {
                                return Container(
                                  height: 100,
                                  padding: EdgeInsets.only(
                                      left: 19,
                                      right: 19,
                                      top:
                                          16), //symmetric(horizontal: 19, vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30)),
                                    color: Colors.white,
                                  ),
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    controller: scrollController,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "HEMA 54-DEAN (4)",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            )
                                          ],
                                        ),
                                        appointmentData != null &&
                                                appointmentData.isNotEmpty
                                            ? ListView.separated(
                                                separatorBuilder:
                                                    (context, index) => Divider(
                                                  color: Colors.black,
                                                ),
                                                shrinkWrap: true,
                                                itemCount:
                                                    appointmentData.length,
                                                itemBuilder: (context, index) {
                                                  Map<String, dynamic> item =
                                                      appointmentData[index];
                                                  return ListTile(
                                                    contentPadding:
                                                        EdgeInsets.all(0),
                                                    leading: Icon(
                                                      Icons.bookmark,
                                                      color: MyColors.bookmarkColor,
                                                    ),
                                                    title:
                                                        Text(item["location"]),
                                                    subtitle: Text(
                                                        item["doctorName"] +
                                                            "\n" +
                                                            item["status"]),
                                                    trailing: Column(
                                                      children: [
                                                        Text(item[
                                                            "appointmentTime"]),
                                                        Spacer(),
                                                        RichText(
                                                          text: TextSpan(
                                                            text: '• ',
                                                            style: TextStyle(
                                                                color:
                                                                    MyColors.dictationColor,
                                                                fontSize: 14),
                                                            children: <
                                                                TextSpan>[
                                                              TextSpan(
                                                                text: 'Dictation ' +
                                                                    "" +
                                                                    "" +
                                                                    item[
                                                                        "status"],style: TextStyle(color: MyColors.dictationTextColor)
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(
                                                child: Text(
                                                "No Appointments",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey),
                                              )),
                                        Divider(
                                          thickness: .5,
                                          color: MyColors.dividerColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.themeColor,
          onPressed: () {},
          tooltip: 'Add',
          child: Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
