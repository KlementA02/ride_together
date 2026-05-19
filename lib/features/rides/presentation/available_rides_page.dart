import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/features/rides/domain/available_ride.dart';
import 'package:ride_together/features/rides/presentation/widgets/available_rides_card.dart';

class AvailableRidesPage extends ConsumerStatefulWidget {
  const AvailableRidesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AvailableRidesPageState();
}

class _AvailableRidesPageState extends ConsumerState<AvailableRidesPage> {
  final List<AvailableRide> _rides = [
    const AvailableRide(
      id: 1,
      fromLocation: "Downtown",
      toLocation: "Airport",
      driverName: "Sarah Johnson",
      rating: 4.9,
      time: "2:30 PM",
      date: "Today",
      price: "\$12",
      seatsAvailable: 2,
      vehicleInfo: "Tesla Model 3",
    ),
    const AvailableRide(
      id: 2,
      fromLocation: "Tech Park",
      toLocation: "Shopping Mall",
      driverName: "Michael Chen",
      rating: 4.8,
      time: "5:45 PM",
      date: "Today",
      price: "\$8",
      seatsAvailable: 3,
      vehicleInfo: "Honda Accord",
    ),
    const AvailableRide(
      id: 3,
      fromLocation: "University",
      toLocation: "City Center",
      driverName: "Emma Williams",
      rating: 5.0,
      time: "9:00 AM",
      date: "Tomorrow",
      price: "\$6",
      seatsAvailable: 1,
      vehicleInfo: "Toyota Camry",
    ),
    const AvailableRide(
      id: 4,
      fromLocation: "Suburbs",
      toLocation: "Business District",
      driverName: "James Rodriguez",
      rating: 4.7,
      time: "7:15 AM",
      date: "Tomorrow",
      price: "\$15",
      seatsAvailable: 2,
      vehicleInfo: "BMW 5 Series",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sheet Context Title Block Row
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Rides',
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${_rides.length} rides found',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Scrollable Cards List Frame
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: _rides.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final ride = _rides[index];
                    return AvailableRidesCard(ride: ride, theme: theme);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
