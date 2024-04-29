import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';

class MyTableWidgetRXM extends StatefulWidget {
  @override
  _MyTableWidgetState createState() => _MyTableWidgetState();
}

class _MyTableWidgetState extends State<MyTableWidgetRXM> {
  final List<List<String>> tableData = [
    // ['Gps time Tag', '00', '[s]'],
    ['1005', 'Stationary RTK reference station ARP', '', '', ''],
    ['1077', 'GPS Observation', '', '', ''],
    ['1087', 'GLONASS Observation', '', '', ''],
    ['1097', 'Galileo Observation', '', '', ''],
    ['1127', 'BeiDou Observation', '', '', ''],
    ['1230', 'code-phase biases', '', '', ''],

    // Add more rows as needed
  ];

  Timer? _timer;

  //not used
  Random _random = Random();
    //not used

  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      // Update the value in the tableData list
      setState(() {
        var x;
        setState(() {
          setState(() {});
          if (_connectionService.isRoverDisable!) {
            x = _connectionService.getConPackets.packetBaseStation;
            //   tableData[0][1] = x.Year.toString() +
            //       "/" +
            //       x.Month.toInt().toString() +
            //       "/" +
            //       x.DayOfMonth.toInt().toString() +
            //       " --  -- " +
            //       x.HourOfDay.toInt().toString() +
            //       ":" +
            //       x.MinuteOfHour.toInt().toString() +
            //       ":" +
            //       x.SecondsOfMinute.toInt().toString();
            //   if (x.Flag_gps == 0) {
            //     tableData[1][1] = "Date: NOT CONFIRMED, Time: NOT CONFIRMED";
            //   } else {
            //     tableData[1][1] = "Date: CONFIRMED, Time: CONFIRMED";
            //   }
            //   tableData[2][1] = x.TimeAccuracyEstimate.toString();
            //   tableData[3][1] = x.gpsFix.toString();
            //   tableData[6][1] = x.Longitude.toString() +
            //       "  " +
            //       x.Longitude.toString() +
            //       "  " +
            //       x.Latitude.toString() +
            //       " " +
            //       x.HeightAboveEllipsoid.toString() +
            //       "  " +
            //       x.HeightAboveMeanSeaLevel.toString();
            //   tableData[7][1] = x.HorizontalAccuracyEstimate.toString() +
            //       "  " +
            //       x.VerticalAccuracyEstimate.toString();
            //   tableData[8][1] = x.NED_NorthVelocity.toString() +
            //       "  " +
            //       x.NED_EastVelocity.toString() +
            //       "  " +
            //       x.NED_DownVelocity.toString();
            //   tableData[9][1] = x.HorizontalAccuracyEstimate.toString() +
            //       "  " +
            //       x.VerticalAccuracyEstimate.toString();
            // } else {
            //   x = _connectionService.getConPackets.packetRover;
            //   // _controller33.text = x.Longitude.toString();
          }
        });
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: PaginatedDataTable(
        header: Text('Statistics:'),
        headingRowHeight: 35,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Message Type'),
          ),
          DataColumn(
            label: Text('Type of message'),
          ),
          DataColumn(
            label: Text('Total messages'),
          ),
          DataColumn(
            label: Text('CRC passed messages'),
          ),
          DataColumn(
            label: Text('CRC failed messages'),
          ),
        ],
        source: MyTableDataSource(tableData),
      ),
    );
}

class MyTableDataSource extends DataTableSource {
  final List<List<String>> _tableData;

  MyTableDataSource(this._tableData);

  @override
  DataRow? getRow(int index) {
    if (index >= _tableData.length) {
      return null;
    }

    final rowData = _tableData[index];

    return DataRow.byIndex(
      index: index,
      cells: List<DataCell>.generate(
        rowData.length,
        (cellIndex) => DataCell(
          Text(rowData[cellIndex]),
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _tableData.length;

  @override
  int get selectedRowCount => 0;
}
