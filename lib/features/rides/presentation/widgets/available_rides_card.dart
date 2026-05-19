import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_together/features/rides/domain/available_ride.dart';

class AvailableRidesCard extends StatelessWidget {
  const AvailableRidesCard({
    super.key,
    required this.ride,
    required this.theme,
  });

  final AvailableRide ride;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () => context.go('/rides/${ride.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Route Summary Details
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: theme.colorScheme
                                    .primary, // Cobalt Accent Blue
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(ride.fromLocation,
                                style: theme.textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontWeight:
                                            FontWeight
                                                .w500)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: theme.colorScheme
                                    .onSurface
                                    .withValues(
                                        alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              ride.toLocation,
                              style: theme
                                  .textTheme.bodyMedium
                                  ?.copyWith(
                                color: theme.textTheme
                                    .bodySmall?.color,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end,
                    children: [
                      Text(
                        ride.price,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(
                          color:
                              theme.colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.people_outline,
                              size: 14,
                              color: theme.textTheme
                                  .bodySmall?.color),
                          const SizedBox(width: 4),
                          Text(
                              '${ride.seatsAvailable} seats',
                              style: theme
                                  .textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
    
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0),
                child: Divider(
                    color: theme.dividerColor,
                    height: 1),
              ),
    
              // Driver Metrics Footer Row
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(ride.driverName,
                          style: theme
                              .textTheme.bodyMedium
                              ?.copyWith(
                                  fontWeight:
                                      FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(ride.vehicleInfo,
                          style: theme
                              .textTheme.bodySmall
                              ?.copyWith(fontSize: 12)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star,
                          size: 14,
                          color: Color(0xFFFFA500)),
                      const SizedBox(width: 4),
                      Text(ride.rating.toString(),
                          style: theme
                              .textTheme.bodyMedium),
                      const SizedBox(width: 12),
                      Icon(Icons.access_time,
                          size: 14,
                          color: theme.textTheme
                              .bodySmall?.color),
                      const SizedBox(width: 4),
                      Text(ride.time,
                          style: theme
                              .textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
