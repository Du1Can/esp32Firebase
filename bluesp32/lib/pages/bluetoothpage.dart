import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notificaciones.dart';

class BluetoothPage extends StatefulWidget {
  final Function onDisconnect;
  const BluetoothPage({Key? key, required this.onDisconnect}) : super(key: key);

  @override
  _BluetoothPageState createState() {
    return _BluetoothPageState();
  }
}

class _BluetoothPageState extends State<BluetoothPage> {
//  final FlutterBluePlus _flutterBlue = FlutterBluePlus();
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _readCharacteristic;
  bool _isScanning = false;

  List<String> datosrecibidos = [];

  @override
  void initState() {
    super.initState();
    requestPermissions();
    NotificationService.initialize();
    startScan();
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }

  Future<void> requestPermissions() async {
    final statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();

    if (Platform.isAndroid && await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    if (statuses.values.every((status) => status.isGranted)) {
      print("Todos los permisos fueron otorgados");
    } else {
      print("Sin permisos  otorgados");
    }
  }

  Future<void> startScan() async {
    if (_isScanning) return;

    setState(() {
      _isScanning = true;
      _devicesList.clear();
    });

    FlutterBluePlus.startScan(timeout: Duration(seconds: 8));

    FlutterBluePlus.scanResults.listen((results) {
      if (!mounted) return;
      setState(() {
        _devicesList = results
            .where((result) => result.device.platformName.isNotEmpty)
            .map((result) => result.device)
            .toList();
      });
      for (ScanResult result in results) {
        print('Dispositivo encontrado: ${result.device.platformName}');
      }
    });

    FlutterBluePlus.isScanning.listen((isScanning) {
      if (!mounted) return;
      if (!isScanning) {
        setState(() {
          _isScanning = false;
        });
        print('Escaneo terminado');
      }
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      setState(() {
        _connectedDevice = device;
      });
      print("Conectado al dispositivo: ${device.platformName}");

      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.properties.notify) {
            setState(() {
              _readCharacteristic = characteristic;
            });
            print("Característica encontrada para notificaciones: ${characteristic.uuid}");

            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              if (!mounted) return;
              String receivedData = String.fromCharCodes(value);
              print("Datos recibidos: $receivedData");

              setState(() {
                datosrecibidos.add(receivedData);
              });

              // Imprimir cada dato recibido por separado en consola
              datosrecibidos.forEach((dato) {
                print("Dato recibido: $dato");
              });

              NotificationService.showNotification(
                1,
                "Datos Bluetooth Recibidos",
                receivedData,
              );
            });
          }
        }
      }
    } catch (e) {
      print("Error al conectar: $e");
    }
  }

  Future<void> disconnectDevice() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      setState(() {
        _connectedDevice = null;
        _readCharacteristic = null;
      });
      print("Desconectado del dispositivo.");
      startScan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Conexión Bluetooth')
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                'Dispositivos Bluetooth',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.bluetooth_searching),
              title: Text('Conectar Dispositivo'),
              onTap: () {
                startScan();
                Navigator.pop(context);
              },
            ),
            if (_connectedDevice != null)
              ListTile(
                leading: Icon(Icons.bluetooth_disabled),
                title: Text('Desconectar'),
                onTap: () {
                  disconnectDevice();
                  Navigator.pop(context);
                },
              ),
            if (_devicesList.isEmpty && !_isScanning)
              ListTile(
                leading: Icon(Icons.refresh),
                title: Text('Reiniciar Escaneo'),
                onTap: () {
                  startScan();
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Dispositivos encontrados", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _devicesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_devicesList[index].name),
                        onTap: () {
                          connectToDevice(_devicesList[index]);
                        },
                      );
                    },
                  ),
                  if (_isScanning)
                    Text("Escaneando dispositivos...", style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (datosrecibidos.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Datos Recibidos:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: datosrecibidos.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                                title: Text(datosrecibidos[index]),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}