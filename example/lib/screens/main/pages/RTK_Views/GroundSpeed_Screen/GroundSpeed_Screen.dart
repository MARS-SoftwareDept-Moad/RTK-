import 'package:docking/docking.dart';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Models/MeterData.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(GroundSpeed_Screen());
}

class GroundSpeed_Screen extends StatefulWidget {
  @override
  _GroundSpeed_ScreenState createState() => _GroundSpeed_ScreenState();
}

class _GroundSpeed_ScreenState extends State<GroundSpeed_Screen> {
  // not used //
  // late Container _layout;
  // static const Color backgroundColor = Color(0xFFeaf6f5);
 // not used //
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());
  @override
  void initState() {
    super.initState();
  }

// not used //
  // bool isRadialGauge = true;
  // Widget _getGauge(MeterData meter) {
  //   if (isRadialGauge) {
  //     return _getRadialGauge(meter);
  //   } else {
  //     return _getLinearGauge();
  //   }
  // }
// not used //
// not used // 

  Widget _getRadialGauge(MeterData meter) => SfRadialGauge(
        title: GaugeTitle(
          text: meter.name,
          textStyle:
              const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        axes: <RadialAxis>[
          RadialAxis(
            minimum: meter.minValue0,
            maximum: meter.maxValue2,
            ranges: <GaugeRange>[
              GaugeRange(
                startValue: meter.minValue0,
                endValue: meter.maxValue0,
                color: Colors.red,
                startWidth: 10,
                endWidth: 10,
              ),
              GaugeRange(
                startValue: meter.minValue1,
                endValue: meter.maxValue1,
                color: Colors.amber,
                startWidth: 10,
                endWidth: 10,
              ),
              GaugeRange(
                startValue: meter.minValue2,
                endValue: meter.maxValue2,
                color: Colors.green,
                startWidth: 10,
                endWidth: 10,
              ),
            ],
            pointers: <GaugePointer>[
              NeedlePointer(
                value: meter.pointerValue,
                needleLength: 0.45, // Adjust needle length if needed
                needleStartWidth: 1, // Adjust needle start width if needed
                needleEndWidth: 7, // Set needle end width to 10
                enableAnimation: true,
              ),
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                widget: Container(
                  child: Text(
                    meter.pointerValue.toString(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                angle: 90,
                positionFactor: 0.7,
              ),
            ],
          ),
        ],
      );

// not used //
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
// not used //

  @override
  Widget build(BuildContext context) => Scaffold(
        body: TabbedViewTheme(
          data: TabbedViewThemeData.classic(),
          child: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 170,
                width: 200,
                margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
                padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
                child: _getRadialGauge(_connectionService.meters![0]),
              ),
            ),
          ),
        ),
      );
}
