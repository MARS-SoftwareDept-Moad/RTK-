// ignore_for_file: file_names

import 'dart:async';
import 'dart:math';
import 'IPacket.dart';

class RTK_ReceivedPacketBaseStation extends IPacket {

    StreamController<Map<String, double>> _controller =
      StreamController<Map<String, double>>();

  Stream<Map<String, double>> get stream => _controller.stream;

  String Header = "CCDD"; //2 byte
  double Acknowledgment = 0.0; //1 byte
  double iTOW = 0.0; //4 byte
  double Year = 0.0; //2 byte
  double Month = 0.0; //1 byte
  double DayOfMonth = 0.0; //1 byte
  double HourOfDay = 0.0; //1 byte
  double MinuteOfHour = 0.0; //1 byte
  double SecondsOfMinute = 0.0; //1 byte
  double valid = 0.0; //1 byte
  double TimeAccuracyEstimate = 0.0; //4 byte
  double Flag_gps = 0.0; //1 byte
  double Flag2_gps = 0.0; //1 byte
  double NumberOfSatellitesUsedInNavSolution = 0.0; //1 byte
  double Longitude = 0.0; //4 byte
  double Latitude = 0.0; //4 byte
  double HeightAboveEllipsoid = 0.0; //4 byte
  double HeightAboveMeanSeaLevel = 0.0; //4 byte
  double HorizontalAccuracyEstimate = 0.0; //4 byte
  double VerticalAccuracyEstimate = 0.0; //4 byte
  double NED_NorthVelocity = 0.0; //4 byte
  double NED_EastVelocity = 0.0; //4 byte
  double NED_DownVelocity = 0.0; //4 byte
  double GroundSpeed = 0.0; //4 byte
  double HeadingOfMotion = 0.0; //4 byte
  double SpeedAccuracyEstimate = 0.0; //4 byte
  double HeadingAccuracyEstimate = 0.0; //4 byte
  double PositionDOP = 0.0; //2 byte
  double HeadingOfVehicle = 0.0; //4 byte
  double MagneticDeclination = 0.0; //2 byte
  double MagneticDeclinationAccuracy = 0.0; //2 byte
  double gpsFix = 0.0; //1 byte
  double TimeToFirstFix = 0.0; //4 byte
  double MillisecondsSinceStartup = 0.0; //4 byte
  double Duration = 0.0; //4 byte
  double Mean_X = 0; //4 byte
  double Mean_Y = 0.0; //4 byte
  double Mean_Z = 0.0; //4 byte
  double meanXHP = 0.0; //1 byte
  double meanYHP = 0.0; //1 byte
  double meanZHP = 0.0; //1 byte
  double MeanAccuracy = 0.0; //4 byte
  double Observations = 0.0; //4 byte
  double ValidityBit = 0.0; //1 byte
  double Active = 0.0; //1 byte
  double Checksum = 0.0; //2 byte

  @override
  ParsePacket(String packet) {
    try {
      String slicer(int start, int end) {
        var text = packet.substring(start, end).toString();

        String reverseUsingCodeUnits(String text) {
          final chars = text.codeUnits;
          var slice = String.fromCharCodes(chars.reversed);

          return slice;
        }

        text = reverseUsingCodeUnits(text);
        var message = "";

        for (var i = 0; i < text.length - 1; i = i + 2) {
          message += reverseUsingCodeUnits((text[i] + text[i + 1]));
        }
        var sliced;
        if (message == "") {
          sliced = int.parse(text, radix: 16).toString();
        } else {
          sliced = int.parse(message, radix: 16).toString();
        }

        return sliced;
      }

      // int.parse(message.substring(240), radix: 16);
      Acknowledgment = double.parse(slicer(4, 6)); //0-1

      iTOW = double.parse(slicer(6, 14));

      Year = double.parse(slicer(14, 18));

      Month = double.parse(slicer(18, 20));

      DayOfMonth = double.parse(slicer(20, 22));

      HourOfDay = double.parse(slicer(22, 24));

      MinuteOfHour = double.parse(slicer(24, 26));

      SecondsOfMinute = double.parse(slicer(26, 28));

      valid = double.parse(slicer(28, 30));

      TimeAccuracyEstimate = double.parse(slicer(30, 38));

      Flag_gps = double.parse(slicer(38, 40));

      Flag2_gps = double.parse(slicer(40, 42));

      NumberOfSatellitesUsedInNavSolution = double.parse(slicer(42, 44));

      //lon-lat the value in 1e-7 scale.
      Longitude = double.parse(slicer(44, 52)) * pow(10, -7);

      Latitude = double.parse(slicer(52, 60)) * pow(10, -7);

      ///
      HeightAboveEllipsoid = double.parse(slicer(60, 68)) * 0.001;

      HeightAboveMeanSeaLevel = double.parse(slicer(68, 76)) * 0.001;

      HorizontalAccuracyEstimate = double.parse(slicer(76, 84)) * 0.001;

      VerticalAccuracyEstimate = double.parse(slicer(84, 92)) * 0.001;

      NED_NorthVelocity = double.parse(slicer(92, 100)) * 0.001;

      NED_EastVelocity = double.parse(slicer(100, 108)) * 0.001;

      NED_DownVelocity = double.parse(slicer(108, 116)) * 0.001;

      GroundSpeed = double.parse(slicer(116, 124)) * 0.001;

      SpeedAccuracyEstimate = double.parse(slicer(132, 140));

      PositionDOP = double.parse(slicer(148, 152)) * 0.01;

      HeadingOfMotion = double.parse(slicer(124, 132)) * 0.00001;

      HeadingAccuracyEstimate = double.parse(slicer(140, 148)) * pow(10, -7);

      HeadingOfVehicle = double.parse(slicer(152, 160)) * pow(10, -7);

      MagneticDeclination = double.parse(slicer(160, 164));

      MagneticDeclinationAccuracy = double.parse(slicer(164, 168)) * 0.01;

      gpsFix = double.parse(slicer(168, 170));

      TimeToFirstFix = double.parse(slicer(170, 178));

      MillisecondsSinceStartup = double.parse(slicer(178, 186));

      Duration = double.parse(slicer(186, 194));

      Mean_X = double.parse(slicer(194, 202)) / 100;

      Mean_Y = double.parse(slicer(202, 210)) / 100;

      Mean_Z = double.parse(slicer(210, 218)) / 100;

      meanXHP = double.parse(slicer(218, 220));

      meanYHP = double.parse(slicer(220, 222));

      meanZHP = double.parse(slicer(222, 224));

      MeanAccuracy = double.parse(slicer(224, 232)) * 0.0001;

      Observations = double.parse(slicer(232, 240));

      ValidityBit = double.parse(slicer(240, 242));

      Active = double.parse(slicer(242, 244));
       updateUI();
    } catch (e) {
      print("catch");
    }
  }
   updateUI() {
    _controller.add({'Acknowledgment': Acknowledgment});
  }
}
