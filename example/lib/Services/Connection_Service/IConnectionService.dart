// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fmtc_example/Models/MeterData.dart';
import 'package:libserialport/libserialport.dart';
import 'package:pausable_timer/pausable_timer.dart';

import '../../Models/Connection.dart';
import '../../Packets/ConPackets.dart';
import '../../Packets/RTK_ReceivedPacketBaseStation.dart';

abstract class IConnectionService {
  List<MeterData>? meters;
  bool? isRoverDisable;
  bool? isBaseStationDisable;
  bool? fixedPositionStutus;
  Color? ConnectedMSGColor;
  String? connectedMSGStatus;
  String? notConnectedMSG;
  bool? surveyInStutus;
  bool? checkboxval;
  bool? checkboxval2;
  SerialPort? serialPort;
  Connection? connection;
  ConPackets? conPackets;
  Map<String, dynamic>? values_dict;
  List<String>? Values;
  Timer? Receive_Thread;
  String? modetype;
  StreamSubscription<Map<String, double>>? subscription;
  connectingToAP();
  Disconnect();
  Receive(Timer timer);
  ModesListChanged(String operationMode);
  BuadRatesListChanged(String buadRate);
  void SendPacket(
    int id,
    List<int> bytes,
    SerialPort serialPortConn,
  );
}
