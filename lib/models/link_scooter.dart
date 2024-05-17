

class LinkScooter {
  final id;
  final isBookable;
  final vehicleStatus;
  final bookingLength;
  final batteryCharge;
  final distanceRemaining;
  final timeRemaining;
  final latitude;
  final longitude;
  
  LinkScooter({this.isBookable, this.vehicleStatus, this.bookingLength, 
    this.batteryCharge, this.distanceRemaining, this.timeRemaining, 
    this.latitude, this.longitude, this.id});

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