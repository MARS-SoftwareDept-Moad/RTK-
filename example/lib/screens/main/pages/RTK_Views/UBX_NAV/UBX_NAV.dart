import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';

class MyTableWidget extends StatefulWidget {
  @override
  _MyTableWidgetState createState() => _MyTableWidgetState();
}

class _MyTableWidgetState extends State<MyTableWidget> {
  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance()!);

  List<List<String>> tableData = [
    // ['Gps time Tag', '00', '[s]'],
    ['UTC Date and Time', '00', ''],
    ['UTC Date and Time Confirmation Status', 'null', ''],
    ['UTC Time Accuracy', '0', '[ns]'],
    ['Position Fix Accuracy', 'null', ''],
    ['Fix Flags', 'null', ''],
    // ['PSM state', 'null', ''],
    ['Position Latitude, Longitude, Height, MSL', '0,0,0,0', '[deg,deg,m,m]'],
    // ['Invalid Position Latitude, Longitude, Height, MSL', 'null', ''],
    ['Position Accuracy Estimate Horizontal, Vertical', '00,00', '[m,m]'],
    ['Velocity, Heading Accuracy Estimate', '00,00,00', '[m/s,m/s,m/s]'],
    ['Velocity, Heading Accuracy Estimate', '00,00', '[m/s,deg]'],
    ['Speed over Ground', '00', '[m/s]'],
    ['Heading of Motion, Heading of Vehicle', 'null,null', '[deg,deg]'],
    [
      'Magnetic Declination. Declination Accuracy Estimate',
      'null,null',
      '[deg,deg]'
    ],
    ['PDOP', '00', ''],
    ['#SVs Used', '00', ''],
    ['Carrier Range Status', 'null', ''],
    // [
    //   'Age of the most recently received differential correction',
    //   'null',
    //   '[sec]'
    // ],
    // Add more rows as needed
  ];

  Timer? _timer;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    tableData = [
      // ['Gps time Tag', '00', '[s]'],
      [
        'UTC Date and Time',
        _connectionService.current_Packet.Year.toString() +
            "/" +
            _connectionService.current_Packet.Month.toInt().toString() +
            "/" +
            _connectionService.current_Packet.DayOfMonth.toInt().toString() +
            " --  -- " +
            _connectionService.current_Packet.HourOfDay.toInt().toString() +
            ":" +
            _connectionService.current_Packet.MinuteOfHour.toInt().toString() +
            ":" +
            _connectionService.current_Packet.SecondsOfMinute
                .toInt()
                .toString(),
        ''
      ],
      [
        'UTC Date and Time Confirmation Status',
        (_connectionService.current_Packet.Flag_gps == 0)
            ? "Date: NOT CONFIRMED, Time: NOT CONFIRMED"
            : "Date: CONFIRMED, Time: CONFIRMED",
        ''
      ],
      [
        'UTC Time Accuracy',
        _connectionService.current_Packet.TimeAccuracyEstimate.toString(),
        '[ns]'
      ],
      [
        'Position Fix Accuracy',
        _connectionService.current_Packet.gpsFix.toString(),
        ''
      ],
      ['Fix Flags', 'null', ''],

      [
        'Position Latitude, Longitude, Height, MSL',
        _connectionService.current_Packet.Longitude.toString() +
            "  " +
            _connectionService.current_Packet.Longitude.toString() +
            "  " +
            _connectionService.current_Packet.Latitude.toString() +
            " " +
            _connectionService.current_Packet.HeightAboveEllipsoid.toString() +
            "  " +
            _connectionService.current_Packet.HeightAboveMeanSeaLevel
                .toString(),
        '[deg,deg,m,m]'
      ],
      // ['Invalid Position Latitude, Longitude, Height, MSL', 'null', ''],
      [
        'Position Accuracy Estimate Horizontal, Vertical',
        _connectionService.current_Packet.HorizontalAccuracyEstimate
                .toString() +
            "  " +
            _connectionService.current_Packet.VerticalAccuracyEstimate
                .toString(),
        '[m,m]'
      ],
      [
        'Velocity, Heading Accuracy Estimate',
        _connectionService.current_Packet.NED_NorthVelocity.toString() +
            "  " +
            _connectionService.current_Packet.NED_EastVelocity.toString() +
            "  " +
            _connectionService.current_Packet.NED_DownVelocity.toString(),
        '[m/s,m/s,m/s]'
      ],
      [
        'Velocity, Heading Accuracy Estimate',
        _connectionService.current_Packet.HorizontalAccuracyEstimate
                .toString() +
            "  " +
            _connectionService.current_Packet.VerticalAccuracyEstimate
                .toString(),
        '[m/s,deg]'
      ],
      ['Speed over Ground', '00', '[m/s]'],
      ['Heading of Motion, Heading of Vehicle', 'null,null', '[deg,deg]'],
      [
        'Magnetic Declination. Declination Accuracy Estimate',
        'null,null',
        '[deg,deg]'
      ],
      ['PDOP', '00', ''],
      ['#SVs Used', '00', ''],
      ['Carrier Range Status', 'null', ''],
      // [
      //   'Age of the most recently received differential correction',
      //   'null',
      //   '[sec]'
      // ],
      // Add more rows as needed
    ];

    // _startTimer();
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
            tableData[0][1] = x.Year.toString() +
                "/" +
                x.Month.toInt().toString() +
                "/" +
                x.DayOfMonth.toInt().toString() +
                " --  -- " +
                x.HourOfDay.toInt().toString() +
                ":" +
                x.MinuteOfHour.toInt().toString() +
                ":" +
                x.SecondsOfMinute.toInt().toString();
            if (x.Flag_gps == 0) {
              tableData[1][1] = "Date: NOT CONFIRMED, Time: NOT CONFIRMED";
            } else {
              tableData[1][1] = "Date: CONFIRMED, Time: CONFIRMED";
            }
            tableData[2][1] = x.TimeAccuracyEstimate.toString();
            tableData[3][1] = x.gpsFix.toString();
            tableData[6][1] = x.Longitude.toString() +
                "  " +
                x.Longitude.toString() +
                "  " +
                x.Latitude.toString() +
                " " +
                x.HeightAboveEllipsoid.toString() +
                "  " +
                x.HeightAboveMeanSeaLevel.toString();
            tableData[7][1] = x.HorizontalAccuracyEstimate.toString() +
                "  " +
                x.VerticalAccuracyEstimate.toString();
            tableData[8][1] = x.NED_NorthVelocity.toString() +
                "  " +
                x.NED_EastVelocity.toString() +
                "  " +
                x.NED_DownVelocity.toString();
            tableData[9][1] = x.HorizontalAccuracyEstimate.toString() +
                "  " +
                x.VerticalAccuracyEstimate.toString();
          } else {
            x = _connectionService.getConPackets.packetRover;
            // _controller33.text = x.Longitude.toString();
          }
        });
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: PaginatedDataTable(
        header: Text('UBX-NAV'),
        headingRowHeight: 35,
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Param'),
          ),
          DataColumn(
            label: Text('Value'),
          ),
          DataColumn(
            label: Text('Units'),
          ),
        ],
        source: MyTableDataSource(tableData),
      ),
    );
  }
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
