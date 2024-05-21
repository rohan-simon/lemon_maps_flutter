import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapController _mapController;
  LatLng _currentPosition = LatLng(51.509364, -0.128928); // Default to London;

  List<LatLng> coordinates = [
    LatLng(51.509364, -0.128928), // Example: London
    LatLng(48.8566, 2.3522),      // Example: Paris
    LatLng(40.7128, -74.0060),    // Example: New York
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition, 13.0);
    });
  }

  List<Marker> createMarkers(List<LatLng> coordinates) {
    return coordinates.map((coordinate) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: coordinate,
        child: Icon(Icons.location_on, color: Colors.red, size: 40),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter:  _currentPosition,
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: _currentPosition,
              rotate: false,
              child: Icon(Icons.catching_pokemon, color: Colors.blue, size: 40),
            ),
            ...createMarkers(coordinates)
          ]
        )
      ],
    );
  }
}