import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';

void main() {
  runApp(Results_Screen());
}

class Results_Screen extends StatefulWidget {
  @override
  _Results_ScreenState createState() => _Results_ScreenState();
}

class _Results_ScreenState extends State<Results_Screen> {
  //////////////////////////////not used /////////////////////////////////////////////
  // late Container _layout;
  // static const Color backgroundColor = Color(0xFFeaf6f5);
  //////////////////////////////not used /////////////////////////////////////////////

  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  @override
  void initState() {
    super.initState();

//////////////////////////////not used /////////////////////////////////////////////
    // _layout = Container(
    //   child: ListView(
    //     physics: const NeverScrollableScrollPhysics(),
    //     primary: false,
    //     padding: const EdgeInsets.all(6.0),
    //     children: <Widget>[
    //       Container(
    //         height: 310,
    //         width: 120,
    //         margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
    //         padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
    //         decoration:
    //             BoxDecoration(border: Border.all(color: Colors.blueAccent)),
    //         child: Column(children: [
    //           SizedBox(height: 10),
    //           Row(
    //             children: [
    //               Flexible(
    //                 child: Text("Time Of Week:"),
    //               ),
    //               SizedBox(width: 65), // give it width
    //               Flexible(
    //                   child: SizedBox(
    //                       width: 130,
    //                       height: 20,
    //                       child: TextField(
    //                         enabled: false,
    //                         maxLines: 1,
    //                         style: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         decoration: InputDecoration(
    //                           border: OutlineInputBorder(),
    //                           labelStyle: TextStyle(
    //                             fontSize: 10,
    //                             color: Colors.black,
    //                           ),
    //                           labelText: _connectionService.current_Packet.iTOW
    //                               .toString(),
    //                           contentPadding: EdgeInsets.all(8),
    //                         ),
    //                       ))),

    //               Text(" [s]"),
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             children: [
    //               Flexible(
    //                 child: Text("Status:"),
    //               ),
    //               SizedBox(width: 115), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       //  controller: _controller45,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable! &&
    //                                 _connectionService.current_Packet?.Active ==
    //                                     1 &&
    //                                 _connectionService.connection!.IsConnect)
    //                             ? "in progress"
    //                             : (_connectionService.isRoverDisable! &&
    //                                     _connectionService
    //                                             .current_Packet.Active ==
    //                                         0.0 &&
    //                                     _connectionService
    //                                         .connection!.IsConnect)
    //                                 ? "successfully"
    //                                 : "Not Started",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  ")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Mean Position Valid:"),
    //               ),
    //               SizedBox(width: 25), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       // controller: _controller44,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable! &&
    //                                 _connectionService
    //                                         .current_Packet.ValidityBit ==
    //                                     1)
    //                             ? "Yes"
    //                             : "No",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  ")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Observation Time:"),
    //               ),
    //               SizedBox(width: 40), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       //  controller: _controller33,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable!)
    //                             ? _connectionService.current_Packet.Duration
    //                                 .toString()
    //                             : "No",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  [s]")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Positions Used:"),
    //               ),
    //               SizedBox(width: 60), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       // controller: _controller41,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable!)
    //                             ? _connectionService.current_Packet.Observations
    //                                 .toString()
    //                             : "0",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  ")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Mean ECEF X:"),
    //               ),
    //               SizedBox(width: 72), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       //controller: _controller34,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable!)
    //                             ? _connectionService.current_Packet.Mean_X
    //                                 .toString()
    //                             : "0",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  [m]")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Mean ECEF Y:"),
    //               ),
    //               SizedBox(width: 72), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       // controller: _controller35,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable!)
    //                             ? _connectionService.current_Packet.Mean_Y
    //                                 .toString()
    //                             : "0",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  [m]")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Mean ECEF Z:"),
    //               ),
    //               SizedBox(width: 72), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       //  controller: _controller36,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable!)
    //                             ? _connectionService.current_Packet.Mean_Z
    //                                 .toString()
    //                             : "0",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  [m]")
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Row(
    //             // verticalDirection: VerticalDirection.up,
    //             // mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Flexible(
    //                 child: Text("Mean 3D StdDev:"),
    //               ),
    //               SizedBox(width: 48), // give it width
    //               Flexible(
    //                 child: SizedBox(
    //                     width: 130,
    //                     height: 20,
    //                     child: TextField(
    //                       // controller: _controller40,
    //                       enabled: false,
    //                       maxLines: 1,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.black,
    //                       ),
    //                       decoration: InputDecoration(
    //                         border: OutlineInputBorder(),
    //                         labelStyle: TextStyle(
    //                           fontSize: 10,
    //                           color: Colors.black,
    //                         ),
    //                         labelText: (_connectionService.isRoverDisable!)
    //                             ? _connectionService.current_Packet.MeanAccuracy
    //                                 .toString()
    //                             : "0",
    //                         contentPadding: EdgeInsets.all(8),
    //                       ),
    //                     )),
    //               ),
    //               Text("  [m]")
    //             ],
    //           ),
    //         ]),
    //       ),
    //       Positioned(
    //           top: 8.0,
    //           left: 30.0,
    //           right: 0.0,
    //           bottom: 8,
    //           child: Row(children: <Widget>[
    //             Flexible(
    //                 child: Container(
    //               transform: Matrix4.translationValues(15.0, -315.0, 0.0),
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: 50.0,
    //               ),
    //               decoration: new BoxDecoration(
    //                 color: backgroundColor,
    //               ),
    //               child: Text(
    //                 'Results',
    //                 style: TextStyle(
    //                     color: Colors.black,
    //                     fontSize: 10.0,
    //                     fontWeight: FontWeight.bold),
    //               ),
    //             )),
    //           ])),
    //     ],
    //   ),
    // );
    // //////////////////////////////not used /////////////////////////////////////////////
  }
  //////////////////////////////not used /////////////////////////////////////////////

  // @override
  // Widget build(BuildContext context) => Container(
  //       child: Container(
  //         child: Container(
  //           child: ListView(
  //             physics: const NeverScrollableScrollPhysics(),
  //             primary: false,
  //             padding: const EdgeInsets.all(6.0),
  //             children: <Widget>[
  //               Container(
  //                 height: 310,
  //                 width: 120,
  //                 margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
  //                 padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
  //                 decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.blueAccent)),
  //                 child: Column(children: [
  //                   SizedBox(height: 10),
  //                   Row(
  //                     children: [
  //                       Flexible(
  //                         child: Text("Time Of Week:"),
  //                       ),
  //                       SizedBox(width: 65), // give it width
  //                       Flexible(
  //                           child: SizedBox(
  //                               width: 130,
  //                               height: 20,
  //                               child: TextField(
  //                                 enabled: false,
  //                                 maxLines: 1,
  //                                 style: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 decoration: InputDecoration(
  //                                   border: OutlineInputBorder(),
  //                                   labelStyle: TextStyle(
  //                                     fontSize: 10,
  //                                     color: Colors.black,
  //                                   ),
  //                                   labelText: _connectionService
  //                                       .current_Packet.iTOW
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ))),

  //                       Text(" [s]"),
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     children: [
  //                       Flexible(
  //                         child: Text("Status:"),
  //                       ),
  //                       SizedBox(width: 115), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               //  controller: _controller45,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText: (_connectionService
  //                                             .isRoverDisable! &&
  //                                         _connectionService
  //                                                 .current_Packet.Active ==
  //                                             1 &&
  //                                         _connectionService
  //                                             .connection!.IsConnect)
  //                                     ? "in progress"
  //                                     : (_connectionService.isRoverDisable! &&
  //                                             _connectionService
  //                                                     .current_Packet.Active ==
  //                                                 0.0 &&
  //                                             _connectionService
  //                                                 .connection!.IsConnect)
  //                                         ? "successfully"
  //                                         : "Not Started",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  ")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Mean Position Valid:"),
  //                       ),
  //                       SizedBox(width: 25), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               // controller: _controller44,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText:
  //                                     (_connectionService.isRoverDisable! &&
  //                                             _connectionService.current_Packet
  //                                                     .ValidityBit ==
  //                                                 1)
  //                                         ? "Yes"
  //                                         : "No",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  ")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Observation Time:"),
  //                       ),
  //                       SizedBox(width: 40), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               //  controller: _controller33,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText:
  //                                     (_connectionService.isRoverDisable!)
  //                                         ? _connectionService
  //                                             .current_Packet.Duration
  //                                             .toString()
  //                                         : "0",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  [s]")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Positions Used:"),
  //                       ),
  //                       SizedBox(width: 60), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               // controller: _controller41,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText:
  //                                     (_connectionService.isRoverDisable!)
  //                                         ? _connectionService
  //                                             .current_Packet.Observations
  //                                             .toString()
  //                                         : "0",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  ")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Mean ECEF X:"),
  //                       ),
  //                       SizedBox(width: 72), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               //controller: _controller34,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText: (_connectionService
  //                                         .isRoverDisable!)
  //                                     ? _connectionService.current_Packet.Mean_X
  //                                         .toString()
  //                                     : "0",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  [m]")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Mean ECEF Y:"),
  //                       ),
  //                       SizedBox(width: 72), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               // controller: _controller35,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText: (_connectionService
  //                                         .isRoverDisable!)
  //                                     ? _connectionService.current_Packet.Mean_Y
  //                                         .toString()
  //                                     : "0",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  [m]")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Mean ECEF Z:"),
  //                       ),
  //                       SizedBox(width: 72), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               //  controller: _controller36,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText: (_connectionService
  //                                         .isRoverDisable!)
  //                                     ? _connectionService.current_Packet.Mean_Z
  //                                         .toString()
  //                                     : "0",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  [m]")
  //                     ],
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     // verticalDirection: VerticalDirection.up,
  //                     // mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Flexible(
  //                         child: Text("Mean 3D StdDev:"),
  //                       ),
  //                       SizedBox(width: 48), // give it width
  //                       Flexible(
  //                         child: SizedBox(
  //                             width: 130,
  //                             height: 20,
  //                             child: TextField(
  //                               // controller: _controller40,
  //                               enabled: false,
  //                               maxLines: 1,
  //                               style: TextStyle(
  //                                 fontSize: 10,
  //                                 color: Colors.black,
  //                               ),
  //                               decoration: InputDecoration(
  //                                 border: OutlineInputBorder(),
  //                                 labelStyle: TextStyle(
  //                                   fontSize: 10,
  //                                   color: Colors.black,
  //                                 ),
  //                                 labelText:
  //                                     (_connectionService.isRoverDisable!)
  //                                         ? _connectionService
  //                                             .current_Packet.MeanAccuracy
  //                                             .toString()
  //                                         : "0",
  //                                 contentPadding: EdgeInsets.all(8),
  //                               ),
  //                             )),
  //                       ),
  //                       Text("  [m]")
  //                     ],
  //                   ),
  //                 ]),
  //               ),
  //               Positioned(
  //                   top: 8.0,
  //                   left: 30.0,
  //                   right: 0.0,
  //                   bottom: 8,
  //                   child: Row(children: <Widget>[
  //                     Flexible(
  //                         child: Container(
  //                       transform: Matrix4.translationValues(15.0, -315.0, 0.0),
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 50.0,
  //                       ),
  //                       decoration: new BoxDecoration(
  //                         color: backgroundColor,
  //                       ),
  //                       child: Text(
  //                         'Results',
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 10.0,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                     )),
  //                   ])),
  //             ],
  //           ),
  //         ),
  //         padding: EdgeInsets.all(1),
  //       ),
  //     );

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: ListView(
  //       physics: const AlwaysScrollableScrollPhysics(),
  //       primary: false,
  //       padding: const EdgeInsets.all(6.0),
  //       children: <Widget>[
  //         Container(
  //           margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
  //           padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.blueAccent),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Time Of Week:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText:
  //                             _connectionService.current_Packet.iTOW.toString(),
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text(" [s]"),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Status:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable! &&
  //                                 _connectionService.current_Packet.Active ==
  //                                     1 &&
  //                                 _connectionService.connection!.IsConnect)
  //                             ? "in progress"
  //                             : (_connectionService.isRoverDisable! &&
  //                                     _connectionService
  //                                             .current_Packet.Active ==
  //                                         0.0 &&
  //                                     _connectionService.connection!.IsConnect)
  //                                 ? "successfully"
  //                                 : "Not Started",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  "),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Mean Position Valid:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable! &&
  //                                 _connectionService
  //                                         .current_Packet.ValidityBit ==
  //                                     1)
  //                             ? "Yes"
  //                             : "No",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  "),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Observation Time:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable!)
  //                             ? _connectionService.current_Packet.Duration
  //                                 .toString()
  //                             : "0",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  [s]"),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Positions Used:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable!)
  //                             ? _connectionService.current_Packet.Observations
  //                                 .toString()
  //                             : "0",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  "),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Mean ECEF X:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable!)
  //                             ? _connectionService.current_Packet.Mean_X
  //                                 .toString()
  //                             : "0",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  [m]"),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Mean ECEF Y:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable!)
  //                             ? _connectionService.current_Packet.Mean_Y
  //                                 .toString()
  //                             : "0",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  [m]"),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Mean ECEF Z:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable!)
  //                             ? _connectionService.current_Packet.Mean_Z
  //                                 .toString()
  //                             : "0",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  [m]"),
  //                 ],
  //               ),
  //               SizedBox(height: 10),
  //               Row(
  //                 children: [
  //                   Expanded(
  //                     child: Text("Mean 3D StdDev:"),
  //                   ),
  //                   SizedBox(width: 10),
  //                   Expanded(
  //                     flex: 2,
  //                     child: TextField(
  //                       enabled: false,
  //                       maxLines: 1,
  //                       style: TextStyle(
  //                         fontSize: 10,
  //                         color: Colors.black,
  //                       ),
  //                       decoration: InputDecoration(
  //                         border: OutlineInputBorder(),
  //                         labelText: (_connectionService.isRoverDisable!)
  //                             ? _connectionService.current_Packet.MeanAccuracy
  //                                 .toString()
  //                             : "0",
  //                         contentPadding: EdgeInsets.all(8),
  //                       ),
  //                     ),
  //                   ),
  //                   Text("  [m]"),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
  //           padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
  //           decoration: BoxDecoration(
  //             border: Border.all(color: Colors.transparent),
  //           ),
  //           child: const Text(
  //             'Results',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 10.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          primary: false,
          padding: const EdgeInsets.all(6.0),
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildDataRow("Time Of Week:",
                      "${_connectionService.current_Packet.iTOW} [s]"),
                  buildDataRow("Status:", getStatusText()),
                  buildDataRow("Mean Position Valid:", getValidityText()),
                  buildDataRow("Observation Time:", getObservationTime()),
                  buildDataRow("Positions Used:",
                      "${_connectionService.isRoverDisable! ? _connectionService.current_Packet.Observations : 0}"),
                  buildDataRow("Mean ECEF X:",
                      "${_connectionService.isRoverDisable! ? _connectionService.current_Packet.Mean_X : 0} [m]"),
                  buildDataRow("Mean ECEF Y:",
                      "${_connectionService.isRoverDisable! ? _connectionService.current_Packet.Mean_Y : 0} [m]"),
                  buildDataRow("Mean ECEF Z:",
                      "${_connectionService.isRoverDisable! ? _connectionService.current_Packet.Mean_Z : 0} [m]"),
                  buildDataRow("Mean 3D StdDev:",
                      "${_connectionService.isRoverDisable! ? _connectionService.current_Packet.MeanAccuracy : 0} [m]"),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(12),
                color: Colors.blueAccent,
              ),
              child: const Text(
                'Results',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildDataRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Text(
                value,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      );

  String getStatusText() {
    if (_connectionService.isRoverDisable! &&
        _connectionService.current_Packet.Active == 1 &&
        _connectionService.connection!.IsConnect) {
      return "In Progress";
    } else if (_connectionService.isRoverDisable! &&
        _connectionService.current_Packet.Active == 0.0 &&
        _connectionService.connection!.IsConnect) {
      return "Successfully";
    } else {
      return "Not Started";
    }
  }

  String getValidityText() => (_connectionService.isRoverDisable! &&
          _connectionService.current_Packet.ValidityBit == 1)
      ? "Yes"
      : "No";

  String getObservationTime() => (_connectionService.isRoverDisable!)
      ? _connectionService.current_Packet.Duration.toString()
      : "0";

  // not used  //

  // Widget _buildDataRow(String label, String value) => Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8.0),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Text(
  //             label,
  //             style: TextStyle(
  //               fontSize: 14.0,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 16.0),
  //         Expanded(
  //           child: Text(
  //             value,
  //             style: TextStyle(
  //               fontSize: 14.0,
  //               color: Colors.black,
  //             ),
  //             textAlign: TextAlign.end,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // not used  //

  // not used  //

  // String _getStatus() {
  //   if (_connectionService.isRoverDisable! &&
  //       _connectionService.current_Packet.Active == 1 &&
  //       _connectionService.connection!.IsConnect) {
  //     return "in progress";
  //   } else if (_connectionService.isRoverDisable! &&
  //       _connectionService.current_Packet.Active == 0.0 &&
  //       _connectionService.connection!.IsConnect) {
  //     return "successfully";
  //   } else {
  //     return "Not Started";
  //   }
  // }
  // not used  //

  // not used  //
  // String _getMeanPositionValidity() {
  //   return _connectionService.isRoverDisable! &&
  //           _connectionService.current_Packet.ValidityBit == 1
  //       ? "Yes"
  //       : "No";
  // }
  // not used  //

  // not used  //

  // String _getObservationTime() {
  //   return _connectionService.isRoverDisable!
  //       ? _connectionService.current_Packet.Duration.toString()
  //       : "0";
  // }
  // not used  //

  // not used  //

  // String _getPositionsUsed() {
  //   return _connectionService.isRoverDisable!
  //       ? _connectionService.current_Packet.Observations.toString()
  //       : "0";
  // }
  // not used  //

  // not used  //

  // String _getMean3DStdDev() {
  //   return _connectionService.isRoverDisable!
  //       ? _connectionService.current_Packet.MeanAccuracy.toString()
  //       : "0";
  // }

  // not used  //
}
