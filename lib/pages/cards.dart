import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../datatype/data.dart';

class Cards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text("VARIABLES DEL CLIMA"),
     ),
     body: StreamBuilder(
         stream: FirebaseFirestore.instance.collection('variablesTH').snapshots(),
         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
           if(snapshot.connectionState == ConnectionState.waiting){
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
             return Center(
               child: Text('No hay datos disponibles'),
             );
           }
           var climacard = snapshot.data!.docs.map((doc){
             var data = doc.data() as Map<String, dynamic>;
             return Data(
               (data['fecha'] as Timestamp).toDate(),
               (data['humedad']).toDouble(),
               (data['temperatura']).toDouble(),
             );

           }).toList();
           return ListView.builder(
               itemCount: climacard.length,
               itemBuilder: (context, index){
                var varTH = climacard[index];
                return Card(
                  margin: EdgeInsets.all(7),
                  elevation:  5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(varTH.fecha.toString()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Humedad: ${varTH.humedad.toStringAsFixed(1)}%"),
                        Text("Temperatura: ${varTH.temperatura.toStringAsFixed(2)}°C"),
                      ],
                    ),
                  ),
                );
               }
           );
         }
     ),
   );
  }
}