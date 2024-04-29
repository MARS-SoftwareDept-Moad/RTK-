import 'package:docking/docking.dart';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:fmtc_example/screens/main/pages/RTK_Views/BottomBar/BottomBar.dart';
import 'package:fmtc_example/screens/main/pages/RTK_Views/UBX_NAV/UBX_NAV.dart';
import 'package:fmtc_example/screens/main/pages/RTK_Views/UBX_RXM/UBX_RXM.dart';

import '../../map/mainScreen.dart';
import '../Clock_Screen/Clock_Screen.dart';
import '../Compass_Screen/Compass_Screen.dart';
import '../GroundSpeed_Screen/GroundSpeed_Screen.dart';
import '../Indicators_Screen/Indicators_Screen.dart';
import '../Packets_Screen/Packets_Screen.dart';
import '../Progress/Progress.dart';
import '../Results_Screen/Results_Screen.dart';

void main() {
  runApp(Dashboard_Screen());
}

class Dashboard_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Docking example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DockingExamplePage(),
      );
}

class DockingExamplePage extends StatefulWidget {
  @override
  _DockingExamplePageState createState() => _DockingExamplePageState();
}

class _DockingExamplePageState extends State<DockingExamplePage> {
  late DockingLayout _layout;
  ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  @override
  void initState() {
    super.initState();

    if (_connectionService.isRoverDisable!)
      _connectionService.current_Packet =
          _connectionService.getConPackets.packetBaseStation!;
    else
      _connectionService.current_Packet =
          _connectionService.getConPackets.packetRover!;
    _connectionService.subscription ??=
        _connectionService.current_Packet!.stream.listen((values) {
      setState(() {
        var xyz = values['Acknowledgment']!;
        print("baseStation Packet GUI update");
        var x;

        if (_connectionService.isRoverDisable!) {
          x = _connectionService.getConPackets.packetBaseStation;
          _connectionService.values_dict = {
            'Header': x.Header, // done p10
            'Acknowledgment': x.Acknowledgment.toString(), // done p10
            'iTOW': x.iTOW.toString(), // done p10
            'Year': x.Year.toString(),
            'Month': x.Month.toString(),
            'Day of month': x.DayOfMonth.toString(),
            'Hour of day': x.HourOfDay.toString(),
            'Minute of hour': x.MinuteOfHour.toString(), // done p40
            'Seconds of minute': x.SecondsOfMinute.toString(),
            'valid': x.valid.toString(),
            'Time accuracy ': x.TimeAccuracyEstimate.toString(),
            'Flag_gps': x.Flag_gps.toString(),
            'Flag2_gps': x.Flag2_gps.toString(),
            'Number of satellites':
                x.NumberOfSatellitesUsedInNavSolution.toString(),
            'Longitude': x.Longitude.toString(),
            'Latitude': x.Latitude.toString(),
            'Height above ellipsoid': x.HeightAboveEllipsoid.toString(),
            'Height above mean sea level': x.HeightAboveMeanSeaLevel.toString(),
            'Horizontal accuracy ': x.HorizontalAccuracyEstimate.toString(),
            'Vertical accuracy ': x.VerticalAccuracyEstimate.toString(),
            'NED north velocity': x.NED_NorthVelocity.toString(),
            'NED east velocity': x.NED_EastVelocity.toString(),
            'NED down velocity': x.NED_DownVelocity.toString(),
            'Ground Speed': x.GroundSpeed.toString(),
            'Heading of motion': x.HeadingOfMotion.toString(),
            'Speed accuracy ': x.SpeedAccuracyEstimate.toString(),
            'Heading accuracy ': x.HeadingAccuracyEstimate.toString(),
            'Position DOP': x.PositionDOP.toString(),
            'Heading of vehicle': x.HeadingOfVehicle.toString(),
            'Magnetic declination': x.MagneticDeclination.toString(),
            'Magnetic declination accuracy':
                x.MagneticDeclinationAccuracy.toString(),
            'gpsFix': x.gpsFix.toString(),
            'Time to first fix': x.TimeToFirstFix.toString(),
            'Milliseconds since Startup': x.MillisecondsSinceStartup.toString(),
            'Duration': x.Duration.toString(),
            'Mean ECEF X': x.Mean_X.toString() + x.meanXHP.round().toString(),
            'Mean ECEF Y': x.Mean_Y.toString() + x.meanYHP.round().toString(),
            'Mean ECEF Z': x.Mean_Z.toString() + x.meanZHP.round().toString(),
            'meanXHP': x.meanXHP.toString(),
            'meanYHP': x.meanYHP.toString(),
            'meanZHP': x.meanZHP.toString(),
            'Mean Accuracy': x.MeanAccuracy.toString(),
            'observations': x.Observations.toString(),
            'Validity bit': x.ValidityBit.toString(),
            'Active': x.Active.toString(),
            // 'Checksum': x.Checksum.toString(),
          };
        } else {
          x = _connectionService.getConPackets.packetRover;
          _connectionService.values_dict = {
            'Header': x.Header.toString(), // done p10
            'Acknowledgment': x.Acknowledgment.toString(), // done p10
            'iTOW': x.iTOW.toString(), // done p10
            'Year': x.Year.toString(),
            'Month': x.Month.toString(),
            'Day of month': x.DayOfMonth.toString(),
            'Hour of day': x.HourOfDay.toString(),
            'Minute of hour': x.MinuteOfHour.toString(), // done p40
            'Seconds of minute': x.SecondsOfMinute.toString(),
            'valid': x.valid.toString(),
            'Time accuracy ': x.TimeAccuracyEstimate.toString(),
            'Flag_gps': x.Flag_gps.toString(),
            'Flag2_gps': x.Flag2_gps.toString(),
            'Number of satellites':
                x.NumberOfSatellitesUsedInNavSolution.toString(),
            'Longitude': x.Longitude.toString(),
            'Latitude': x.Latitude.toString(),
            'Height above ellipsoid': x.HeightAboveEllipsoid.toString(),
            'Height above mean sea level': x.HeightAboveMeanSeaLevel.toString(),
            'Horizontal accuracy ': x.HorizontalAccuracyEstimate.toString(),
            'Vertical accuracy ': x.VerticalAccuracyEstimate.toString(),
            'NED north velocity': x.NED_NorthVelocity.toString(),
            'NED east velocity': x.NED_EastVelocity.toString(),
            'NED down velocity': x.NED_DownVelocity.toString(),
            'Ground Speed': x.GroundSpeed.toString(),
            'Heading of motion': x.HeadingOfMotion.toString(),
            'Speed accuracy ': x.SpeedAccuracyEstimate.toString(),
            'Heading accuracy ': x.HeadingAccuracyEstimate.toString(),
            'Position DOP': x.PositionDOP.toString(),
            'Heading of vehicle': x.HeadingOfVehicle.toString(),
            'Magnetic declination': x.MagneticDeclination.toString(),
            'Magnetic declination accuracy':
                x.MagneticDeclinationAccuracy.toString(),
            'gpsFix': x.gpsFix.toString(),
            'Time to first fix': x.TimeToFirstFix.toString(),
            'Milliseconds since Startup': x.MillisecondsSinceStartup.toString(),
            'MsType': x.MsType.toString(),
            'Flags': x.Flags.toString(),
            // 'Checksum': x.Checksum.toString(),
          };
        }
      });
    });

    int v = 1;

    // _layout = DockingLayout(
    //   root: DockingRow(
    //     [
    //       DockingItem(
    //         closable: false,
    //         keepAlive: true,
    //         name: 'Map',
    //         widget: Container(
    //           constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //           child: FractionallySizedBox(
    //             child: MainMapScreen(),
    //           ),
    //         ),
    //       ),
    //       DockingTabs(
    //         [
    //           DockingItem(
    //             closable: false,
    //             keepAlive: true,
    //             name: 'Results',
    //             widget: Container(
    //               constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //               child: Results_Screen(),
    //               padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
    //             ),
    //           ),
    //           DockingItem(
    //             closable: false,
    //             keepAlive: true,
    //             name: 'Indicators',
    //             widget: Container(
    //               constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //               child: Indicators(),
    //               padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
    //             ),
    //           ),
    //           DockingItem(
    //             closable: false,
    //             name: 'Packets',
    //             widget: Container(
    //               constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //               child: Packets(),
    //               padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
    //             ),
    //           ),
    //           DockingItem(
    //             closable: false,
    //             keepAlive: true,
    //             name: 'Progress',
    //             widget: Container(
    //               constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //               child: MyProgressIndicator(),
    //               padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
    //             ),
    //           ),
    //           DockingItem(
    //             keepAlive: true,
    //             closable: false,
    //             name: 'UBX_NAV',
    //             widget: Container(
    //               constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //               child: MyTableWidget(),
    //               padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
    //             ),
    //           ),
    //           DockingItem(
    //             closable: false,
    //             keepAlive: true,
    //             name: 'UBX_RXM',
    //             widget: Container(
    //               constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
    //               child: MyTableWidgetRXM(),
    //               padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    _layout = DockingLayout(
      root: DockingRow([
        _minimalWeightItem, // Map
        DockingRow([
          DockingTabs([
            _buildResults("Result"),
            _buildIndicators("Indicators"),
            _buildPackets("Packets"),
            _buildProgress("Progress"),
            _buildUBX_NAV("UBX_NAV"),
            _buildUBX_RXM("UBXRXM"),
          ])
        ]),
      ]),
    );
  }

  DockingItem get _minimalWeightItem => DockingItem(
        name: 'Map',
        minimalWeight: .5,
        widget: Container(
          width: 100,
          child: MainMapScreen(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  // DockingItem get __buildMap => DockingItem(
  //       name: 'minimalSize',
  //       minimalSize: 500,
  //       widget: Container(
  //         width: 100,
  //         child: MainMapScreen(),
  //         padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
  //       ),
  //     );

  DockingItem _buildResults(String name,
          {double? weight, bool closable = true, bool? maximizable}) =>
      DockingItem(
        weight: weight,
        name: name,
        closable: false,
        maximizable: maximizable,
        widget: Container(
          width: 100,
          child: Results_Screen(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  DockingItem _buildIndicators(String name,
          {double? weight, bool closable = true, bool? maximizable}) =>
      DockingItem(
        weight: weight,
        name: name,
        closable: false,
        maximizable: maximizable,
        widget: Container(
          width: 100,
          child: Indicators(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  DockingItem _buildPackets(String name,
          {double? weight, bool closable = true, bool? maximizable}) =>
      DockingItem(
        weight: weight,
        name: name,
        closable: false,
        maximizable: maximizable,
        widget: Container(
          width: 100,
          child: Packets(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  DockingItem _buildProgress(String name,
          {double? weight, bool closable = true, bool? maximizable}) =>
      DockingItem(
        weight: weight,
        name: name,
        closable: false,
        maximizable: maximizable,
        widget: Container(
          width: 100,
          child: MyProgressIndicator(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  DockingItem _buildUBX_NAV(String name,
          {double? weight, bool closable = true, bool? maximizable}) =>
      DockingItem(
        weight: weight,
        name: name,
        closable: false,
        maximizable: maximizable,
        widget: Container(
          width: 100,
          child: MyTableWidget(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  DockingItem _buildUBX_RXM(String name,
          {double? weight, bool closable = true, bool? maximizable}) =>
      DockingItem(
        weight: weight,
        name: name,
        closable: false,
        maximizable: maximizable,
        widget: Container(
          width: 100,
          child: MyTableWidgetRXM(),
          padding: const EdgeInsets.fromLTRB(8, 20, 5, 0),
        ),
      );

  @override
  void dispose() {
    _connectionService.subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TabbedViewTheme(
        data: TabbedViewThemeData.mobile(), // Set your desired theme data
        child: Scaffold(
          body: Container(
            child: Docking(layout: _layout),
            padding: EdgeInsets.all(16),
          ),
          bottomNavigationBar: BottomBar(),
        ),
      );
}

class CenterText extends StatelessWidget {
  const CenterText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, overflow: TextOverflow.ellipsis));
  }
}
