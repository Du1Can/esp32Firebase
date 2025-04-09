import 'package:basicobien/pages/listdata.dart';
import 'package:flutter/material.dart';
import 'package:basicobien/datatype/data.dart';

class Forms extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyForm();
  }
  
}

class _MyForm extends State<Forms> {
  final _controladorCiud = TextEditingController();
  final _controladorTemp = TextEditingController();
  final _controladorCond = TextEditingController();
  final _controladorIcon = TextEditingController();
  final _controladorImagen = TextEditingController();
  List<Data> _datos = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Clima"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorCiud,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ciudad"
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorTemp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Temperatura"
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorCond,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Condición"
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorIcon,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Icon (Ejemplo ☀️)",
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            TextField(
              controller: _controladorImagen,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nombre imagen",
              ),
            ),
            Padding(padding: EdgeInsets.all(20.0)),
            ElevatedButton(
                onPressed: () {
                  if (validarNombre(_controladorCiud.text)) {
                    setState(() {
                      _datos.add(Data(
                          _controladorCiud.text,
                          _controladorTemp.text,
                          _controladorCond.text,
                          _controladorIcon.text,
                          _controladorImagen.text
                      ));
                    });
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) {
                          return ListData(_datos);
                        })
                    );
                  } else {
                    alerta(context);
                  }
                },
                child: Text("Enviar")
            )
          ],
        ),
      ),
    );
  }
}
bool validarNombre(String cadena){
  RegExp exp = RegExp(r'^[a-zA-Z]+$');
  if(cadena.isEmpty){
    return false;
  } else if(!exp.hasMatch(cadena)){
    return false;
  }else{
    return true;
  }
}

void alerta(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('¡Alerta!'),
        content: Text('Verifique la información ingresada.'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Aceptar'),
          ),
        ],
      );
    },
  );
}