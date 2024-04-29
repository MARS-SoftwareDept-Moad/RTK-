// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';

import 'package:fmtc_example/Models/MeterData.dart';
import 'package:libserialport/libserialport.dart';
import 'package:pausable_timer/pausable_timer.dart';

import '../../Models/Connection.dart';
import '../../Packets/ConPackets.dart';

abstract class IConnectionRepository {
  bool? isRoverDisable;
  bool? isBaseStationDisable;
  bool? fixedPositionStutus;
  String? connectedMSGStatus;
  String? notConnectedMSG;
  bool? surveyInStutus;
  bool? checkboxval;
  bool? checkboxval2;
  SerialPort? serialPort;
  Connection? connection;
  ConPackets? conPackets;
  List<MeterData>? meters;
  Map<String, dynamic>? values_dict;
  List<String>? Values;
  Timer? Receive_Thread;
  String? modetype;
  StreamSubscription<Map<String, double>>? subscription;
  var current_Packet;
  List<String>? messageBuffer;
  File? logFile;
  SendPacket(int id, List<int> bytes, SerialPort serialPort_Conn);
  Receive(Timer timer);
  Disconnect();
  ModesListChanged(String operationMode);
  BuadRatesListChanged(String buadRate);
}
