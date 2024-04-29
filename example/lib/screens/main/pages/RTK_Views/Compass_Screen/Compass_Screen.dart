import 'package:docking/docking.dart';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../map/map_view.dart';

void main() {
  runApp(Compass_Screen());
}

class Compass_Screen extends StatefulWidget {
  @override
  _Compass_ScreenState createState() => _Compass_ScreenState();
}

class _Compass_ScreenState extends State<Compass_Screen> {
  late Container _layout;
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  static const Color backgroundColor = Color(0xFFeaf6f5);
  double commpas = 90;
  @override
  void initState() {
    super.initState();
  }

  void axisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == '0') {
      args.text = 'N';
      args.labelStyle = GaugeTextStyle(color: Color.fromARGB(255, 255, 0, 0));
    } else {
      if (args.text == '90') {
        args.text = 'E';
        args.labelStyle =
            GaugeTextStyle(color: const Color.fromARGB(255, 255, 0, 0));
      } else if (args.text == '180') {
        args.text = 'S';
        args.labelStyle = GaugeTextStyle(color: Color.fromARGB(255, 255, 0, 0));
      } else if (args.text == '270') {
        args.text = 'W';
        args.labelStyle = GaugeTextStyle(color: Color.fromARGB(255, 255, 0, 0));
      }

      args.labelStyle = GaugeTextStyle(
        color: Color.fromARGB(255, 0, 0, 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    
        body: TabbedViewTheme(
          data: TabbedViewThemeData.classic(),
          child: Container(
            child: Container(
              
              //width: 200,
              child: Container(
                // color: Color.fromARGB(255, 211, 227, 235),
                height: 170,
                width: 200,
                margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
                padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
                child: SfRadialGauge(
                  // backgroundColor: Colors.lightBlue,
                  axes: <RadialAxis>[
                    RadialAxis(
                        showAxisLine: false,
                        radiusFactor: 1.5,
                        showLastLabel: false,
                        canRotateLabels: true,
                        tickOffset: 0.32,
                        offsetUnit: GaugeSizeUnit.factor,
                        onLabelCreated: axisLabelCreated,
                        startAngle: 270,
                        endAngle: 270,
                        labelOffset: 0.05,
                        maximum: 360,
                        minimum: 0,
                        interval: 30,
                        minorTicksPerInterval: 4,
                        axisLabelStyle:
                            GaugeTextStyle(color: Color.fromARGB(255, 7, 7, 7)),
                        minorTickStyle: MinorTickStyle(
                            color: const Color.fromARGB(255, 23, 138, 204),
                            thickness: 1.6,
                            length: 0.058,
                            lengthUnit: GaugeSizeUnit.factor),
                        majorTickStyle: MajorTickStyle(
                            color: const Color.fromARGB(255, 23, 138, 204),
                            thickness: 2.3,
                            length: 0.087,
                            lengthUnit: GaugeSizeUnit.factor),
                        // backgroundImage: const AssetImage(
                        //     '../../../assets/icons/dark_theme_gauge.png'),
                        pointers: <GaugePointer>[
                          MarkerPointer(
                              value: _connectionService
                                  .current_Packet.MagneticDeclination,
                              color: Color.fromARGB(255, 231, 13, 13),
                              enableAnimation: true,
                              animationDuration: 1200,
                              markerOffset: 0.71,
                              offsetUnit: GaugeSizeUnit.factor,
                              markerType: MarkerType.triangle,
                              markerHeight: 10,
                              markerWidth: 15)
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                              angle: 270,
                              positionFactor: 0.025,
                              widget: Text(
                                  _connectionService
                                      .current_Packet.MagneticDeclination
                                      .toString(),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22)))
                        ])
                  ],
                ),
              ),
            ),
            padding: EdgeInsets.all(1),
          ),
        ),
      );
}
