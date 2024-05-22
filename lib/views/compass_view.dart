import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lemun/models/vehicle.dart';
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
    return math.sqrt(_squared(myLat - widget.latitude) + _squared(myLong - widget.longitude));
  }

  double getBearing(double myLat, double myLong) {
    
    
    return 0;
  }

  // Helper method; defines a square function. Returns the square of a provided number x.
  num _squared(num x) { return x * x; }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Compass'),
      ),
      body: Consumer<PositionProvider>(
        builder: (context, positionProvider, child) {
          if (_hasPermissions) {
            return _buildCompass();
          } else {
            return _buildPermissionSheet();
          }
        },
      ),
    );
  }

  // Builds compass
  Widget _buildCompass() {
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
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: const Icon(Icons.arrow_circle_up)// Image.asset('assets/compass.jpg'),
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