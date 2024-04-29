import 'dart:typed_data';
import 'dart:math';
import 'package:convert/convert.dart';

class RTK_SendPacket {
  //BaseStation

  String Header = "AABB";
  //
  double BaudRateAll = 38400; //2 bytes --> done  [Shared]
  //
  double DeffaltAll = 0.0;
  //
  double OperationModeAll = 0.0; //1 byte --> done
  //
  //--> survey-In
  double SurveyInMinimumDuration = 0.0; //1 byte --> done
  double SurveyInPositionAccuracyLimit = 0.0; //4 bytes --> done
  //--> Fixed
  double PositionForm = 0.0; //4 bytes
  double ECEFXCoordinate = 0.00000000000000; //4 bytes
  double ECEFYCoordinate = 0.00000000000000; //4 bytes
  double ECEFZCoordinate = 0.00000000000000; //4 bytes
//
  double ECEFXCoordinateCopy = 0.00000000000000; //4 bytes
  double ECEFYCoordinateCopy = 0.00000000000000; //4 bytes
  double ECEFZCoordinateCopy = 0.00000000000000; //4 bytes

  double HighPrecisionECEFXCoordinate = 0.0; //1 byte
  double HighPrecisionECEFYCoordinate = 0.0; //1 byte
  double HighPrecisionECEFZCoordinate = 0.0; //1 byte
  double FixedPosition3DAccuracy = 0.0; //4 bytes
  // double Latitude = 0.0; //4 bytes --> done
  // double Longitude = 0.0; //4 bytes --> done
  // double Altitude = 0.0; //4 bytes --> done
  // double ThePreciseLatitude = 0.0; //1 byte
  // double ThePreciseLongitude = 0.0; //1 byte
  // double ThePreciseAltitude = 0.0; //1 byte
  // [Shared]
  double MeasurementPeriod = 0.0; //2 bytes --> done  [Shared]
  double NavigationRate = 0.0; //1 byte --> done  [Shared]
  double TimeZoneall = 0.0; //1 bytes [Shared]
  // Rover
  // double RoverBaudRate = 9600.0; //1 byte --> done
  // double MeasurementPeriodRover = 0.0; //2 bytes --> done
  // double NavigationRateRover = 0.0; //1 byte --> done
  // double TimeZoneRover = 0.0; //1 byte --> done
  int Checksum = 0; //2 bytes
  late List<int> packet;
  ParsePacket() {
    Uint8List int32bytes(int? value) =>
        Uint8List(4)..buffer.asInt32List()[0] = value!;
    // Uint8List int32bytes(int? value) =>
    // Uint8List(8)..buffer.asInt64List()[0] = value!;

    double ECEFXCoordinateCopy = ECEFXCoordinate; //4 bytes
    double ECEFYCoordinateCopy = ECEFYCoordinate; //4 bytes
    double ECEFZCoordinateCopy = ECEFZCoordinate; //4 bytes
    try {
      //Header
      packet = List.filled(39, 0);
      var header = hex.decode(Header);
      List.copyRange(packet, 0, header, 0, 2);

      var Deffalt;
      if (DeffaltAll == 0.0) Deffalt = hex.decode('00');
      if (DeffaltAll == 1.0) Deffalt = hex.decode('01');
      List.copyRange(packet, 2, Deffalt, 0, 1);

      //BaudRate
      var BaudRate;

      if (BaudRateAll == 9600.0) BaudRate = hex.decode('00');
      if (BaudRateAll == 19200.0) BaudRate = hex.decode('01');
      if (BaudRateAll == 38400.0) BaudRate = hex.decode('02');
      if (BaudRateAll == 57600.0) BaudRate = hex.decode('03');
      if (BaudRateAll == 115200.0) BaudRate = hex.decode('04');

      List.copyRange(packet, 3, BaudRate, 0, 1);
      // OperationModeAll
      var OperationMode;
      if (OperationModeAll == 0.0) OperationMode = hex.decode('00');
      if (OperationModeAll == 1.0) OperationMode = hex.decode('01');
      if (OperationModeAll == 2.0) OperationMode = hex.decode('02');
      List.copyRange(packet, 4, OperationMode, 0, 1);
      // surveyInMinimumDuration
      var surveyInMinimumDuration = int32bytes(SurveyInMinimumDuration.toInt());
      List.copyRange(packet, 5, surveyInMinimumDuration, 0, 4);
      // surveyInPositionAccuracyLimit
      var surveyInPositionAccuracyLimit =
          int32bytes((SurveyInPositionAccuracyLimit * 10000).toInt());
      List.copyRange(packet, 9, surveyInPositionAccuracyLimit, 0, 4);
      // positionForm
      var positionFormall;
      if (PositionForm == 0.0) positionFormall = hex.decode('00');
      if (PositionForm == 1.0) positionFormall = hex.decode('01');
      List.copyRange(packet, 13, positionFormall, 0, 1);

      /// HighPrecision
      ///
      if (PositionForm == 0) {
        ///  XYZ send last 2 char
        ///  print(num.toStringAsFixed(2)) ;
        var strECEFXCoordinate =
            ECEFXCoordinateCopy.toStringAsFixed(4).toString();

        HighPrecisionECEFXCoordinate = (double.parse(
            strECEFXCoordinate.substring(
                (strECEFXCoordinate.toString().length) - 2,
                strECEFXCoordinate.toString().length)));

        var highPrecisionECEFXCoordinate =
            int32bytes((HighPrecisionECEFXCoordinate).toInt());
        List.copyRange(packet, 26, highPrecisionECEFXCoordinate, 0, 1);

        //--------------------
        var strECEFYCoordinate =
            ECEFYCoordinateCopy.toStringAsFixed(4).toString();
        HighPrecisionECEFYCoordinate = (double.parse(
            strECEFYCoordinate.substring(
                (strECEFYCoordinate.toString().length) - 2,
                strECEFYCoordinate.toString().length)));
        var highPrecisionECEFYCoordinate =
            int32bytes((HighPrecisionECEFYCoordinate).toInt());
        List.copyRange(packet, 27, highPrecisionECEFYCoordinate, 0, 1);

        //--------------------
        var strECEFZCoordinate =
            ECEFZCoordinateCopy.toStringAsFixed(4).toString();
        HighPrecisionECEFZCoordinate = (double.parse(
            strECEFZCoordinate.substring(
                (strECEFZCoordinate.toString().length) - 2,
                strECEFZCoordinate.toString().length)));
        var highPrecisionECEFZCoordinate =
            int32bytes((HighPrecisionECEFZCoordinate).toInt());
        List.copyRange(packet, 28, highPrecisionECEFZCoordinate, 0, 1);

        // XYZ_ECEF
        ECEFXCoordinateCopy = (double.parse(strECEFXCoordinate.substring(
            0, (strECEFXCoordinate.toString().length) - 2)));
        ECEFYCoordinateCopy = (double.parse(strECEFYCoordinate.substring(
            0, (strECEFYCoordinate.toString().length) - 2)));
        ECEFZCoordinateCopy = (double.parse(strECEFZCoordinate.substring(
            0, (strECEFZCoordinate.toString().length) - 2)));
        var ZCoordinate = int32bytes((ECEFZCoordinateCopy).toInt());
        var XCoordinate = int32bytes((ECEFXCoordinateCopy).toInt());
        var YCoordinate = int32bytes((ECEFYCoordinateCopy).toInt());

        List.copyRange(packet, 14, XCoordinate, 0, 4);
        List.copyRange(packet, 18, YCoordinate, 0, 4);
        List.copyRange(packet, 22, ZCoordinate, 0, 4);

        // var LLA_ECEF = ConvertData.ECEFCoordinatesToBytes(
        //     new LatLng(ECEFXCoordinate, ECEFYCoordinate), ECEFZCoordinate);
        // List.copyRange(packet, 13, LLA_ECEF, 0, 12);
      } else {
        //LLA
        //send  8 and 9 char affter .
        //   var strECEFXCoordinate = ECEFXCoordinate.toStringAsFixed(4).toString();

        String slicer(String LLA_precise) {
          LLA_precise = (double.parse(LLA_precise.toString().substring(
                  (LLA_precise.toString().indexOf(".")) + 8,
                  (LLA_precise.toString().indexOf(".")) + 10)))
              .toString();
          return LLA_precise;
        }

        //----------------
        var strECEFXCoordinate =
            ECEFXCoordinateCopy.toStringAsFixed(9).toString();
        HighPrecisionECEFXCoordinate = double.parse(slicer(strECEFXCoordinate));
        var highPrecisionECEFXCoordinate =
            int32bytes((HighPrecisionECEFXCoordinate).toInt());
        List.copyRange(packet, 26, highPrecisionECEFXCoordinate, 0, 1);
        //-----------------------------------------------------------------------------
        var strECEFYCoordinate =
            ECEFYCoordinateCopy.toStringAsFixed(9).toString();
        HighPrecisionECEFYCoordinate = double.parse(slicer(strECEFYCoordinate));
        var highPrecisionECEFYCoordinate =
            int32bytes((HighPrecisionECEFYCoordinate).toInt());
        List.copyRange(packet, 27, highPrecisionECEFYCoordinate, 0, 1);

        //-----------------------------------------------------------------------------

        var strECEFZCoordinate =
            ECEFZCoordinateCopy.toStringAsFixed(4).toString();
        HighPrecisionECEFZCoordinate = (double.parse(strECEFZCoordinate
            .toString()
            .substring((strECEFZCoordinate.toString().length) - 2,
                strECEFZCoordinate.toString().length)));
        var highPrecisionECEFZCoordinate =
            int32bytes((HighPrecisionECEFZCoordinate).toInt());
        List.copyRange(packet, 28, highPrecisionECEFZCoordinate, 0, 1);

        // LLA_ECEF

        ECEFXCoordinateCopy = (double.parse(strECEFXCoordinate
            .toString()
            .substring(0, (strECEFXCoordinate.toString().indexOf(".")) + 8)));

        ECEFYCoordinateCopy = (double.parse(strECEFYCoordinate
            .toString()
            .substring(0, (strECEFYCoordinate.toString().indexOf(".")) + 8)));

        ECEFZCoordinateCopy = (double.parse(strECEFZCoordinate
            .toString()
            .substring(0, (strECEFZCoordinate.toString().length) - 2)));

        if ((ECEFXCoordinateCopy < -90)) {
          ECEFXCoordinateCopy = -90;
        } else if (ECEFXCoordinateCopy > 90) {
          ECEFXCoordinateCopy = 90;
        }

        // // Convert the double value to bytes
        // final byteData = ByteData(8);
        // byteData.setFloat64(0, value, Endian.little); // or Endian.big, depending on the byte order

        // // Create a byte list from the byte data
        // final bytes = byteData.buffer.asUint8List();

        // final stringValuex = ECEFXCoordinate.toStringAsFixed(8);.

        // final datax = ByteData(8);
        // datax.setFloat64(0, ECEFXCoordinate, Endian.little);
        // final bytesx = datax.buffer.asUint8List();
        // List.copyRange(packet, 13, bytesx, 0, 4);

        if ((ECEFYCoordinateCopy < -180)) {
          ECEFYCoordinateCopy = -180;
        } else if (ECEFYCoordinateCopy > 180) {
          ECEFYCoordinateCopy = 180;
        }

        var ZCoordinate = int32bytes((ECEFZCoordinateCopy).toInt());
        var XCoordinate =
            int32bytes((ECEFXCoordinateCopy * pow(10, 7)).toInt());
        var YCoordinate =
            int32bytes((ECEFYCoordinateCopy * pow(10, 7)).toInt());

        List.copyRange(packet, 14, XCoordinate, 0, 4);
        List.copyRange(packet, 18, YCoordinate, 0, 4);
        List.copyRange(packet, 22, ZCoordinate, 0, 4);

        // // final stringValuey = ECEFYCoordinate.toStringAsFixed(8);
        // // final datay = Uint8List.fromList(stringValuey.codeUnits);

        //   final datay = ByteData(8);
        // datay.setFloat64(0, ECEFYCoordinate, Endian.little);
        // final bytesy = datay.buffer.asUint8List();
        // List.copyRange(packet, 17, bytesy, 0, 4);

        // final stringValuez = ECEFZCoordinate.toStringAsFixed(4);
        // final dataz = Uint8List.fromList(stringValuez.codeUnits);
        //     final dataz = ByteData(8);
        // dataz.setFloat64(0, ECEFZCoordinate, Endian.little);
        // final bytesz = dataz.buffer.asUint8List();
        // List.copyRange(packet, 21, bytesz, 0, 4);
        // var LLA_ECEF = ConvertData.ECEFCoordinatesToBytes(
        //     new LatLng(ECEFXCoordinateCopy * pow(10, 7), ECEFYCoordinateCopy * pow(10, 7)), ECEFZCoordinateCopy);
        // List.copyRange(packet, 13, LLA_ECEF, 0, 12);
        print("pp");
      }

      var fixedPosition3DAccuracy =
          int32bytes((FixedPosition3DAccuracy * 10000).toInt());
      List.copyRange(packet, 29, fixedPosition3DAccuracy, 0, 4);

      // var LLA = ConvertData.CoordinatesToBytes(
      //     new LatLng(Latitude, Longitude), Altitude);
      // List.copyRange(packet, 32, LLA, 0, 12);

      // ThePreciseLatitude =
      //     (ThePreciseLatitude * 100) - (ThePreciseLatitude * 100).toInt();

      // var thePreciseLatitude = int32bytes(ThePreciseLatitude.toInt());
      // List.copyRange(packet, 44, thePreciseLatitude, 0, 1);

      // ThePreciseLongitude =
      //     (ThePreciseLongitude * 100) - (ThePreciseLongitude * 100).toInt();
      // var thePreciseLongitude = int32bytes(ThePreciseLongitude.toInt());
      // List.copyRange(packet, 45, thePreciseLongitude, 0, 1);

      // ThePreciseAltitude =
      //     (ThePreciseAltitude * 100) - (ThePreciseAltitude * 100).toInt();
      // var thePreciseAltitude = int32bytes(ThePreciseAltitude.toInt());
      // List.copyRange(packet, 46, thePreciseAltitude, 0, 1);

      var Measurement = int32bytes(MeasurementPeriod.toInt());
      List.copyRange(packet, 33, Measurement, 0, 2);

      var Navigation_Rate = int32bytes(NavigationRate.toInt());
      List.copyRange(packet, 35, Navigation_Rate, 0, 1);

      var TimeZone = int32bytes(TimeZoneall.toInt());
      List.copyRange(packet, 36, TimeZone, 0, 1);
      // var roverBaudRate;
      // if (RoverBaudRate == 9600.0) roverBaudRate = hex.decode('00');
      // if (RoverBaudRate == 19200.0) roverBaudRate = hex.decode('01');
      // if (RoverBaudRate == 38400.0) roverBaudRate = hex.decode('02');
      // if (RoverBaudRate == 57600.0) roverBaudRate = hex.decode('03');
      // if (RoverBaudRate == 115200.0) roverBaudRate = hex.decode('04');
      // List.copyRange(packet, 51, roverBaudRate, 0, 1);

      // var measurementPeriodRover = int32bytes(MeasurementPeriodRover.toInt());
      // List.copyRange(packet, 52, measurementPeriodRover, 0, 2);
      // var navigationRateRover = int32bytes(NavigationRateRover.toInt());
      // List.copyRange(packet, 54, navigationRateRover, 0, 1);
      // var timeZoneRover = int32bytes(TimeZoneRover.toInt());
      // List.copyRange(packet, 55, timeZoneRover, 0, 1);

      var checksum = 0;
      for (int i = 2; i <= 36; i++) checksum += packet[i];

      var checksums = int32bytes(checksum.toInt());

      List.copyRange(packet, 37, checksums, 0, 2);
    } catch (e) {}
  }
}
