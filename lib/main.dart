import 'package:app/Scan_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: const Color.fromRGBO(242, 161, 56, 1)),
        home: const FirstPage(),
        );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(242, 161, 56, 1),
        body: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: Text(
                  "Parcial - arquitectura",
                  style: TextStyle(
                    color: const Color.fromRGBO(241, 99, 87, 1),
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: size.height * 0.04),
                height: size.height * 0.65,
                child: const Image(image: AssetImage("lib/img/logo.png")),
              ),
              Container(
                width: size.width * 0.5,
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width*0.1)
                  ),
                  color: const Color.fromRGBO(241, 99, 87, 1),
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) =>  const BluetoothScreen()
                      );
                    Navigator.push(context, route);
                  },
                  textColor: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bluetooth),
                      Text(
                        "CONECTATE",
                        style: TextStyle(fontSize: size.width * 0.05),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}