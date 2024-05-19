

class LinkScooter {
  String id;
  bool isBookable;
  String vehicleStatus;
  int bookingLength;
  double batteryCharge;
  double distanceRemaining;
  int timeRemaining;
  double latitude;
  double longitude;
  
  LinkScooter({required this.isBookable, required this.vehicleStatus, required this.bookingLength, 
    required this.batteryCharge, required this.distanceRemaining, required this.timeRemaining, 
    required this.latitude, required this.longitude, required this.id});

  factory LinkScooter.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final isBookable = data['is_bookable'];
    final vehicleStatus = data['vehicle_status'];
    final bookingLength = data['booking_length'];
    final batteryCharge = data['battery_charge'];
    final distanceRemaining = data['distance_remaining_in_km'];
    final timeRemaining = data['time_remaining_in_min'];
    final latitude = data['last_position']?['coordinates']?[0];
    final longitude = data['last_position']?['coordinates']?[1];

    return LinkScooter(id: id, isBookable: isBookable, vehicleStatus: vehicleStatus,
                        bookingLength: bookingLength, batteryCharge: batteryCharge,
                        distanceRemaining: distanceRemaining, timeRemaining: timeRemaining,
                        latitude: latitude, longitude: longitude);
  }
}