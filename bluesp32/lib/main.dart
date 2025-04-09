import 'package:bluesp32/pages/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Bluetooth BLE',
      theme: ThemeData(
        primaryColor: Colors.amber
      ),
      home: HomePage(),
    );
  }

}