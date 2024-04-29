import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../../Services/Connection_Service/ConnectionService.dart';
import '../../../../../Services/Connection_Service/IConnectionService.dart';
import '../../../../../Repositories/Connection_Repository/ConnectionRepository.dart';
import '../../../../../Repositories/Connection_Repository/IConnectionRepository.dart';

class Packets extends StatefulWidget {
  const Packets({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PacketsState();
}

class _PacketsState extends State<Packets> {
  TextEditingController _controllerTST = TextEditingController();

  late final ConnectionService _connectionService =
      ConnectionService(ConnectionRepository.getInstance()!);

  late Timer timer;
  bool isTimerRunning = false;
  var x;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 200), (t) {
      if (_connectionService.isRoverDisable!) {
        x = _connectionService.getConPackets.packetBaseStation;
      } else {
        x = _connectionService.getConPackets.packetRover;
      }
      if (isTimerRunning) {
        setState(() {
          _insertText(ConnectionRepository.getInstance().strDataReceive!);
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isTimerRunning = !isTimerRunning;
                });
              },
              child: Text(isTimerRunning ? 'Pause' : 'Start'),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _controllerTST.clear();
                });
              },
              child: Text('Clear'),
            ),
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: TextField(
                  controller: _controllerTST,
                  maxLines: 40000,
                  minLines: 100,
                  style: TextStyle(color: Colors.black, fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      );

  void _insertText(String inserted) {
    String spacedText = '';
    for (var i = 0; i < inserted.length; i += 2) {
      if (i + 1 < inserted.length) {
        spacedText += inserted.substring(i, i + 2) + ' ';
      } else {
        spacedText += inserted.substring(i) + ' ';
      }
    }
    final text = _controllerTST.text;
    final selection = _controllerTST.selection;
    final newText = text + spacedText + "\n";
    _controllerTST.text = newText;
    _controllerTST.selection = TextSelection(
      baseOffset: newText.length,
      extentOffset: newText.length,
    );
    _controllerTST.selection = TextSelection.collapsed(
      offset: _controllerTST.text.length,
    );
    _controllerTST.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + inserted.length,
      ),
    );
  }
}
