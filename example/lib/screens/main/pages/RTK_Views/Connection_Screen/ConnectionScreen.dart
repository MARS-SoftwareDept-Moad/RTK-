import 'package:flutter/material.dart';
import 'package:fmtc_example/Presenters/Connection_Presenter/ConnectionPresenter.dart';
import 'package:fmtc_example/Repositories/Connection_Repository/ConnectionRepository.dart';
import 'package:fmtc_example/Services/Connection_Service/ConnectionService.dart';

import 'package:libserialport/libserialport.dart';
import 'package:fmtc_example/screens/main/pages/update/update.dart';

class ConnectionView {
  List<String> availablePorts = [];

  String selectedPort = "";
  String selectedMode = "";
  String selectedBuadRate = "";
  List<String> BuadRates_list = [];
  List<String> Mode_list = [];
  String connect_btn_text = "";
  showSimpleDialog(BuildContext context) {}
}

class ConnectionPage extends StatefulWidget {
  // const ConnectionPage({Key? key}) : super(key: key);

  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage>
    implements ConnectionView {
  late ConnectionPresenter presenter;
  late ConnectionService connectionService =
      ConnectionService(ConnectionRepository.getInstance()!);
  List<String> availablePorts = SerialPort.availablePorts;

  String selectedPort = '';
  String selectedBuadRate = "115200";
  String selectedMode = "Rover";
  List<String> Mode_list = ["BaseStation", "Rover"];
  List<String> BuadRates_list = ["115200", "9600", "200"];

  String connect_btn_text = "Connect";

  @override
  initState() {
    presenter = ConnectionPresenter(this);
    selectedPort = availablePorts[0];
    DropdownButtonFormField(
        isExpanded: true,
        value: selectedBuadRate,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: BuadRates_list.map<DropdownMenuItem<String>>((var value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value

        onChanged: (newValue) {
          setState(() {
            selectedBuadRate = newValue.toString();
          });
        },
        onSaved: (newValue) {
          setState(() {
            selectedBuadRate = newValue.toString();
          });
          presenter.AP_Version_SelectionChanged();
        }
        //  onChanged: presenter.AP_Version_SelectionChanged(),
        );

    DropdownButtonFormField(
        isExpanded: true,
        value: selectedBuadRate,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: BuadRates_list.map<DropdownMenuItem<String>>((var value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value

        onChanged: (newValue) {
          setState(() {
            selectedBuadRate = newValue.toString();
          });
        },
        onSaved: (newValue) {
          setState(() {
            selectedBuadRate = newValue.toString();
          });
          presenter.AP_Version_SelectionChanged();
        }
        //  onChanged: presenter.AP_Version_SelectionChanged(),
        );

    DropdownButtonFormField(
        isExpanded: true,
        value: selectedPort,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: availablePorts.map<DropdownMenuItem<String>>((var value) {
          return DropdownMenuItem<String>(
            //   alignedDropdown: true,

            value: value,
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (newValue) {
          selectedPort = newValue.toString();
          setState(() {
            newValue;
            print(newValue);
          });
        },
        onSaved: (newValue) {
          setState(() {
            selectedPort = newValue.toString();
          });
        }
        //onChanged: presenter.AP_Version_SelectionChanged(),
        );

    ElevatedButton(
      child: Text(
        connectionService.ConnectedMSGStatus!.toString(),
        style: const TextStyle(
          fontSize: 10,
          // padding: MaterialStateProperty.all(const EdgeInsets.all(2)),
        ),
      ),
      onPressed: () {
        presenter.connectingToAP();
        setState(() {
          connectionService.ConnectedMSGStatus =
              connectionService.ConnectedMSGStatus!;
        });
      },
      style: ElevatedButton.styleFrom(fixedSize: Size(3, 30)),
    );

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ElevatedButton(
      child: const Text(
        'Connect',
        style: TextStyle(fontSize: 10),
      ),
      onPressed: () => showSimpleDialog(context),
    ));
  }

  @override
  showSimpleDialog(BuildContext context) {
    presenter = ConnectionPresenter(this);
    selectedPort = connectionService.connection!.Port;
    // selectedBuadRate = connectionService.connection!.BuadRate.toString();
    if (connectionService.connection!.IsConnect)
      connect_btn_text = "Disconnect";
    else
      connect_btn_text = "Connect";
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              title: const Text('Connection'),
              children: <Widget>[
                Container(
                    child: DropdownButtonFormField(
                        isExpanded: true,
                        value: selectedBuadRate,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: BuadRates_list.map<DropdownMenuItem<String>>(
                            (var value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value

                        onChanged: (newValue) {
                          setState(() {
                            selectedBuadRate = newValue.toString();
                            presenter.AP_Version_SelectionChanged();
                          });
                        },
                        onSaved: (newValue) {
                          setState(() {
                            selectedBuadRate = newValue.toString();
                          });
                        })),
                Container(
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    //value: selectedPort,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: availablePorts
                        .map<DropdownMenuItem<String>>((var value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        // Ensure newValue is not null and exists in the availablePorts list
                        if (availablePorts.contains(newValue)) {
                          selectedPort = newValue.toString();
                          print(newValue);
                        }
                      });
                    },
                    onSaved: (newValue) {
                      setState(() {
                        // Ensure newValue is not null and exists in the availablePorts list
                        if (availablePorts.contains(newValue)) {
                          selectedPort = newValue.toString();
                        }
                      });
                    },
                  ),
                ),
                Container(
                  child: DropdownButtonFormField(
                      isExpanded: true,
                      value: selectedMode,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items:
                          Mode_list.map<DropdownMenuItem<String>>((var value) {
                        return DropdownMenuItem<String>(
                          //   alignedDropdown: true,

                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (newValue) {
                        selectedMode = newValue.toString();
                        setState(() {
                          newValue;
                          print(newValue);
                        });
                      },
                      onSaved: (newValue) {
                        setState(() {
                          selectedMode = newValue.toString();
                        });
                      }
                      //onChanged: presenter.AP_Version_SelectionChanged(),
                      ),
                ),
                //
                ////
                Container(
                    child: ElevatedButton(
                        child: Text(
                          connect_btn_text.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        onPressed: () {
                          if (selectedMode == "Rover") {
                            connectionService.isRoverDisable = false;
                            connectionService.isBaseStationDisable = true;
                          } else if (selectedMode == "BaseStation") {
                            connectionService.isBaseStationDisable = false;
                            connectionService.isRoverDisable = true;
                          } else {
                            connectionService.isBaseStationDisable = true;
                            connectionService.isRoverDisable = true;
                          }
                          connectionService.connection?.Port = selectedPort;
                          connectionService.connection?.BuadRate =
                              int.parse(selectedBuadRate);
                          if (!connectionService.connection!.IsConnect)
                            presenter.connectingToAP();
                          else {
                            connectionService.Disconnect();
                          }
                          setState(() {
                            connect_btn_text =
                                connectionService.ConnectedMSGStatus!;
                          });
                          Navigator.of(context).pop();
                        }))
              ],
            );
          });
        });
  }
}
