import 'package:docking/docking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';

import '../../map/map_view.dart';

void main() {
  runApp(Clock_Screen());
}

class Clock_Screen extends StatefulWidget {
  @override
  _Clock_ScreenState createState() => _Clock_ScreenState();
}

class _Clock_ScreenState extends State<Clock_Screen> {
  late Container _layout;
  static const Color backgroundColor = Color(0xFFeaf6f5);
  final GlobalKey<AnalogClockState> _analogClockKey = GlobalKey();
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Accessing currentState after the first frame has been built
      _analogClockKey.currentState?.dateTime = DateTime.now();
      // _analogClockKey.currentState?.dateTime = DateTime(
      //     _connectionService.current_Packet.Year.toInt(),
      //     _connectionService.current_Packet.Month.toInt(),
      //     // _connectionService.current_Packet.Day.toInt(),
      //     // _connectionService.current_Packet.Hour.toInt(),
      //     // _connectionService.current_Packet.Minute.toInt(),
      //     // _connectionService.current_Packet.Seconds.toInt()
      //     );
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: TabbedViewTheme(
          data: TabbedViewThemeData.classic(),
          child: Container(
            child: Container(
              //  color: Color.fromARGB(255, 211, 227, 235),
              height: 170,
              width: 200,
              margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
              padding: const EdgeInsets.fromLTRB(8, 16, 5, 0),
              child: AnalogClock(
                key: _analogClockKey,
                dateTime: DateTime(2022, 10, 24, 1, 23, 45),
                isKeepTime: false,
                child: const Align(
                  alignment: FractionalOffset(0.5, 0.75),
                  child: Text('GMT-8'),
                ),
              ),
            ),
            padding: EdgeInsets.all(1),
          ),
        ),
      );
}
