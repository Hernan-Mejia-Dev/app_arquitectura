// ignore: file_names
import 'package:app/Conection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<BluetoothDevice> _data = [];
  bool _scanning = false;
  late BluetoothConnection connection;
  final _bluetooth = FlutterBluetoothSerial.instance;

  @override
  void initState() {
    super.initState();
    _bluetooth.requestEnable();
  }

  void _startDiscovery() {
    _bluetooth.startDiscovery().listen((r) {
      if (!_data.contains(r.device)) {
        _data.add(r.device);
      }
      setState(() {
        _scanning = true;
      });
    });
  }

  void _cancelDiscovery() {
    _bluetooth.cancelDiscovery();
    setState(() {
      _scanning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromRGBO(242, 161, 56, 1)),
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(242, 161, 56, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(241, 99, 87, 1),
          title: const Text(
            'Dispositivos Disponibles',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: size.height * 0.02,
                    left: size.height * 0.05,
                    right: size.height * 0.05,
                  ),
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MaterialButton(
                          height: size.height * 0.1,
                          color: const Color.fromRGBO(241, 99, 87, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.04),
                          ),
                          onPressed: () {
                            _cancelDiscovery();
                            _bluetooth
                                .bondDeviceAtAddress(_data[index].address);
                            MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) =>
                                    DevicePage(server: _data[index]));
                            // ignore: use_build_context_synchronously
                            Navigator.push(context, route);
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.devices, color: Colors.white),
                                Text(
                                  _data[index].name.toString().length > 15
                                      ? _data[index]
                                          .name
                                          .toString()
                                          .substring(0, 15)
                                      : _data[index].name.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.width * 0.05,
                                  ),
                                ),
                                const Icon(Icons.arrow_forward,
                                    color: Colors.white)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04)
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: MaterialButton(
                    height: size.height * 0.05,
                    padding: EdgeInsets.only(
                        left: size.height * 0.06, right: size.height * 0.06),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.04),
                    ),
                    color: const Color.fromRGBO(241, 99, 87, 1),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _scanning ? Icons.stop : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        Text(
                          _scanning ? 'Detener Escaneo' : 'Empezar Escaneo',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () async {
                      try {
                        if (_scanning) {
                          _cancelDiscovery();
                          setState(() {
                            _scanning = false;
                          });
                        } else {
                          _startDiscovery();
                          setState(() {
                            _scanning = true;
                          });
                        }
                      } on PlatformException catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
