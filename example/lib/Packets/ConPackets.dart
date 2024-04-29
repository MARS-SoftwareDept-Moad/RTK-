// ignore_for_file: file_names
import 'RTK_ReceivedPacketBaseStation.dart';
import 'RTK_ReceivedPacketRover.dart';
import 'RTK_SendPacket.dart';

class ConPackets {
  RTK_ReceivedPacketRover? packetRover;
  RTK_ReceivedPacketBaseStation? packetBaseStation;
  RTK_SendPacket? rtkSendPacket;

  static bool initialized = false;
  static ConPackets _instance = getInstance();
  static ConPackets getInstance() {
    if (!initialized) {
      _instance = ConPackets._();
    }
    return _instance;
  }

  ConPackets._() {
    initialized = true;
    packetRover = RTK_ReceivedPacketRover();
    packetBaseStation = RTK_ReceivedPacketBaseStation();
    rtkSendPacket = RTK_SendPacket();
  }
}
