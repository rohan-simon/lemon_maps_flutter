import 'package:lemun/models/vehicle_types.dart';

class Lime {
  String id;
  double latitude;
  double longitude;
  bool isReserved;
  bool isDisabled;
  VehicleType vehicleType;

  Lime({required this.id, required this.latitude, required this.longitude,
        required this.isReserved, required this.isDisabled, required this.vehicleType});

  factory Lime.fromJson(Map<String, dynamic> data) {
    final id = data['bike_id'];
    final latitude = data['lat'];
    final longitude = data['lon'];
    final isReserved = switch(data['is_reserved']) {
      0 => false,
      _ => true
    };
    final isDisabled = switch(data['is_disabled']) {
      0 => false,
      _ => true
    };
    final vehicleType = switch(data['vehicle_type']) {
      'scooter' => VehicleType.scooter,
      'bike' => VehicleType.bike,
      _ => VehicleType.none
    };
    return Lime(id: id, latitude: latitude, longitude: longitude,
                isReserved: isReserved, isDisabled: isDisabled, vehicleType: vehicleType);
  }
}