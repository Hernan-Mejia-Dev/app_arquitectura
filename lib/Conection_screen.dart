// ignore: file_names
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

// ignore: must_be_immutable
class DevicePage extends StatefulWidget {
  final BluetoothDevice server;

  const DevicePage({super.key, required this.server});

  @override
  _DevicePage createState() => _DevicePage();
}

class _DevicePage extends State<DevicePage> {
  BluetoothConnection? connection;

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((connection) {
      print('Connected to the device');
      this.connection = connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  void _sendMessage(String text) async {
    text = text.trim();
    if (text.isNotEmpty) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));
      } catch (e) {
        // Ignore error, but notify state
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      backgroundColor: const Color.fromRGBO(242, 161, 56, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: size.height * 0.19,
          ),
          Center(
            child: Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(241, 99, 87, 1),
                  borderRadius: BorderRadius.circular(size.width * 0.1)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.01),
                    Text(
                      "Puerta",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.035
                      ),
                    ),
                    SizedBox(height: size.height*0.01)
                    ,
                    LiteRollingSwitch(
                      width: size.width * 0.55,
                      textOff: "Off",
                      textOn: "On",
                      textOffColor: Colors.white,
                      textOnColor: Colors.white,
                      colorOff: Colors.grey,
                      colorOn: Colors.green,
                      iconOff: Icons.dnd_forwardslash,
                      onChanged: (bool pos) {
                        if (pos) {
                          _sendMessage('1');
                        } else {
                          _sendMessage('2');
                        }
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),SizedBox(height: size.height*0.01)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(241, 99, 87, 1),
                  borderRadius: BorderRadius.circular(size.width * 0.1)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.01),
                    Text(
                      "Piso 1 y 2",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.035
                      ),
                    ),
                    SizedBox(height: size.height*0.01)
                    ,
                    LiteRollingSwitch(
                      width: size.width * 0.55,
                      textOff: "Off",
                      textOn: "On",
                      textOffColor: Colors.white,
                      textOnColor: Colors.white,
                      colorOff: Colors.grey,
                      colorOn: Colors.green,
                      iconOff: Icons.dnd_forwardslash,
                      onChanged: (bool pos) {
                        if (pos) {
                          _sendMessage('3');
                        } else {
                          _sendMessage('4');
                        }
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),SizedBox(height: size.height*0.01)
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Center(
            child: Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(241, 99, 87, 1),
                  borderRadius: BorderRadius.circular(size.width * 0.1)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: size.height*0.01),
                    Text(
                      "Piso 3 y 4",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.035
                      ),
                    ),
                    SizedBox(height: size.height*0.01)
                    ,
                    LiteRollingSwitch(
                      width: size.width * 0.55,
                      textOff: "Off",
                      textOn: "On",
                      textOffColor: Colors.white,
                      textOnColor: Colors.white,
                      colorOff: Colors.grey,
                      colorOn: Colors.green,
                      iconOff: Icons.dnd_forwardslash,
                      onChanged: (bool pos) {
                        if (pos) {
                          _sendMessage('5');
                        } else {
                          _sendMessage('6');
                        }
                      },
                      onDoubleTap: () {},
                      onSwipe: () {},
                      onTap: () {},
                    ),SizedBox(height: size.height*0.01)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
