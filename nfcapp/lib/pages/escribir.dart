import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/records/well_known/text.dart' as ndef;

class Escribir extends StatefulWidget {
  final String mensaje;

  Escribir({required this.mensaje});

  @override
  State<StatefulWidget> createState() {
    return MyEscribir();
  }
}

class MyEscribir extends State<Escribir> {
  String statusMessage = 'Esperando NFC';
  String resultMessage = '';

  @override
  void initState() {
    super.initState();
    escribirNFC();
  }

  Future<void> escribirNFC() async {
    try {
      var tag = await FlutterNfcKit.poll(
          timeout: Duration(seconds: 10),
          iosMultipleTagMessage: 'Multiples tags encontrados',
          iosAlertMessage: 'Escanea tu tag');
      if (tag.ndefWritable ?? false) {
        var textRecord = ndef.TextRecord(text: widget.mensaje, language: "español");
        await FlutterNfcKit.writeNDEFRecords([textRecord]);
        setState(() {
          resultMessage = "Mensaje Escrito: ${widget.mensaje}";
        });
      } else {
        setState(() {
          resultMessage = "No se puede escribir";
        });
      }
      await FlutterNfcKit.finish();
    } catch (e) {
      setState(() {
        resultMessage = "Error escribir NFC $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Escribir NFC'),
        ),
        body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text(statusMessage),
              SizedBox(height: 20),
              Text(resultMessage),
            ])));
  }
}
