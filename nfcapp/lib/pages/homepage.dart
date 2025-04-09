import 'package:flutter/material.dart';
import 'package:nfcapp/pages/borrar.dart';
import 'escribir.dart';
import 'leer.dart';

class HomePage extends StatelessWidget{
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFC"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: "Ingrese el mensaje a escribir",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    String mensaje = _textController.text;
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Escribir(mensaje: mensaje);
                    }));
                  },
                  child: Text("Escribir NFC"),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Leer();
                  }));
                }, 
                child: Text("Leer NFC")
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Borrar();
                  }));
                },
                child: Text("Borrar NFC")
            )
          ],
        ),
      ),
    );
  }
  
}