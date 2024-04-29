// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fmtc_example/screens/main/pages/RTK_Views/Connection_Screen/ConnectionScreen.dart';
import 'package:libserialport/libserialport.dart';
import 'package:pausable_timer/pausable_timer.dart';
import '../../Repositories/Connection_Repository/ConnectionRepository.dart';
import '../../Services/Connection_Service/ConnectionService.dart';
import 'IConnectionPresenter.dart';

class ConnectionPresenter extends IConnectionPresenter {
  ConnectionService connectionService =
      ConnectionService(ConnectionRepository.getInstance());

  late ConnectionView _view;
  ConnectionPresenter(ConnectionView value) {
    _view = value;
    connectionService = ConnectionService(ConnectionRepository.getInstance());
  }

  @override
  ConnectionLoad() {}
  @override
  ButtonConnectClick() {}
  @override
  void AP_Version_SelectionChanged() {}
  void connectingToAP() {
    connectionService.connectingToAP();
  }
}
