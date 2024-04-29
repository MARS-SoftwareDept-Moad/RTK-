import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MyProgressIndicator extends StatefulWidget {
  const MyProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  createState() => _MyProgressIndicator();
}

class _MyProgressIndicator extends State<MyProgressIndicator> {
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildDataRow(
                              "Longitude:",
                              _connectionService.current_Packet.Longitude
                                  .toString()),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "Latitude:",
                              _connectionService.current_Packet.Latitude
                                  .toString()),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "Altitude:",
                              _connectionService
                                  .current_Packet.HeightAboveEllipsoid
                                  .toString()),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "Altitude (msl):",
                              _connectionService
                                  .current_Packet.HeightAboveMeanSeaLevel
                                  .toString()),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "TTFF:",
                              _connectionService.current_Packet.TimeToFirstFix
                                      .toString() +
                                  " [s]"),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "Fix Mode:",
                              _connectionService.current_Packet.gpsFix
                                  .toString()),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "3D Acc.[m]:",
                              (_connectionService.isRoverDisable!)
                                  ? _connectionService
                                      .current_Packet.MeanAccuracy
                                      .toString()
                                  : "0 [m]"),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "2D Acc.[m]:",
                              _connectionService
                                      .current_Packet.HorizontalAccuracyEstimate
                                      .toString() +
                                  " [m]"),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "PDOP:",
                              _connectionService.current_Packet.PositionDOP
                                      .toString() +
                                  " [m]"),
                          SizedBox(height: 10),
                          _buildDataRow(
                              "Satellites:",
                              _connectionService.current_Packet
                                  .NumberOfSatellitesUsedInNavSolution
                                  .toString()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildProgressIndicator(), // Added a custom progress indicator
                ],
              ),
            ),
          ),
        ),
      );

  Widget _buildDataRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 1),
        builder: (context, value, child) => Transform.scale(
          scale: 1.0 + value * 0.1,
          child: Opacity(
            opacity: 1.0 - value * 0.5,
            child: Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Progress',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  // @override
  // Widget build(BuildContext context) => Container(
  //       child: Center(
  //         child: Container(
  //           child: Column(
  //             children: <Widget>[
  //               Expanded(
  //                 child: Container(
  //                   margin: const EdgeInsets.all(8.0),
  //                   decoration: BoxDecoration(
  //                     border: Border.all(color: Colors.blueAccent),
  //                   ),
  //                   child: ListView(
  //                     padding: const EdgeInsets.all(6.0),
  //                     children: <Widget>[
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("Longitude:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.Longitude
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text(" [s]"),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("Latitude:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.Latitude
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  "),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       // Add similar Rows for other fields
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("Altitude:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.HeightAboveEllipsoid
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  "),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("Altitude (msl):"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.HeightAboveMeanSeaLevel
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  "),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("TTFF:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.TimeToFirstFix
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  [s]"),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("Fix Mode:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.gpsFix
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  "),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("3D Acc.[m]:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText:
  //                                       (_connectionService.isRoverDisable!)
  //                                           ? _connectionService
  //                                               .current_Packet.MeanAccuracy
  //                                               .toString()
  //                                           : "0",
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  [m]"),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("2D Acc.[m]:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService.current_Packet
  //                                       .HorizontalAccuracyEstimate
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  [m]"),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("PDOP:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService
  //                                       .current_Packet.PositionDOP
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  [m]"),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                       Row(
  //                         children: [
  //                           Expanded(
  //                             child: Text("Satellites:"),
  //                           ),
  //                           SizedBox(width: 90),
  //                           Expanded(
  //                             flex: 2,
  //                             child: SizedBox(
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
  //                                   labelText: _connectionService.current_Packet
  //                                       .NumberOfSatellitesUsedInNavSolution
  //                                       .toString(),
  //                                   contentPadding: EdgeInsets.all(8),
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           Text("  [m]"),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: const EdgeInsets.fromLTRB(8, 5, 5, 0),
  //                 padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.transparent),
  //                 ),
  //                 child: const Text(
  //                   'progress',
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 10.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}
