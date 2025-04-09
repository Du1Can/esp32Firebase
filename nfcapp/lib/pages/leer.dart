import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/records/well_known/text.dart' as ndef;

class Leer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyLeer();
  }
}

class MyLeer extends State<Leer> {
  String resultMessage = "Escanea tu tarjeta NFC";

  @override
  void initState() {
    super.initState();
    leerNfc();
  }

  Future<void> leerNfc() async {
    try {
      while (mounted) {
        var tag = await FlutterNfcKit.poll(
          timeout: Duration(seconds: 10),
          iosMultipleTagMessage: "Escanea tu tarjeta NFC",
          iosAlertMessage: "Escanea tu tarjeta NFC",
        );

        if(tag.ndefAvailable?? false){
          var record=await FlutterNfcKit.readNDEFRecords(
              cached: false
          );
          for(var record in record){
            if(record is ndef.TextRecord){
              setState(() {
                resultMessage="Texto leido: ${record.text}";
              });
              await FlutterNfcKit.finish();
              return;
            }
          }

          setState(() {
            resultMessage = "No se encontró texto en el tag";
          });
        } else {
          setState(() {
            resultMessage = "El tag no tiene datos en el formato NDEF";
          });
        }

        await FlutterNfcKit.finish();
      }
    } catch (e) {
      setState(() {
        resultMessage = "Error al leer NFC: ${e.toString()}";
      });
      await FlutterNfcKit.finish();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lector NFC"),
      ),
      body: Center(
        child: Text(
          resultMessage,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}