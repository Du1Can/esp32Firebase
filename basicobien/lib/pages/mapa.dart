import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyMapPage();
  }

}

class _MyMapPage extends State<MapPage> {
  final Completer<GoogleMapController> _completer = Completer();
  static const CameraPosition _durango = CameraPosition(
      target: LatLng(23.634501, -102.552784),
      zoom: 0
  );
  static const CameraPosition _ciudad = CameraPosition(
      target: LatLng(24.02032, -104.65756),
      bearing: 45,
      tilt: 20,
      zoom: 10
  );
  final Set<Marker> _markers = {
    const Marker(
        markerId: MarkerId('Ciudad'),
        position: LatLng(24.021440539354252, -104.65981169568856),
        infoWindow: InfoWindow(
            title: 'Durango',
            snippet: 'Ciudad'
        )
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _durango,
        onMapCreated: (GoogleMapController controller) {
          _completer.complete(controller);
        },
        markers: _markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _gotoCiudad,
        label: Text('Go'),
        icon: Icon(Icons.airplanemode_active),
      ),
    );
  }

  Future<void> _gotoCiudad() async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_ciudad));
  }

}