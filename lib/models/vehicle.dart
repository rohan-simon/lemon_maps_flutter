import 'package:lemun/models/vehicle_types.dart';

export 'lime.dart';
export 'link_scooter.dart';

abstract class Vehicle {
  VehicleType get vehicleType;
  double get longitude;
  double get latitude;
}