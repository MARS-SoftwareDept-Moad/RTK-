import 'package:docking/docking.dart';
import 'package:flutter/material.dart';

import '../../map/map_view.dart';

void main() {
  runApp(Send_Screen());
}

class Send_Screen extends StatefulWidget {
  @override
  _Send_ScreenState createState() => _Send_ScreenState();
}

class _Send_ScreenState extends State<Send_Screen> {
  late Column _layout;
  String selectedMode = "Disabled";
  List<String> Modes_list = ["Disabled", "Survey-in ", "Fixed"];
  List<String> BuadRates_list = ["9600", "19200", "38400", "57600", "115200"];
  String selectedBuadRate = "38400";
  String selectedTimeSource = "0: UTC time";
  List<String> TimeSource_list = [
    "0: UTC time",
    "1: GPS time",
    "2: GLONASS time",
    "3: BeiDou time",
    "4: Galileo time"
  ];
  static const Color backgroundColor = Color(0xFFeaf6f5);
  @override
  void initState() {
    super.initState();

    _layout = Column(children: [
      Container(
          height: 200,
          // width: 600,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 1,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: ((context, index) {
                return AbsorbPointer(
                    // absorbing: _connectionService.isBaseStationDisable!,
                    child: Container(
                        height: 200,
                        // physics: const NeverScrollableScrollPhysics(),

                        // physics: const NeverScrollableScrollPhysics(),
                        // // shrinkWrap: true,
                        // primary: false,
                        //  padding: const EdgeInsets.all(6.0),
                        child: Column(children: <Widget>[
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  "Mode:",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 25), // give it width

                              Flexible(
                                  child: SizedBox(
                                width: 100,
                                height: 20,
                                child: DropdownButton(
                                  menuMaxHeight: 150,
                                  isDense: true,
                                  isExpanded: true,
                                  value: selectedMode,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items:
                                      Modes_list.map<DropdownMenuItem<String>>(
                                          (var value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: false,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                        heightFactor: 3,
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   selectedMode = newValue.toString();
                                    // });
                                    // _connectionService.Modes_listChanged(
                                    //     selectedMode);
                                  },
                                ),
                              )),
                              SizedBox(height: 5)
                            ],
                          ),
                          Container(
                            height: 150,
                            margin: const EdgeInsets.fromLTRB(8, 20, 5, 0),
                            padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text("Minimum Observation Time:"),
                                    ),
                                    SizedBox(width: 60),
                                    Flexible(
                                      child: SizedBox(
                                        width: 130,
                                        height: 20,
                                        child: TextField(
                                          maxLines: 1,
                                          minLines: 1,
                                          onChanged: (value) {
                                            // Handle onChanged
                                          },
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: '0',
                                            contentPadding: EdgeInsets.all(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("  [s]"),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Flexible(
                                      child:
                                          Text("Required Position Accuracy:"),
                                    ),
                                    SizedBox(width: 65),
                                    Flexible(
                                      child: SizedBox(
                                        width: 130,
                                        height: 20,
                                        child: TextField(
                                          maxLines: 1,
                                          onChanged: (value) {
                                            // Handle onChanged
                                          },
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: '0.0',
                                            contentPadding: EdgeInsets.all(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("  [m]"),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                        "Survey-in end if BOTH conditions are met. "),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 8.0,
                            left: 30.0,
                            right: 0.0,
                            bottom: 8,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    transform: Matrix4.translationValues(
                                        15.0, -150.0, 0.0),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: backgroundColor,
                                    ),
                                    child: Text(
                                      'Survey-In',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ])));
              }))),
      SizedBox(
        height: 10,
      ),
      Container(
          height: 220,
          //  width: 600,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 1,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: ((context, index) {
                return AbsorbPointer(
                  // absorbing: _connectionService.isBaseStationDisable!,
                  child: ListView(
                    // physics: const NeverScrollableScrollPhysics(),
                    // // shrinkWrap: true,
                    // primary: false,
                    padding: const EdgeInsets.all(6.0),
                    children: <Widget>[
                      Container(
                        height: 204,
                        width: 120,
                        margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
                        padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: Column(children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: Text("Lat:"),
                              ),
                              SizedBox(width: 65), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      // controller: TextEditingController()
                                      //   ..text = XLat.toString(),
                                      // enabled: _connectionService
                                      //     .FixedPositionStutus,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        // XLat = double.parse(value);
                                      },
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [deg]"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: Text("Lon:"),
                              ),
                              SizedBox(width: 60), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      maxLines: 1,
                                      // controller: TextEditingController()
                                      //   ..text = YLon.toString(),

                                      // _connectionService
                                      //     .getConPackets
                                      //     .scu_SendPacket
                                      //     .Longitude
                                      //     .toString(),
                                      // enabled: _connectionService
                                      //     .FixedPositionStutus,
                                      onChanged: (value) {
                                        // YLon = double.parse(value);
                                      },
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0.0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [deg]")
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("Alt:"),
                              ),
                              SizedBox(width: 65), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      // controller: TextEditingController()
                                      //   ..text = ZAlt.toString(),

                                      // _connectionService
                                      //     .getConPackets
                                      //     .scu_SendPacket
                                      //     .Altitude
                                      //     .toString(),
                                      maxLines: 1,
                                      // enabled: _connectionService
                                      //     .FixedPositionStutus,
                                      onChanged: (value) {
                                        // _connectionService
                                        //     .getConPackets
                                        //     .scu_SendPacket
                                        //     .Altitude

                                        // ZAlt = double.parse(value);
                                      },
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0.0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [m]")
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("Accuracy:"),
                              ),
                              SizedBox(width: 25), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      maxLines: 1,
                                      // controller: TextEditingController()
                                      //   ..text = _connectionService
                                      //       .getConPackets
                                      //       .scu_SendPacket
                                      //       .FixedPosition3DAccuracy
                                      //       .toString(),
                                      // enabled: _connectionService
                                      //     .FixedPositionStutus,
                                      onChanged: (value) {
                                        // _connectionService
                                        //         .getConPackets
                                        //         .scu_SendPacket
                                        //         .FixedPosition3DAccuracy =
                                        //     double.parse(value);
                                      },
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0.0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [m]")
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                              // verticalDirection: VerticalDirection.up,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Text("Accuracy:"),

                                // SizedBox(width: 25), // give it width
                                SizedBox(
                                  width: 20,
                                  height: 50,

                                  // child: CheckboxWidget(callback: (value) {
                                  //   _connectionService.checkboxval = value;
                                  // }), //Checkbox,
                                ),

                                Text("Use Lat/ Lon/ Alt Position",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ))
                              ]),
                        ]),
                      ),
                      Positioned(
                          top: 8.0,
                          left: 30.0,
                          right: 0.0,
                          bottom: 8,
                          child: Row(children: <Widget>[
                            Flexible(
                                child: Container(
                              transform:
                                  Matrix4.translationValues(15.0, -210.0, 0.0),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50.0,
                              ),
                              decoration: new BoxDecoration(
                                color: backgroundColor,
                              ),
                              child: Text(
                                'Fixed Positon',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ])),
                    ],
                  ),
                );
              }))),
      SizedBox(height: 10),
      Container(
          height: 300,
          //  width: 600,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.0,
                crossAxisCount: 1,
                crossAxisSpacing: 1.0,
                mainAxisSpacing: 1.0,
              ),
              itemBuilder: ((context, index) {
                return Container(
                  child: ListView(
                    padding: const EdgeInsets.all(6.0),
                    children: <Widget>[
                      Container(
                        height: 240,
                        // width: 120,
                        margin: const EdgeInsets.fromLTRB(8, 20, 5, 0),
                        padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent)),
                        child: Column(children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Baud Rate:",
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 158), // give it width

                              Flexible(
                                  child: SizedBox(
                                width: 100,
                                height: 20,
                                child: DropdownButton(
                                  menuMaxHeight: 150,
                                  isDense: true,
                                  isExpanded: true,
                                  value: selectedBuadRate,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: BuadRates_list.map<
                                      DropdownMenuItem<String>>((var value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: false,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                        heightFactor: 3,
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   selectedBuadRate =
                                    //       newValue.toString();
                                    // });
                                    // _connectionService
                                    //     .BuadRates_listChanged(
                                    //         selectedBuadRate);
                                  },

                                  //onChanged: presenter.AP_Version_SelectionChanged(),
                                ),
                              )),
                              SizedBox(height: 5)
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "Time Source:",
                                  softWrap: false,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(width: 145), // give it width

                              Flexible(
                                  child: SizedBox(
                                width: 100,
                                height: 20,
                                child: DropdownButton(
                                  menuMaxHeight: 150,
                                  isDense: true,
                                  isExpanded: true,
                                  value: selectedTimeSource,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: TimeSource_list.map<
                                      DropdownMenuItem<String>>((var value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                          softWrap: false,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                        ),
                                        heightFactor: 3,
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (newValue) {
                                    // setState(() {
                                    //   selectedTimeSource =
                                    //       newValue.toString();
                                    // });
                                    // _connectionService
                                    //     .selectedTimeSourceChanged(
                                    //         selectedBuadRate);
                                  },

                                  //onChanged: presenter.AP_Version_SelectionChanged(),
                                ),
                              )),

                              SizedBox(height: 5)
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("Measurements Period:"),
                              ),
                              SizedBox(width: 65), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      maxLines: 1,
                                      // controller: TextEditingController()
                                      //   ..text = MeasurementsPeriod,
                                      onChanged: (value) {
                                        // if (!_connectionService
                                        //     .isBaseStationDisable!) {
                                        //   _connectionService
                                        //           .getConPackets
                                        //           .scu_SendPacket
                                        //           .MeasurementPeriodOfBS =
                                        //       double.parse(value);
                                        // }
                                        // if (!_connectionService
                                        //     .isRvoverDisable!) {
                                        //   _connectionService
                                        //           .getConPackets
                                        //           .scu_SendPacket
                                        //           .MeasurementPeriodRover =
                                        //       double.parse(value);
                                        // }
                                        // MeasurementsPeriod = value;
                                      },
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [ms]"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("Measurements Frequency:"),
                              ),
                              SizedBox(width: 37), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      enabled: false,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0.0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [Hz]")
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("Navigation Rate:"),
                              ),
                              SizedBox(width: 105), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      // controller: TextEditingController()
                                      //   ..text = NavigationRate,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        // if (!_connectionService
                                        //     .isBaseStationDisable!)
                                        //   _connectionService
                                        //           .getConPackets
                                        //           .scu_SendPacket
                                        //           .NavigationRateOfBS =
                                        //       double.parse(value);
                                        // if (!_connectionService
                                        //     .isRvoverDisable!)
                                        //   _connectionService
                                        //           .getConPackets
                                        //           .scu_SendPacket
                                        //           .NavigationRateRover =
                                        //       double.parse(value);

                                        // NavigationRate = value;
                                      },
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0.0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [cyc]")
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            // verticalDirection: VerticalDirection.up,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text("Navigation Frequency:"),
                              ),
                              SizedBox(width: 65), // give it width
                              Flexible(
                                child: SizedBox(
                                    width: 130,
                                    height: 20,
                                    child: TextField(
                                      maxLines: 1,
                                      enabled: false,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '0.0',
                                        contentPadding: EdgeInsets.all(8),
                                      ),
                                    )),
                              ),
                              Text("  [Hz]")
                            ],
                          ),
                          SizedBox(height: 10),
                        ]),
                      ),
                      Positioned(
                          top: 8.0,
                          left: 30.0,
                          right: 0.0,
                          bottom: 8,
                          child: Row(children: <Widget>[
                            Flexible(
                                child: Container(
                              transform:
                                  Matrix4.translationValues(15.0, -250.0, 0.0),
                              padding: EdgeInsets.symmetric(
                                horizontal: 50.0,
                              ),
                              decoration: new BoxDecoration(
                                color: backgroundColor,
                              ),
                              child: Text(
                                'Navigation Frequency',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ])),
                    ],
                  ),
                );
              }))),
    ]);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: TabbedViewTheme(
          data: TabbedViewThemeData.classic(),
          child: SingleChildScrollView(
            child: Container(
              child: _layout,
              padding: EdgeInsets.all(1),
            ),
          ),
        ),
      );
}
