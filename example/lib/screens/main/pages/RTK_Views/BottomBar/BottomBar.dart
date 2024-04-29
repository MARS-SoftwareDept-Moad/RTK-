import 'dart:async';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:fmtc_example/Models/MeterData.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../Clock_Screen/Clock_Screen.dart';
import '../Compass_Screen/Compass_Screen.dart';
import '../GroundSpeed_Screen/GroundSpeed_Screen.dart';

double commpas = 90;
var Year = 0.0;
var Month = 0.0;
var Day = 0.0;
var Hour = 0.0;
var Minute = 0.0;
var Seconds = 0.0;
var Gs = 0.0;

final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();

class BottomBar extends StatefulWidget {
  // const ConnectionPage({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());
  @override
  Widget build(BuildContext context) => BottomAppBar(
        //color: Color.fromARGB(255, 211, 227, 235),
        height: 200,
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // If screen width is less than 600 pixels, use Column layout
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildContainerWithBorderRadius(
                        Clock_Screen(), constraints),
                    _buildContainerWithBorderRadius(
                        Compass_Screen(), constraints),
                    _buildContainerWithBorderRadius(
                        GroundSpeed_Screen(), constraints),
                    _buildStatusContainer(),
                  ],
                );
              } else {
                // Otherwise, use Row layout
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildContainerWithBorderRadius(
                        Clock_Screen(), constraints),
                    _buildContainerWithBorderRadius(
                        Compass_Screen(), constraints),
                    _buildContainerWithBorderRadius(
                        GroundSpeed_Screen(), constraints),
                    _buildStatusContainer(),
                  ],
                );
              }
            },
          ),
        ),
      );

  Widget _buildContainerWithBorderRadius(
          Widget child, BoxConstraints constraints) =>
      Container(
        height: 170,
        width: constraints.maxWidth < 600
            ? constraints.maxWidth * 0.8
            : 250, // Adjust width based on screen size
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(10), // Adjust border radius as needed
          color: Colors.blue
              .withOpacity(0.3), // Adjust opacity and color as needed
          boxShadow: [
            BoxShadow(
              color: Colors.blue
                  .withOpacity(0.2), // Adjust shadow color and opacity
              spreadRadius: 2, // Adjust spread radius
              blurRadius: 5, // Adjust blur radius
              offset: Offset(0, 3), // Adjust offset
            ),
          ],
        ),
        child: child,
      );

  Widget _buildStatusContainer() => Container(
        height: 170,
        width: 200,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(20), // Adjust border radius as needed
          color: Colors.white
              .withOpacity(0.8), // Adjust opacity and color as needed
          boxShadow: [
            BoxShadow(
              color: Colors.blue
                  .withOpacity(0.5), // Adjust shadow color and opacity
              spreadRadius: 3, // Adjust spread radius
              blurRadius: 5, // Adjust blur radius
              offset: Offset(0, 3), // Adjust offset
            ),
          ],
        ),
        child: Stack(
          children: [
            _connectionService.connection?.IsConnect == true
                ? Positioned(
                    left: 65, // Adjust position as needed
                    top: 40, // Adjust position as needed
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: Icon(Icons.check, color: Colors.white),
                        ),
                        Text(
                          "Connected",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _connectionService.isRoverDisable == false
                            ? Text(
                                "Rover",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Base Station",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ],
                    ),
                  )
                : Positioned(
                    left: 37, // Adjust position as needed
                    top: 40, // Adjust position as needed
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: Icon(Icons.warning, color: Colors.white),
                        ),
                        Text(
                          "Not Connected",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      );

  // void axisLabelCreated(AxisLabelCreatedArgs args) {
  //   if (args.text == '0') {
  //     args.text = 'N';
  //     args.labelStyle = GaugeTextStyle(color: Color.fromARGB(255, 255, 0, 0));
  //   } else {
  //     if (args.text == '90') {
  //       args.text = 'E';
  //       args.labelStyle =
  //           GaugeTextStyle(color: const Color.fromARGB(255, 255, 0, 0));
  //     } else if (args.text == '180') {
  //       args.text = 'S';
  //       args.labelStyle = GaugeTextStyle(color: Color.fromARGB(255, 255, 0, 0));
  //     } else if (args.text == '270') {
  //       args.text = 'W';
  //       args.labelStyle = GaugeTextStyle(color: Color.fromARGB(255, 255, 0, 0));
  //     }

  //     args.labelStyle = GaugeTextStyle(
  //       color: Color.fromARGB(255, 0, 0, 0),
  //     );
  //   }
  // }

  // bool isRadialGauge = true;
  // Widget _getGauge(MeterData meter) {
  //   if (isRadialGauge) {
  //     return _getRadialGauge(meter);
  //   } else {
  //     return _getLinearGauge();
  //   }
  // }

  // Widget _getLinearGauge() => Container(
  //       margin: const EdgeInsets.all(10),
  //       child: SfLinearGauge(
  //           minimum: 0,
  //           maximum: 100,
  //           orientation: LinearGaugeOrientation.horizontal,
  //           majorTickStyle: const LinearTickStyle(length: 20),
  //           axisLabelStyle:
  //               const TextStyle(fontSize: 12.0, color: Colors.black),
  //           axisTrackStyle: const LinearAxisTrackStyle(
  //               color: Colors.cyan,
  //               edgeStyle: LinearEdgeStyle.bothFlat,
  //               thickness: 15.0,
  //               borderColor: Colors.grey)),
  //     );

  // Widget _getRadialGauge(MeterData meter) => SfRadialGauge(
  //         title: GaugeTitle(
  //             text: meter.name,
  //             textStyle:
  //                 const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
  //         axes: <RadialAxis>[
  //           RadialAxis(
  //               minimum: meter.minValue0,
  //               maximum: meter.maxValue2,
  //               ranges: <GaugeRange>[
  //                 GaugeRange(
  //                     startValue: meter.minValue0,
  //                     endValue: meter.maxValue0,
  //                     color: Colors.red,
  //                     startWidth: 10,
  //                     endWidth: 10),
  //                 GaugeRange(
  //                     startValue: meter.minValue1,
  //                     endValue: meter.maxValue1,
  //                     color: Colors.amber,
  //                     startWidth: 10,
  //                     endWidth: 10),
  //                 GaugeRange(
  //                     startValue: meter.minValue2,
  //                     endValue: meter.maxValue2,
  //                     color: Colors.green,
  //                     startWidth: 10,
  //                     endWidth: 10)
  //               ],
  //               pointers: <GaugePointer>[
  //                 NeedlePointer(value: Gs)
  //               ],
  //               annotations: <GaugeAnnotation>[
  //                 GaugeAnnotation(
  //                     widget: Container(
  //                         child: Text(Gs.toString(),
  //                             style: const TextStyle(
  //                                 fontSize: 25, fontWeight: FontWeight.bold))),
  //                     angle: 90,
  //                     positionFactor: 0.9)
  //               ])
  //         ]);
}
