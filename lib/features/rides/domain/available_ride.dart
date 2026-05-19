// lib/features/rides/domain/available_ride.dart
class AvailableRide {
  final int id;
  final String fromLocation;
  final String toLocation;
  final String driverName;
  final double rating;
  final String time;
  final String date;
  final String price;
  final int seatsAvailable;
  final String vehicleInfo;

  const AvailableRide({
    required this.id,
    required this.fromLocation,
    required this.toLocation,
    required this.driverName,
    required this.rating,
    required this.time,
    required this.date,
    required this.price,
    required this.seatsAvailable,
    required this.vehicleInfo,
  });
}