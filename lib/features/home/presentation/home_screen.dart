import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/features/home/presentation/widgets/search_bar_app.dart';
import 'package:ride_together/features/rides/domain/available_ride.dart';
import 'package:ride_together/features/rides/presentation/widgets/available_rides_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // Mocked state cache matching domain structures cleanly
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
      backgroundColor: theme.colorScheme.secondary,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Map View Layer ---
            const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(5.6037, -0.1870), // Accra Coordinate Anchor
                zoom: 13,
              ),
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
            ),

            const Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: SearchBarApp(isLoading: false)),

            // --- Bottom Action Sheet Overlay Container ---
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.15,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
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
                    children: [
                      // Persistent Grab Handle Bracket
                      Container(
                        width: 36,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),

                      // Sheet Context Title Block Row
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quick Suggestions',
                              style: theme.textTheme.displayLarge?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${_rides.length} nearby',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Scrollable Cards List Frame
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                          itemCount: _rides.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final ride = _rides[index];
                            return AvailableRidesCard(ride: ride, theme: theme);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

