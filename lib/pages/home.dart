import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("VARIABLES AMBIENTALES"),
      ),
      body: Center(
        child: Image.asset("assets/clima.png"),
      ),
    );
  }
  
}