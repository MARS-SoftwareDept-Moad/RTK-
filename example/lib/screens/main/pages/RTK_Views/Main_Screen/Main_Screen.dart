import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:fmtc_example/screens/main/pages/RTK_Views/Connection_Screen/ConnectionScreen.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:window_manager/window_manager.dart';
import '../Dashboard_Screen/Dashboard_Screen.dart';
import '../Send_Screen/Send_Screen.dart';

//side_navigation
void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());
  bool extended = false;

  final colsController = TextEditingController();
  int colsNum = 1;
  late final List<String> data;
  final rowsController = TextEditingController();
  int rowsNum = 1;
  double maxOfTables = 0;
  String control_Icon = 'Send Flight Plan';
  String icon_default = 'Prelunch';
  String loiterValue = 'Loiter Now';
  String landValue = 'Rally Now';
  String MeasurementsPeriod = "";
  String MeasurementsFrequency = "";
  String NavigationRate = "1";
  String NavigationFrequency = "";
  double XLat = 0.000000000;
  double YLon = 0.000000000;
  double ZAlt = 0.000000000;
  String XLat_lable = "x";
  String YLon_lable = "y";
  String ZAlt_lable = "z";
  String XLat_measuring_unit = "M";
  String YLon_measuring_unit = "M";

  bool isChecked = false;
  bool isChecked2 = false;

  @override
  void initState() {
    super.initState();
    // _connectionService.subscription ??= _connectionService
    //     .getConPackets!.packetBaseStation!.stream
    //     .listen((values) {
    //   setState(() {
    //     var xyz = values['Acknowledgment']!;
    //     print("baseStation Packet GUI update");

    //   });
    // });
    // initPlatformState();
  }

  List<Widget> views = [
    Center(
      child: Dashboard_Screen(),
    ),
    Center(
      child: Send_Screen(),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      left: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      top: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Wrap(
                    children: [
                      //ConnectionDialogWidget(),
                      ElevatedButton(
                        child: Text(_connectionService.ConnectedMSGStatus!),
                        onPressed: () async {
                          if (_connectionService.serialPort == null ||
                              !_connectionService.serialPort!.isOpen) {
                            //    _connectionService.connectingToAP();

                            setState(() {
                              _connectionService.ConnectedMSGStatus =
                                  _connectionService.ConnectedMSGStatus;
                            });

                            // Show the connection dialog
                            await ConnectionPage()
                                .createState()
                                .showSimpleDialog(context);
                          } else {
                            _connectionService.Disconnect();
                            setState(() {
                              _connectionService.ConnectedMSGStatus = 'Connect';
                            });
                          }
                        },
                      ),

                      // SizedBox(
                      //   width: 5,
                      // ),
                      // ElevatedButton(
                      //   child: const Text('UDP'),
                      //   onPressed: () {},
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      left: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      top: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  //mode
                  // child: Wrap(
                  //   children: [
                  //     ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //           primary: _connectionService
                  //               .BaseStationColor, // background
                  //           onPrimary: Colors.black),
                  //       onPressed: () {
                  //         setState(() {
                  //           _connectionService.BaseStationClick();
                  //         });
                  //       },
                  //       child: Text('Base Station'),
                  //     ),
                  //     SizedBox(
                  //       width: 5,
                  //     ),
                  //     ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //             primary:
                  //                 _connectionService.RoverColor, // background
                  //             onPrimary: Colors.black),
                  //         onPressed: () {
                  //           setState(() {
                  //             _connectionService.RoverClick();
                  //           });
                  //         },
                  //         child: Text('Rover')),
                  //   ],
                  // ),
                ),
                SizedBox(
                  width: 5,
                ),
                // //Zoom In
                // Container(
                //     decoration: const BoxDecoration(
                //       border: Border(
                //         right: BorderSide(
                //           color: Colors.white,
                //           width: 2.0,
                //         ),
                //         left: BorderSide(
                //           color: Colors.white,
                //           width: 2.0,
                //         ),
                //         top: BorderSide(
                //           color: Colors.white,
                //           width: 2.0,
                //         ),
                //         bottom: BorderSide(
                //           color: Colors.white,
                //           width: 2.0,
                //         ),
                //       ),
                //     ),
                //     child: Wrap(
                //       children: [
                //         InkWell(
                //           onTap: (() {}),
                //           child: Image.asset(
                //             'lib/Icons/play.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //         SizedBox(
                //           width: 5,
                //         ),
                //         InkWell(
                //           onTap: () {
                //           //  setState(_incrementZoomLevel);
                //           },
                //           child: Image.asset(
                //             'lib/Icons/plus.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         //Zoom Out
                //         InkWell(
                //           onTap: () {
                //            // setState(_decrementZoomLevel);
                //           },
                //           child: Image.asset(
                //             'lib/Icons/minus.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         //Left
                //         Container(
                //           height: 35,
                //           width: 35,
                //           child: Image.asset(
                //             'lib/Icons/left.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         //Right
                //         Container(
                //           height: 35,
                //           width: 35,
                //           child: Image.asset(
                //             'lib/Icons/right.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         //Up
                //         Container(
                //           height: 35,
                //           width: 35,
                //           child: Image.asset(
                //             'lib/Icons/up-arrow.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 5,
                //         ),
                //         //Down
                //         Container(
                //           height: 35,
                //           width: 35,
                //           decoration: const BoxDecoration(
                //             border: Border(
                //               right: BorderSide(
                //                 color: Colors.white,
                //                 width: 1.0,
                //               ),
                //             ),
                //           ),
                //           child: Image.asset(
                //             'lib/Icons/download.png',
                //             fit: BoxFit.contain,
                //             height: 35,
                //             width: 35,
                //           ),
                //         ),
                //       ],
                //     )),
                // const SizedBox(
                //   width: 5,
                // ),

                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      left: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      top: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                  child: Wrap(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (_connectionService.checkboxval!) {
                                _connectionService.getConPackets.scu_SendPacket
                                    .ECEFXCoordinate = XLat;
                                _connectionService.getConPackets.scu_SendPacket
                                    .ECEFYCoordinate = YLon;
                                _connectionService.getConPackets.scu_SendPacket
                                    .ECEFZCoordinate = ZAlt;
                              }
                              _connectionService.SendFlightPlanC();
                            });
                          },
                          child: Image.asset(
                            'lib/Icons/send_FP.png',
                            fit: BoxFit.contain,
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isChecked2
                        ? Colors.blue
                        : Colors.grey[300], // Toggle background color
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _connectionService.checkboxval2 = !isChecked2;
                      setState(() {
                        isChecked2 = !isChecked2;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              color: isChecked2
                                  ? Colors.white
                                  : Colors
                                      .black, // Text color based on the toggle state
                            ),
                          ),
                          Container(
                            width: 50,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Toggle button color
                            ),
                            child: Center(
                              child: Icon(
                                isChecked2 ? Icons.check : Icons.close,
                                color: isChecked2
                                    ? Colors.green
                                    : Colors
                                        .red, // Icon color based on the toggle state
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Color.fromARGB(255, 211, 227, 235),
          ),

          // The row is needed to display the current view
          body: Row(
            children: [
              /// Pretty similar to the BottomNavigationBar!

              SideNavigationBar(
                initiallyExpanded: false,
                selectedIndex: selectedIndex,
                items: const [
                  SideNavigationBarItem(
                    icon: Icons.dashboard,
                    label: 'Dashboard',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.send,
                    label: 'Send',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },

                // toggler: const SideBarToggler(
                //   shrinkIcon: Icons.keyboard_arrow_right,
                //   expandIcon: Icons.keyboard_arrow_left,
                // )
              ),

              /// Make it take the rest of the available width
              Expanded(
                child: views.elementAt(selectedIndex),
              ),
            ],
          ),
        ),
      );

  // @override
  // Widget build(BuildContext context) => Container(
  //       constraints: BoxConstraints(
  //         minWidth: 500, // Set your minimum width here
  //         maxWidth: 1000, // Set your maximum width here
  //       ),
  //       child: MaterialApp(
  //         home: Scaffold(
  //           appBar: AppBar(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     border: Border(
  //                       right: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       left: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       top: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       bottom: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                     ),
  //                   ),
  //                   child: Wrap(
  //                     children: [
  //                       ElevatedButton(
  //                         child: Text(_connectionService.ConnectedMSGStatus!),
  //                         onPressed: () async {
  //                           if (_connectionService.serialPort == null ||
  //                               !_connectionService.serialPort!.isOpen) {
  //                             setState(() {
  //                               _connectionService.ConnectedMSGStatus =
  //                                   _connectionService.ConnectedMSGStatus;
  //                             });
  //                             await ConnectionPage()
  //                                 .createState()
  //                                 .showSimpleDialog(context);
  //                           } else {
  //                             _connectionService.Disconnect();
  //                             setState(() {
  //                               _connectionService.ConnectedMSGStatus =
  //                                   'Connect';
  //                             });
  //                           }
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 const SizedBox(
  //                   width: 5,
  //                 ),
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     border: Border(
  //                       right: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       left: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       top: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       bottom: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 5,
  //                 ),
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                     border: Border(
  //                       right: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       left: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       top: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                       bottom: BorderSide(
  //                         color: Colors.white,
  //                         width: 2.0,
  //                       ),
  //                     ),
  //                   ),
  //                   child: Wrap(
  //                     children: [
  //                       Container(
  //                         height: 35,
  //                         width: 35,
  //                         child: InkWell(
  //                           onTap: () {
  //                             setState(() {
  //                               if (_connectionService.checkboxval!) {
  //                                 _connectionService.getConPackets
  //                                     .scu_SendPacket.ECEFXCoordinate = XLat;
  //                                 _connectionService.getConPackets
  //                                     .scu_SendPacket.ECEFYCoordinate = YLon;
  //                                 _connectionService.getConPackets
  //                                     .scu_SendPacket.ECEFZCoordinate = ZAlt;
  //                               }
  //                               _connectionService.SendFlightPlanC();
  //                             });
  //                           },
  //                           child: Image.asset(
  //                             'lib/Icons/send_FP.png',
  //                             fit: BoxFit.contain,
  //                             height: 35,
  //                             width: 35,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   width: 5,
  //                 ),
  //                 Container(
  //                   height: 40,
  //                   width: 150,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     color: isChecked2 ? Colors.blue : Colors.grey[300],
  //                   ),
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       _connectionService.checkboxval2 = !isChecked2;
  //                       setState(() {
  //                         isChecked2 = !isChecked2;
  //                       });
  //                     },
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(
  //                             'Default',
  //                             style: TextStyle(
  //                               fontSize: 18,
  //                               fontStyle: FontStyle.italic,
  //                               color: isChecked2 ? Colors.white : Colors.black,
  //                             ),
  //                           ),
  //                           Container(
  //                             width: 50,
  //                             height: 30,
  //                             decoration: BoxDecoration(
  //                               shape: BoxShape.circle,
  //                               color: Colors.white,
  //                             ),
  //                             child: Center(
  //                               child: Icon(
  //                                 isChecked2 ? Icons.check : Icons.close,
  //                                 color: isChecked2 ? Colors.green : Colors.red,
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             backgroundColor: Color.fromARGB(255, 211, 227, 235),
  //           ),
  //           body: Row(
  //             children: [
  //               SideNavigationBar(
  //                 selectedIndex: selectedIndex,
  //                 items: const [
  //                   SideNavigationBarItem(
  //                     icon: Icons.dashboard,
  //                     label: 'Dashboard',
  //                   ),
  //                   SideNavigationBarItem(
  //                     icon: Icons.send,
  //                     label: 'Send',
  //                   ),
  //                 ],
  //                 onTap: (index) {
  //                   setState(() {
  //                     selectedIndex = index;
  //                   });
  //                 },
  //               ),
  //               Expanded(
  //                 child: views.elementAt(selectedIndex),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}
