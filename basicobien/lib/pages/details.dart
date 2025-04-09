import 'package:flutter/material.dart';
class Details extends StatelessWidget {
  final Map<String, String> ciudad;

  const Details({super.key, required this.ciudad});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ciudad["ciudad"]!),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  ciudad["imagen"]!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                ciudad["ciudad"]!,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Temperatura: ${ciudad["temperatura"]}",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                "Condición: ${ciudad["condicion"]}",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.lightBlue.shade100,
                child: Text(
                  ciudad["icon"]!,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}