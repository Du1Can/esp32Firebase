import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/records/well_known/text.dart' as ndef;

class Borrar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyBorrar();
  }

}

class _MyBorrar extends State<Borrar>{
  String statusMessage="Esperando NFC";
  String resultMessage='';


  @override
  void initState() {
    super.initState();
    borrarNFC();
  }
  Future<void>borrarNFC() async{
    try{
      var tag=await FlutterNfcKit.poll(
          timeout: Duration(seconds: 10),
          iosMultipleTagMessage: "Multiples NFC encontrados",
          iosAlertMessage: "Escanear"
      );
      if(tag.ndefWritable?? false){
        var emptyRecord=ndef.TextRecord(text: "",language: 'es');
        await FlutterNfcKit.writeNDEFRecords([emptyRecord]);
        setState(() {
          resultMessage="NFC borrado";
        });

      }else{
        setState(() {
          resultMessage="NFC borrado";
        });
      }
      await FlutterNfcKit.finish();
    }catch (e){
      setState(() {
        resultMessage="Error al escribir NFC $e";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Borrar NFC"),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            Text(statusMessage),
            SizedBox(height: 20,),
            Text(resultMessage),
          ],
        ),
      ),
    );
  }
}