import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final List<Map<String, String>> climacard = [
    {
      "ciudad": "Durango",
      "temperatura": "15°C",
      "condicion": "soleado",
      "icon": "☀️",
    },
    {
      "ciudad": "Monterrey",
      "temperatura": "5°C",
      "condicion": "nublado",
      "icon": "☁️",
    },
    {
      "ciudad": "Chihuahua",
      "temperatura": "6°C",
      "condicion": "soleado",
      "icon": "🌤️",
    },
    {
      "ciudad": "Zacatecas",
      "temperatura": "2°C",
      "condicion": "lluvioso",
      "icon": "🌧️",
    },
    {
      "ciudad": "Mazatlán",
      "temperatura": "25°C",
      "condicion": "Muy soleado",
      "icon": "☀️",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: climacard.length,
        itemBuilder: (context, index) {
          final ciudad = climacard[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.yellow[50],
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.lightBlue.shade100,
                child: Text(
                  ciudad["icon"]!,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              title: Text(
                ciudad["ciudad"]!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Temperatura: ${ciudad["temperatura"]}"),
                  Text("Condición: ${ciudad["condicion"]}"),
                ],
              ),
              trailing: Icon(
                Icons.info_outline,
                color: Colors.lightGreen,
              ),
            ),
          );
        },
      ),
    );
  }
}