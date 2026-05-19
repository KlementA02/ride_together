// lib/features/rides/infrastructure/available_ride_dto.dart
import '../domain/available_ride.dart';

class AvailableRideDTO {
  final int id;
  final String from;
  final String to;
  final String driver;
  final double rating;
  final String time;
  final String date;
  final String price;
  final int seats;
  final String car;

  const AvailableRideDTO({
    required this.id,
    required this.from,
    required this.to,
    required this.driver,
    required this.rating,
    required this.time,
    required this.date,
    required this.price,
    required this.seats,
    required this.car,
  });

  factory AvailableRideDTO.fromJson(Map<String, dynamic> json) {
    return AvailableRideDTO(
      id: json['id'] as int,
      from: json['from'] as String? ?? '',
      to: json['to'] as String? ?? '',
      driver: json['driver'] as String? ?? 'Unknown Driver',
      rating: (json['rating'] as num? ?? 0.0).toDouble(),
      time: json['time'] as String? ?? '',
      date: json['date'] as String? ?? '',
      price: json['price'] as String? ?? '\$0',
      seats: json['seats'] as int? ?? 0,
      car: json['car'] as String? ?? '',
    );
  }

  AvailableRide toDomain() {
    return AvailableRide(
      id: id,
      fromLocation: from,
      toLocation: to,
      driverName: driver,
      rating: rating,
      time: time,
      date: date,
      price: price,
      seatsAvailable: seats,
      vehicleInfo: car,
    );
  }
}