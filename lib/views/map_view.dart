import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_compass/flutter_compass.dart';

void main() => runApp(const ScaffoldExampleApp());

class ScaffoldExampleApp extends StatelessWidget {
  const ScaffoldExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScaffoldExample(),
    );
  }
}

class ScaffoldExample extends StatefulWidget {
  const ScaffoldExample({super.key});

  @override
  State<ScaffoldExample> createState() => _ScaffoldExampleState();
}

class _ScaffoldExampleState extends State<ScaffoldExample> {
  late final MapController _mapController;
  LatLng _currentPosition = LatLng(51.509364, -0.128928); // Default to London;
  double _currentHeading = 0.0;

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
    _getDeviceOrientation();
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
      _mapController.move(_currentPosition, 17.0);
    });
  }

  void _getDeviceOrientation() {
    FlutterCompass.events!.listen((CompassEvent event) {
      setState(() {
        _currentHeading = event.heading ?? 0.0;
      });
    });
  }

  List<Marker> createMarkers(List<LatLng> coordinates) {
    return coordinates.map((coordinate) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: coordinate,
        rotate: true,
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
        initialZoom: 17,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          // marker for current location
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: _currentPosition,
              rotate: false,
                  // angle: _currentHeading * (3.14159265358979323846 / 180),
              child: Icon(Icons.catching_pokemon, color: Colors.blue, size: 40),
            ),
            ...createMarkers(coordinates)
          ]
        )
      ],
    );
  }
}
