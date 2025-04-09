import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../datatype/data.dart';

class Listdata extends StatelessWidget{
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Datos del clima"),
      ),
      body:  StreamBuilder(
          stream: FirebaseFirestore.instance.collection('variablesTH').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
              return Center(child: Text("No hay datos disponibles"));
            }
            var climaCard = snapshot.data!.docs.map((doc){
              var data = doc.data() as Map <String, dynamic>;

              return Data(
                (data['fecha'] as Timestamp).toDate(),
                (data['humedad']).toDouble(),
                (data['temperatura']).toDouble(),
              );
            }).toList();
            return ListView.builder(
                itemCount: climaCard.length,
                itemBuilder: (context, index){
                  var varTH = climaCard[index];
                  return ListTile(
                    contentPadding: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    title: Text(
                      varTH.fecha.toString(),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Temperatura: ${varTH.temperatura}'),
                        Text('Humedad: ${varTH.humedad}'),
                      ],
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}