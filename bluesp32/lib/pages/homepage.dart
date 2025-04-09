import 'package:bluesp32/pages/bluetoothpage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('BLU BLE')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Text('Dispositivos Bluethooth')
              ),
              ListTile(
                leading: Icon(Icons.bluetooth),
                title: Text('Conexión Bluetooth'),
                onTap: () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return BluetoothPage(
                              onDisconnect:(){
                                Navigator.pop(context);
                              },
                            );
                          }
                          )
                   
                      );
                },
              )
            ],
          ),
        ),
       body: Center(
         child: Text('Para conectar dispositivos Bluetooth acceda al '),
       ),
    );
  }
  
}