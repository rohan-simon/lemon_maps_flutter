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
  num _squared(num x) {
    return x * x;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Flutter Compass'), // TODO: Add back button
      ),
      body: Consumer<PositionProvider>(
        builder: (context, positionProvider, child) {
          if (_hasPermissions) {
            return _buildCompass(positionProvider);
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
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
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