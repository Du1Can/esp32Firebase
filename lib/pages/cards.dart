
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
               data['uID']=doc.id,
               data['fecha']??"", //sino no tiene datos pone ""
               data['humedad']??"",
               data['temperatura']??"",
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
                    title: Text(varTH.fecha),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Humedad: ${varTH.humedad}"),
                        Text("Temperatura: ${varTH.temperatura}°C"),
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