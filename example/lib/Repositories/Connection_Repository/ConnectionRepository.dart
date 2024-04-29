// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:fmtc_example/Models/MeterData.dart';
import 'package:libserialport/libserialport.dart';
import '../../Models/Connection.dart';
import '../../Packets/ConPackets.dart';
import 'IConnectionRepository.dart';
import 'package:convert/convert.dart';
import 'package:path/path.dart' as path;

class ConnectionRepository extends IConnectionRepository {
  static ConnectionRepository _instance = getInstance();
  static bool initialized =
      false; // Additional variable to track initialization status
  String strDataReceive = '';
  static ConnectionRepository getInstance() {
    if (!initialized) {
      _instance = ConnectionRepository._();
    }
    return _instance;
  }

  // Private constructor
  ConnectionRepository._() {
    meters = List.filled(4, MeterData());
    initialized = true;
    isRoverDisable = false;
    isBaseStationDisable = true;
    fixedPositionStutus = false;
    connectedMSGStatus = 'Connect';
    notConnectedMSG = 'Please check your serial connection';
    surveyInStutus = false;
    checkboxval = false;
    checkboxval2 = false;
    serialPort = SerialPort('COM1');
    connection = Connection();
    conPackets = ConPackets.getInstance();
    modetype = "Not connected";

    String _twoDigits(int n) => n.toString().padLeft(2, '0');

    DateTime now = DateTime.now();

    // Format the datetime as a string
    String formattedDateTime =
        "${now.year}-${_twoDigits(now.month)}-${_twoDigits(now.day)}_${_twoDigits(now.hour)}-${_twoDigits(now.minute)}-${_twoDigits(now.second)}";

    // Specify the base path
    Directory currentDirectory = Directory.current;
    print('Current working directory: ${currentDirectory.path}');

    String basePath = path.join(currentDirectory.path, 'Logs');

    // Construct the file path with the formatted datetime
    String filePath = path.join(basePath, 'log_$formattedDateTime.txt');

    logFile = File(filePath);
    logFile!.createSync();
    messageBuffer = [];
    var x;
    if (isRoverDisable!) {
      x = conPackets!.packetBaseStation;
      Values = [
        'Header', // done p10           0
        'Acknowledgment', // done p10        1
        'iTOW', // done p10         2
        'Year', //                3
        'Month', // done p40     4
        'Day of month', // done p40     5
        'Hour of day', // done p40      6
        'Minute of hour', // done p40     7

        'Seconds of minute', // p58         8
        'valid', // p58         9
        'Time accuracy ', // p58        10
        'Flag_gps', // p58          11
        'Flag2_gps', // p58          12
        'Number of satellites', //             13
        'Longitude', // p104          14
        'Latitude', //                     15
        'Height above ellipsoid', //               16
        'Height above mean sea level', //p2             17
        'Horizontal accuracy ', //p2              18
        'Vertical accuracy ', //p2               19
        'NED north velocity', //p2            20
        'NED east velocity', //                 21
        'NED down velocity', // done p10            22
        'Ground Speed', // done p10            23
        'Heading of motion', // done p10            24
        'Speed accuracy ', //                    25
        'Heading accuracy ', //                    26
        'Position DOP', //                   27
        'Heading of vehicle', // p58       28
        'Magnetic declination', //             29
        'Magnetic declination accuracy', // done p40          30
        'gpsFix', // done p40          31
        'Time to first fix', //                32
        'Milliseconds since Startup', //                     33
        'Duration', //                     34
        'Mean ECEF X', //                     35
        'Mean ECEF Y', //              36
        'Mean ECEF Z', //                 37
        'meanXHP', //                    38
        'meanYHP', //                    39
        'meanZHP', //                  40
        'Mean Accuracy', // done p40   41
        'observations', //             42
        'Validity bit', //               43
        'Active', // done p40    44
        // 'Checksum' //     45     81
      ];
    } else {
      x = conPackets!.packetRover;
      Values = [
        'Header', // done p10           0
        'Acknowledgment', // done p10        1
        'iTOW', // done p10         2
        'Year', //                3
        'Month', // done p40     4
        'Day of month', // done p40     5
        'Hour of day', // done p40      6
        'Minute of hour', // done p40     7
        'Seconds of minute', // p58         8
        'valid', // p58         9
        'Time accuracy estimate', // p58        10
        'Flag_gps', // p58          11
        'Flag2_gps', // p58          12
        'Number of satellites', //             13
        'Longitude', // p104          14
        'Latitude', //                     15
        'Height above ellipsoid', //               16
        'Height above mean sea level', //p2             17
        'Horizontal accuracy estimate', //p2              18
        'Vertical accuracy estimate', //p2               19
        'NED north velocity', //p2            20
        'NED east velocity', //                 21
        'NED down velocity', // done p10            22
        'Ground Speed', // done p10            23
        'Heading of motion', // done p10            24
        'Speed accuracy estimate', //                    25
        'Heading accuracy estimate', //                    26
        'Position DOP', //                   27
        'Heading of vehicle', // p58       28
        'Magnetic declination', //             29
        'Magnetic declination accuracy', // done p40          30
        'gpsFix', // done p40          31
        'Time to first fix', //                32
        'Milliseconds since Startup', //                     33
        'MsType',
        'Flags', // done p40    44
        'Checksum' //     45     81
      ];
    }

    Timer timer = Timer.periodic(Duration(milliseconds: 20), (t) {
      // print("MARS ROBOTICS");
      //timer for _controllers

      var x;
      if (isRoverDisable!) {
        x = conPackets!.packetBaseStation;
        values_dict = {
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
          'Checksum': x.Checksum.toString(),
        };
      } else {
        x = conPackets!.packetRover;
        values_dict = {
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
      // if (_controller45 == 1) {
      //   _controller45.text = "in progress";
      // } else {
      //   _controller45.text = "successfully finished";
      // }

      // if (_controller44 == 1) {
      //   _controller44.text = "Yes";
      // } else {
      //   _controller44.text = "No";
      // }
    });
  }
  @override
  Disconnect() {
    Receive_Thread!.cancel();
    connection!.IsConnect = false;
    serialPort!.close();
    serialPort!.dispose();
  }

  @override
  ModesListChanged(String operationMode) {
    // "Disabled", "Survey-in ", "Fixed"

    if (operationMode == 'Fixed') {
      conPackets!.rtkSendPacket?.OperationModeAll = 2.0;
      conPackets!.rtkSendPacket?.SurveyInMinimumDuration = 0.0;
      conPackets!.rtkSendPacket?.SurveyInPositionAccuracyLimit = 0.0;

      if (!checkboxval!) {
        conPackets?.rtkSendPacket?.PositionForm = 1.0;
      } else {
        conPackets?.rtkSendPacket?.PositionForm = 0.0;
      }

      fixedPositionStutus = true;
      surveyInStutus = false;
    } else if (operationMode == 'Survey-in') {
      conPackets?.rtkSendPacket?.OperationModeAll = 1.0;
      conPackets?.rtkSendPacket?.ECEFXCoordinate = 0.0;
      conPackets?.rtkSendPacket?.ECEFYCoordinate = 0.0;
      conPackets?.rtkSendPacket?.ECEFZCoordinate = 0.0;
      conPackets?.rtkSendPacket?.HighPrecisionECEFXCoordinate = 0.0;
      conPackets?.rtkSendPacket?.HighPrecisionECEFYCoordinate = 0.0;
      conPackets?.rtkSendPacket?.HighPrecisionECEFZCoordinate = 0.0;
      conPackets?.rtkSendPacket?.FixedPosition3DAccuracy = 0.0;
      fixedPositionStutus = false;
      surveyInStutus = true;
    } else {
      conPackets?.rtkSendPacket?.OperationModeAll = 0.0;
      conPackets?.rtkSendPacket?.PositionForm = 0.0;
      conPackets?.rtkSendPacket?.SurveyInMinimumDuration = 0.0;
      conPackets?.rtkSendPacket?.SurveyInPositionAccuracyLimit = 0.0;
      conPackets?.rtkSendPacket?.ECEFXCoordinate = 0.0;
      conPackets?.rtkSendPacket?.ECEFYCoordinate = 0.0;
      conPackets?.rtkSendPacket?.ECEFZCoordinate = 0.0;
      conPackets?.rtkSendPacket?.HighPrecisionECEFXCoordinate = 0.0;
      conPackets?.rtkSendPacket?.HighPrecisionECEFYCoordinate = 0.0;
      conPackets?.rtkSendPacket?.HighPrecisionECEFZCoordinate = 0.0;
      conPackets?.rtkSendPacket?.SurveyInPositionAccuracyLimit = 0.0;
      fixedPositionStutus = false;
      surveyInStutus = false;
    }
  }

  @override
  BuadRatesListChanged(String buadRate) {
    conPackets?.rtkSendPacket?.BaudRateAll = double.parse(buadRate);
  }

  @override
  SendPacket(
    int id,
    List<int> bytes,
    SerialPort serialPort_Conn,
  ) {
    // TODO: implement SendPacket

    try {
      if (serialPort_Conn.isOpen) {
        var x = Uint8List.fromList(bytes);
        serialPort!.write(Uint8List.fromList(bytes), timeout: 500);

        //  GS_sent_Logger(header, bytes, cksum, id, getFlightRecordDirectoryPath);
      }
    } catch (e) {
      //MessageBox.Show(e.Message+"From Send method");
    }
  }

  @override
  Receive(Timer timer) {
    try {
      // print("--------------Received data-----------");
      if (serialPort!.bytesAvailable > 0) {
        int bytesRead = isRoverDisable! ? 124 : 98;

        //  if (!Flag_Replay!)
        {
          // if (!serialPort!.isOpen) serialPort!.open(mode: 3);

          // Reading data from the serial port
          Uint8List receivedData = serialPort!.read(bytesRead, timeout: 0);
          strDataReceive = hex.encode(receivedData);
          serialPort!.flush();
          //Remove spaces
          strDataReceive =
              strDataReceive!.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
          // print("--------------Received data-----------");
          // print(strDataReceive);

          var Header = strDataReceive!.substring(0, 4);
          //  _addToLogFile(strDataReceive!);
          if (Header.toLowerCase() == "ccdd") {
            //checksum for Receive
            var checksum = 0;
            var message = strDataReceive!.substring(4);

            var Received_Checksum =
                int.parse(message.substring(message.length - 4), radix: 16);

            var Data = ""; //hex message without Header and checksum

            for (int i = 0; i < message.length - 4; i++) {
              Data = Data + message[i];
            }

            for (int i = 0; i < (message.length - 4); i += 2) {
              checksum += (int.parse((Data[i] + Data[i + 1]), radix: 16));
            }
            print(checksum);
            if (checksum == Received_Checksum) {
              //_addToLogFile(strDataReceive!);
              try {
                if (strDataReceive!.length > 0) {
                  if (isRoverDisable!) {
                    conPackets!.packetBaseStation!.ParsePacket(strDataReceive!);

                    int counter = 0;

                    messageBuffer!.add('$counter -' +
                        '${DateTime.now()} : ' +
                        '$strDataReceive\n');

                    counter++;
                    print(
                        "--------------------------------------Received data------------------------------------------");
                    print(strDataReceive);

                    writeMessagesToFile(logFile!, messageBuffer!);
                  } else {
                    print("Rover");
                    conPackets!.packetRover!.ParsePacket(strDataReceive!);
                  }
                }
              } catch (e) {}
            }
          }
        }
      }
      // await Thread.sleep(100);

      //   }

      // Receive_Thread!.reset();
      // Receive_Thread!.start();
    } catch (e) {}
  }

  void writeMessagesToFile(File file, List<String> messages) {
    // Open the file for writing (creates the file if it doesn't exist)
    print("**************************MSG******************");
    print(messages.length);
    if (messages.length >= 50) {
      IOSink logSink = file.openWrite(mode: FileMode.append);

      // Write each message to the file
      for (var message in messages) {
        logSink.write(message);
      }
      messageBuffer!.clear();
    }
  }
}
