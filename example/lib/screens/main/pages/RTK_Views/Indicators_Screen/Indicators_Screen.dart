import 'dart:async';

import 'package:docking/docking.dart';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';

import '../../map/map_view.dart';

class Indicators extends StatefulWidget {
  const Indicators({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Indicators();
}

class _Indicators extends State<Indicators> {
  TextEditingController _controllerTST = TextEditingController();
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());
  List<String> droppedItems = [];

  late Timer timer;
  @override
  void initState() {
    super.initState();

    // timer = Timer.periodic(Duration(milliseconds: 20), (t) {

    //   setState(() {
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
    //   });
    // });
    _connectionService.subscription ??= _connectionService
        .getConPackets!.packetBaseStation!.stream
        .listen((values) {
      setState(() {
        var xyz = values['Acknowledgment']!;
        print("baseStation Packet GUI update");
      });
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) => Expanded(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.grey[200],
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: (_connectionService.Values ?? []).map<Widget>((value) {
                final valueDict =
                    _connectionService.values_dict![value.toString()];
                return Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 38, 62, 105),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    color: const Color.fromARGB(255, 136, 176, 245)
                        .withOpacity(0.2), // Set opacity here
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        valueDict.toString(),
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );

  // @override
  // Widget build(BuildContext context) => Expanded(
  //       child: SingleChildScrollView(
  //         child: Container(
  //           padding: EdgeInsets.all(8.0),
  //           color: Colors.grey[200],
  //           child: Wrap(
  //             spacing: 8.0,
  //             runSpacing: 8.0,
  //             // ignore: avoid_dynamic_calls
  //             children: _connectionService.Values!.map((value) {
  //               final valueDict =
  //                   _connectionService.values_dict![value.toString()];
  //               return Draggable<String>(
  //                 feedback: Material(
  //                   child: Container(
  //                     padding: EdgeInsets.all(8.0),
  //                     decoration: BoxDecoration(
  //                       border: Border.all(
  //                         color: const Color.fromARGB(255, 38, 62, 105),
  //                       ),
  //                       borderRadius: BorderRadius.circular(12.0),
  //                       color: const Color.fromARGB(255, 136, 176, 245)
  //                           .withOpacity(0.2), // Set opacity here
  //                     ),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           value.toString(),
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 15,
  //                           ),
  //                         ),
  //                         SizedBox(height: 4.0),
  //                         Text(
  //                           valueDict.toString(),
  //                           style: TextStyle(
  //                             fontSize: 12,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //                 //   child: DragTarget<String>(
  //                 //     onAccept: (data) {
  //                 //       // Handle dropping here
  //                 //       print('Dropped $data onto $value');
  //                 //       // Here you can perform the desired action when an item is dropped
  //                 //       setState(() {
  //                 //         _handleDrop(data);
  //                 //       });
  //                 //     },
  //                 //     builder: (BuildContext context, List<String?> candidateData,
  //                 //             List<dynamic> rejectedData) =>
  //                 //         Container(
  //                 //       padding: EdgeInsets.all(8.0),
  //                 //       decoration: BoxDecoration(
  //                 //         border: Border.all(
  //                 //           color: const Color.fromARGB(255, 38, 62, 105),
  //                 //         ),
  //                 //         borderRadius: BorderRadius.circular(12.0),
  //                 //         color: const Color.fromARGB(255, 136, 176, 245)
  //                 //             .withOpacity(0.2), // Set opacity here
  //                 //       ),
  //                 //       child: Column(
  //                 //         crossAxisAlignment: CrossAxisAlignment.start,
  //                 //         children: [
  //                 //           Text(
  //                 //             value.toString(),
  //                 //             style: TextStyle(
  //                 //               fontWeight: FontWeight.bold,
  //                 //               fontSize: 15,
  //                 //             ),
  //                 //           ),
  //                 //           SizedBox(height: 4.0),
  //                 //           Text(
  //                 //             valueDict.toString(),
  //                 //             style: TextStyle(
  //                 //               fontSize: 12,
  //                 //             ),
  //                 //           ),
  //                 //         ],
  //                 //       ),
  //                 //     ),
  //                 //   ),
  //                 //   data: value.toString(), // Data to transfer when dropped
  //                 // );
  //               );
  //             }).toList(),
  //           ),
  //         ),
  //       ),
  //     );

  // void _handleDrop(String data) {
  //   // Add your logic here to handle the dropped item
  //   droppedItems.add(data);
  // }
}
