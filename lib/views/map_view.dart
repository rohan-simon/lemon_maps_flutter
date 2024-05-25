import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lemun/models/vehicle.dart';
import 'package:lemun/models/vehicle_types.dart';
import 'package:lemun/providers/position_provider.dart';
import 'package:lemun/views/compass_view.dart';
import 'package:provider/provider.dart';

class MapView extends StatefulWidget {
  final List<Vehicle> vehicles;

  const MapView({super.key, required this.vehicles});

  @override
  MapViewState createState() => MapViewState();
}

class MapViewState extends State<MapView> {
  late final MapController _mapController;
  bool _mapReady = false;
  bool _needsUpdate = true;
  LatLng _currentPosition = const LatLng(47.6061, -122.3328); // Default to Seattle;
  final double _initialZoom = 15.2;
  final Set<VehicleType> _visibleVehicleTypes = {VehicleType.bike, VehicleType.scooter, VehicleType.bus};

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     _isControllerReady = true;
    //   });
    //   _updateCurrentLocation();
    // });
    
  }

  void _onMapReady() {
    setState(() {
      _mapReady = true;
    });
    _updateCurrentLocation();
  }

  @override
  void dispose() {
    final positionProvider = Provider.of<PositionProvider>(context, listen: false);
    positionProvider.removeListener(_updateCurrentLocation);
    super.dispose();
  }

  // Future<void> _getCurrentLocation(PositionProvider positionProvider) async {
  //   LocationPermission permission;

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return;
  //   }

  //   Position position = await positionProvider._determinePosition()

  //   setState(() {
  //     _currentPosition = LatLng(position.latitude, position.longitude);
  //     _mapController.move(_currentPosition, _currentZoom);
  //   });
  // }

  // void _updateCurrentLocation(PositionProvider positionProvider) {
  //   setState(() {
  //     _currentPosition = LatLng(positionProvider.latitude, positionProvider.longitude);
  //     _mapController.move(_currentPosition, _currentZoom);
  //   });
  // }

  void _updateCurrentLocation() {
    if (_mapReady) {
      final positionProvider = Provider.of<PositionProvider>(context, listen: false);
      if (positionProvider.status) {
        _currentPosition = LatLng(positionProvider.latitude, positionProvider.longitude);
        if (_needsUpdate) {
          _mapController.moveAndRotate(_currentPosition, _initialZoom, 0);
          setState(() {
            _needsUpdate = false;
          });
        }
      }
    }
  }

  List<Marker> createVehicleMarkers(List<Vehicle> vehicles) {
    return vehicles
        .where((vehicle) => _visibleVehicleTypes.contains(vehicle.vehicleType))
        .map((vehicle) {
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
      return const Icon(Icons.directions_bike, color: Colors.green, size: 40);
    case VehicleType.scooter:
      return const Icon(Icons.electric_scooter, color: Colors.orange, size: 40);
    case VehicleType.bus:
      return const Icon(Icons.directions_bus, color: Colors.blue, size: 40);
    default:
      return const Icon(Icons.location_on, color: Colors.red, size: 40);
    }
  }

  void _toggleVehicleType(VehicleType type) {
    setState(() {
      if (_visibleVehicleTypes.contains(type)) {
        _visibleVehicleTypes.remove(type);
      } else {
        _visibleVehicleTypes.add(type);
      }
    });
  }

  Widget buildLegend() {
    var bikeColor = Colors.grey;
    var scooterColor = Colors.grey;
    var busColor = Colors.grey;

    if (_visibleVehicleTypes.contains(VehicleType.bike)) {
      bikeColor = Colors.green;
    }

    if (_visibleVehicleTypes.contains(VehicleType.scooter)) {
      scooterColor = Colors.orange;
    }

    if (_visibleVehicleTypes.contains(VehicleType.bus)) {
      busColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.amber[100],
      width: double.infinity,
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
              GestureDetector(
                onTap: () {
                  _toggleVehicleType(VehicleType.bike);
                },
                child: legendItem(Icons.directions_bike, bikeColor, 'Bike')
              ),
              GestureDetector(
                onTap: () {
                  _toggleVehicleType(VehicleType.scooter);
                },
                child: legendItem(Icons.electric_scooter, scooterColor, 'Scooter')
              ),
              GestureDetector(
                onTap: () {
                  _toggleVehicleType(VehicleType.bus);
                },
                child: legendItem(Icons.directions_bus, busColor, 'Bus')
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _needsUpdate = true;
                  });
                  _updateCurrentLocation();
                },
                child: legendItem(Icons.catching_pokemon, Colors.red, 'You')
              ),
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
      body: Consumer<PositionProvider>(
        builder: (context, positionProvider, child) {
          if (!positionProvider.status && !positionProvider.loadFailure) {
            return Center(child: CircularProgressIndicator());
          } else if (positionProvider.loadFailure) {
            return Center(child: Text('Failed to load location'));
          }

          if (_mapReady) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _updateCurrentLocation();
            });
          }
          return Column(
            children: [
              Expanded(
                flex: 5,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    maxZoom: 19,
                    minZoom: 14,
                    initialCenter:  _currentPosition,
                    initialZoom: _initialZoom,
                    onMapReady: _onMapReady,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        ...createVehicleMarkers(widget.vehicles),
                        Marker(
                          width: 80,
                          height: 80,
                          point: _currentPosition,
                          rotate: false,
                          child: const Icon(Icons.catching_pokemon, color: Colors.red, size: 40),
                        )                    
                      ]
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: buildLegend(),
              )
            ],
          );
        }
      ),
    );
  }
}