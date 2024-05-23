import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lemun/models/vehicle.dart';
import 'package:lemun/models/vehicle_types.dart';
import 'package:lemun/views/compass_view.dart';

class MapView extends StatefulWidget {
  final List<Vehicle> vehicles;

  MapView({super.key, required this.vehicles});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final MapController _mapController;
  LatLng _currentPosition = const LatLng(51.509364, -0.128928); // Default to London;

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

  List<Marker> createVehicleMarkers(List<Vehicle> vehicles) {
    print(vehicles.length);
    return vehicles.map((vehicle) {
      return Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(vehicle.latitude, vehicle.longitude),
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CompassView(vehicle: vehicle)));
          },
          child: getVehicleIcon(vehicle.vehicleType)
        )
      );
    }).toList();
  }

  Icon getVehicleIcon(VehicleType type) {
    switch (type) {
    case VehicleType.bike:
      return Icon(Icons.directions_bike, color: Colors.green, size: 40);
    case VehicleType.scooter:
      return Icon(Icons.electric_scooter, color: Colors.orange, size: 40);
    case VehicleType.bus:
      return Icon(Icons.directions_bus, color: Colors.blue, size: 40);
    default:
      return Icon(Icons.location_on, color: Colors.red, size: 40);
    }
  }

  Widget buildLegend() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.amber[100],
      width: double.infinity, // Make the container fit the width of the screen
      child: Column(
        children: [
          const Text(
            'Legend',
            style: TextStyle(color: Colors.purple, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              legendItem(Icons.directions_bike, Colors.green, 'Bike'),
              legendItem(Icons.electric_scooter, Colors.orange, 'Scooter'),
              legendItem(Icons.directions_bus, Colors.blue, 'Bus'),
              legendItem(Icons.catching_pokemon, Colors.red, 'You'),
            ],
          ),
        ],
      ),
    );
  }

  Widget legendItem(IconData iconData, Color color, String label) {
    return Column(
      children: [
        Icon(iconData, color: color, size: 30),
        Text(
          label,
          style: const TextStyle(color: Colors.purple, fontSize: 10),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                minZoom: 14,
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
                      child: Icon(Icons.catching_pokemon, color: Colors.red, size: 40),
                    ),
                    ...createVehicleMarkers(widget.vehicles)
                  ]
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: buildLegend()
          )
        ],
      ),
    );
  }
}