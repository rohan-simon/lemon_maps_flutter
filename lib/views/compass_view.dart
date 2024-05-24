import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lemun/models/bus_stop.dart';
import 'package:lemun/models/vehicle.dart';
import 'package:lemun/models/vehicle_types.dart';
import 'package:lemun/providers/position_provider.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CompassView extends StatefulWidget {  
  final Vehicle vehicle;
  final double latitude;
  final double longitude;

  CompassView({super.key, required this.vehicle}): latitude = vehicle.latitude, longitude = vehicle.longitude;

  @override
  State<CompassView> createState() => _CompassViewState();
}

class _CompassViewState extends State<CompassView> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  // Returns double representing user's distance (in metres) to selected vehicle.
  // Parameters:
  // - double myLat: user's latitude coordinate
  // - double myLong: user's longitude coordinate
  double getDistance(double myLat, double myLong) {
    return 100000 * math.sqrt(_squared(myLat - widget.latitude) + _squared(myLong - widget.longitude));
  }

  String distanceToString(double distance) {
    if (distance > 1000) {
      return '${(distance / 1000).toStringAsFixed(2)} km';
    }
    return '${distance.toStringAsFixed(0)} m';
  }

  String vehicleTypeAsString(Vehicle vehicle) {
    String stringRep = '';
    if (vehicle is Lime) {
      stringRep += 'Lime';
    } else if (vehicle is LinkScooter) {
      stringRep += 'Link';
    } else if (vehicle is BusStop) {
      stringRep += 'Bus Stop';
    } else {
      throw Exception('Invalid action');
    }
    switch(vehicle.vehicleType) {
      case VehicleType.bike: stringRep += ' Bike';
      case VehicleType.scooter: stringRep += ' Scooter';
      case VehicleType.bus: break; // Do nothing
      case VehicleType.none: throw Exception('Invalid action');
    }
    return stringRep;
  }

  bool _availStatus(Vehicle vehicle) {
    if (vehicle is BusStop) {
      return true;
    } else if (vehicle is LinkScooter) {
      return vehicle.isBookable;
    } else if (vehicle is Lime) {
      return !vehicle.isDisabled && !vehicle.isReserved;
    } else {
      throw Exception('Invalid vehicle');
    }
  }

  // Returns double representing bearing.
  double getBearing(double myLat, double myLong) {
    double dLon = (widget.longitude - myLong);
    
    double x = math.cos(_degrees2Radians(widget.latitude)) * math.sin(_degrees2Radians(dLon));
    double y = math.cos(_degrees2Radians(myLat)) * math.sin(_degrees2Radians(widget.latitude)) 
             - math.sin(_degrees2Radians(myLat)) * math.cos(_degrees2Radians(widget.latitude)) * math.cos(_degrees2Radians(dLon));
    double bearing = math.atan2(x, y);
    return _radians2Degrees(bearing);
  }

  double _radians2Degrees(double x) {
    return x * 180 / math.pi;
  }

  double _degrees2Radians(double x) {
    return x / 180 * math.pi;
  }

  // Helper method; defines a square function. Returns the square of a provided number x.
  double _squared(double x) {
    return x * x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('${vehicleTypeAsString(widget.vehicle)} '), // TODO: Add back button
      ),
      body: Consumer<PositionProvider>(
        builder: (context, positionProvider, child) {
          if (_hasPermissions) {
            String availStatus;
            
            if (_availStatus(widget.vehicle)) {
              availStatus = '🟢 Available';
            } else {
              availStatus = '🔴 Unavailable';
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Status: $availStatus',
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 30),
                _buildCompass(positionProvider),
                const SizedBox(height: 30),
                Text(
                  '${distanceToString(getDistance(positionProvider.latitude, positionProvider.longitude))} away',
                  style: const TextStyle(fontSize: 20),
                )
              ],
            );
          } else {
            return _buildPermissionSheet();
          }
        },
      ),
    );
  }

  // Builds compass
  Widget _buildCompass(PositionProvider positionProvider) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null) {
          return const Center(
            child: Text("Device does not have sensors !"),
          );
        }
        return Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 255, 245, 177),
            ),
            child: Transform.rotate(
              angle: (_degrees2Radians(direction) * -1 + _degrees2Radians(getBearing(positionProvider.latitude, positionProvider.longitude))),
              child: const Image(image: AssetImage('lib/assets/compass.png'))
            ),
          ),
        );
      },
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Location Permission Required'),
          ElevatedButton(
            child: const Text('Open App Settings'),
            onPressed: () {
              openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}