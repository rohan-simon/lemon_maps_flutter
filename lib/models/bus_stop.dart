import 'dart:math';

import 'package:lemun/models/vehicle.dart';
import 'package:lemun/models/vehicle_types.dart';

class BusStop implements Vehicle {

  BusStop({required this.name, required this.latitude, required this.longitude});

  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final VehicleType vehicleType = VehicleType.bus;


 
  double distanceFrom({required double latitude, required double longitude}) {
    double dx = (this.latitude - latitude);
    double dy = (this.longitude - longitude);

    return sqrt(_squared(dx) + _squared(dy));

  }

   // Gets the distance from the bus stop to the parameter position in meter
  double distanceInMeters({required double latitude, required double longitude}){
    return 111139 * distanceFrom(latitude: latitude, longitude: longitude);

  }

  // toString just for debugging
  @override
  String toString() {

    return '$name: ($latitude, $longitude)';

  }
  
  num _squared(num x) { return x * x; }

}