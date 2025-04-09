import 'package:flutter/material.dart';

import '../datatype/data.dart';

class ListData extends StatelessWidget{
  late final List<Data> lista;
  ListData(this.lista);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del clima'),
      ),
      body: ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index){
          final item = lista[index];
          return ListTile(
            title: Text(item.ciudad),
            subtitle: Text(item.temperatura + ' ' + '\n' + item.icon+ ' ' + item.condicion ),
            leading: Image(
              image: AssetImage('assets/'+ item.imagen + '.jpg'),
              fit: BoxFit.fill,
              width: 50,
            ),
          );
        },
      ),
    );
  }
}