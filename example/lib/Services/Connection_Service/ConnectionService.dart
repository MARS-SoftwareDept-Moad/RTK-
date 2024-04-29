// ignore_for_file: file_names

import 'dart:async';

import 'package:libserialport/libserialport.dart';

import '../../Repositories/Connection_Repository/IConnectionRepository.dart';
import 'IConnectionService.dart';

class ConnectionService extends IConnectionService {
  IConnectionRepository? _connectionRepository;

  ConnectionService(IConnectionRepository repository) {
    _connectionRepository = repository;
  }
  @override
  get isRoverDisable => _connectionRepository?.isRoverDisable;
  @override
  set isRoverDisable(value) => _connectionRepository?.isRoverDisable = value;
  @override
  get isBaseStationDisable => _connectionRepository?.isBaseStationDisable;
  @override
  set isBaseStationDisable(value) =>
      _connectionRepository?.isBaseStationDisable = value;
  @override
  get fixedPositionStutus => _connectionRepository?.fixedPositionStutus;
  @override
  set fixedPositionStutus(value) =>
      _connectionRepository?.fixedPositionStutus = value;
  @override
  get surveyInStutus => _connectionRepository?.surveyInStutus;
  @override
  set surveyInStutus(value) => _connectionRepository?.surveyInStutus = value;
  @override
  get checkboxval => _connectionRepository?.checkboxval;
  @override
  set checkboxval(value) => _connectionRepository?.checkboxval = value;
  @override
  get checkboxval2 => _connectionRepository?.checkboxval2;
  @override
  set checkboxval2(value) => _connectionRepository?.checkboxval2 = value;
  @override
  get ConnectedMSGStatus => _connectionRepository?.connectedMSGStatus;
  @override
  set ConnectedMSGStatus(value) =>
      _connectionRepository?.connectedMSGStatus = value;
  @override
  get notConnectedMSG => _connectionRepository?.notConnectedMSG;
  @override
  set notConnectedMSG(value) => _connectionRepository?.notConnectedMSG = value;
  @override
  get serialPort => _connectionRepository?.serialPort;
  @override
  set serialPort(value) => _connectionRepository?.serialPort = value;
  @override
  get connection => _connectionRepository?.connection;
  @override
  set connection(value) => _connectionRepository?.connection = value;
  @override
  get getConPackets => _connectionRepository?.conPackets;
  @override
  set getConPackets(value) => _connectionRepository?.conPackets = value;
  @override
  get meters => _connectionRepository?.meters;
  @override
  set meters(value) => _connectionRepository?.meters = value;
  @override
  get values_dict => _connectionRepository?.values_dict;
  @override
  set values_dict(value) => _connectionRepository?.values_dict = value;

  @override
  get Values => _connectionRepository?.Values;
  @override
  set Values(value) => _connectionRepository?.Values = value;

  @override
  get Receive_Thread => _connectionRepository?.Receive_Thread;
  @override
  set Receive_Thread(value) => _connectionRepository?.Receive_Thread = value;
  @override
  get modetype => _connectionRepository?.modetype;
  @override
  set modetype(value) => _connectionRepository?.modetype = value;

  @override
  get subscription => _connectionRepository?.subscription;
  @override
  set subscription(value) => _connectionRepository?.subscription = value;

  @override
  get current_Packet => _connectionRepository?.current_Packet;
  @override
  set current_Packet(value) => _connectionRepository?.current_Packet = value;
  @override
  void connectingToAP() {
    if (connection?.Port != '') {
      connection!.IsConnect = !connection!.IsConnect;
      if (connection!.IsConnect) //need to connect
      {
        try {
          serialPort = SerialPort(connection!.Port);

          var config = SerialPortConfig();

          config.baudRate = connection!.BuadRate; // 115200;

          config.bits = 8;

          config.stopBits = 1;

          serialPort!.open(mode: 3);
          serialPort!.config = config;

          if (serialPort!.isOpen) {
            // connecting = true;
            notConnectedMSG = "Connected";
            // connectionService.ConnectedMSGColor = Colors.green;
            ConnectedMSGStatus = "Disconnect";
            print("connectionService.serialPort!.isOpen");
            print(serialPort!.isOpen);
            Receive_Thread =
                Timer.periodic(Duration(milliseconds: 100), Receive);
            if (isRoverDisable!)
              modetype = "BaseStation";
            else
              modetype = "Rover";
          } else {
            return;
          }
        } catch (e) {
          //code
        }
      } else //need to disconnect
      {
        modetype = "Not Connected";
        Disconnect();
      }
    }
  }

  @override
  void Receive(Timer timer) {
    // TODO: implement Receive
    _connectionRepository!.Receive(timer);
  }

  @override
  Disconnect() {
    _connectionRepository?.Disconnect();
  }

  @override
  ModesListChanged(String operationMode) {
    _connectionRepository?.ModesListChanged(operationMode);
  }

  @override
  BuadRatesListChanged(String buadRate) {
    _connectionRepository?.BuadRatesListChanged(buadRate);
  }

  var x;
  void SendFlightPlanC() {
    Timer? timer; // Create a variable to hold the timer reference

    try {
      if (isRoverDisable!) {
        x = conPackets!.packetBaseStation;
      } else {
        x = conPackets!.packetRover;
      }
      if (x.Acknowledgment <= 0) {
        // Start the timer and store the reference in the 'timer' variable
        timer = Timer.periodic(Duration(milliseconds: 201), (t) {
          if (checkboxval!) {
            getConPackets.scu_SendPacket.PositionForm = 1.0;
          } else {
            getConPackets.scu_SendPacket.PositionForm = 0.0;
          }

          if (checkboxval2!) {
            getConPackets.scu_SendPacket.DeffaltAll = 1.0;
          } else {
            getConPackets.scu_SendPacket.DeffaltAll = 0.0;
          }

          getConPackets.scu_SendPacket.ParsePacket();
          SendPacket(0, getConPackets.scu_SendPacket.packet, serialPort!);

          // Stop the timer if z > 0
          if (x.Acknowledgment > 0) {
            timer!.cancel(); // Cancel the timer when z > 0
          }
        });
      }
    } catch (Exception) {
      // Handle the exception if necessary
      // MessageBox.Show(ez.Message); /*Commented By Ahmad Alzoubi*/
    }
  }

  @override
  void SendPacket(
    int id,
    List<int> bytes,
    SerialPort serialPortConn,
  ) {
    // TODO: implement SendPacket
    _connectionRepository!.SendPacket(id, bytes, serialPortConn);
  }
}
