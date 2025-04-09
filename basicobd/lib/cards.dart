import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dataType/data.dart';

class Cards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del clima'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('clima').snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return Center(
              child: Text('No hay datos disponibles'),
            );
          }
          var climaCard = snapshot.data!.docs.map((doc){
            var data = doc.data() as Map<String, dynamic>;
            return Data(
              data['ciudad']??'',
              data['temperatura']??'',
              data['condicion']??'',
              data['icon']??'',
              data['imagen']??'',
            );
          }).toList();
          return ListView.builder(
              itemCount: climaCard.length,
              itemBuilder: (context, index){
                var ciudad = climaCard[index];
                return Card(
                  margin: EdgeInsets.all(7),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(ciudad.imagen),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(ciudad.ciudad),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Temperatura: ${ciudad.temperatura}'),
                        Text('Condicion: ${ciudad.condicion}${ciudad.icon}'),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Placeholder();
                          //return Details(data:ciudad);
                        }));
                      },
                      child: Icon(Icons.info_outline),
                    ),
                  ),
                );
              }
          );
        },
      ),
    );
  }

}