import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/core/shared/auth_providers.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileState = ref.read(authNotifierProvider);

    final profileDetails = profileState.maybeWhen(
        orElse: () => null, authenticated: (user) => user);
    // Structural Data definitions mapped directly from the source component
    final Map<String, dynamic> user = {
      "name": profileDetails?.fullName ?? 'Alex Morgan',
      "email": profileDetails?.email ?? 'alex.morgan@email.com',
      "image":
          "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&h=200&fit=crop",
      "rating": 4.8,
      "totalRides": 47,
      "verified": true
    };

    final List<Map<String, dynamic>> stats = [
      {"label": "Total Rides", "value": "47", "icon": Icons.history},
      {"label": "Rating", "value": "4.8", "icon": Icons.star_border_outlined},
      {
        "label": "Wallet",
        "value": "\$124",
        "icon": Icons.account_balance_wallet_outlined
      }
    ];

    final List<Map<String, dynamic>> recentRides = [
      {
        "id": 1,
        "route": "Downtown → Airport",
        "date": "May 12, 2026",
        "amount": "\$12",
        "type": "passenger"
      },
      {
        "id": 2,
        "route": "Tech Park → Mall",
        "date": "May 10, 2026",
        "amount": "\$24",
        "type": "driver"
      },
      {
        "id": 3,
        "route": "University → Center",
        "date": "May 8, 2026",
        "amount": "\$6",
        "type": "passenger"
      }
    ];

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // --- Header Block Slice with Gradient Background ---
          SliverStack(
            children: [
              SliverAppBar(
                expandedHeight: 140.0,
                floating: false,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xFF2D5BFF),
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF2D5BFF), Color(0xFF1E3FCC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  titlePadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  centerTitle: false,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings_outlined,
                            color: Colors.white, size: 24),
                        onPressed: () {}, // Navigate settings panel
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Overlapping Premium Profile Information Bracket Card ---
                    Transform.translate(
                      offset: const Offset(0, 165),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: _SwissCard(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor: Colors.grey[200],
                                            backgroundImage:
                                                NetworkImage(user["image"]),
                                          ),
                                          if (user["verified"] == true)
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFF2D5BFF),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                child: const Icon(
                                                  Icons.check,
                                                  size: 14,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user["name"],
                                              style: const TextStyle(
                                                color: Color(0xFF1A1D1E),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              user["email"],
                                              style: const TextStyle(
                                                color: Color(0xFF6B7280),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // Grid Distribution Row Configuration
                                  Row(
                                    children: stats.map((stat) {
                                      return Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF8F9FB),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Icon(stat["icon"],
                                                  color:
                                                      const Color(0xFF2D5BFF),
                                                  size: 20),
                                              const SizedBox(height: 8),
                                              Text(
                                                stat["value"],
                                                style: const TextStyle(
                                                  color: Color(0xFF1A1D1E),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                stat["label"],
                                                style: const TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // --- Wallet Balance Panel Segment ---
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 2),
                            child: _SwissCard(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Wallet',
                                        style: TextStyle(
                                          color: Color(0xFF1A1D1E),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size.zero,
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Text(
                                          'Add Funds',
                                          style: TextStyle(
                                              color: Color(0xFF2D5BFF),
                                              fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF2D5BFF),
                                          Color(0xFF1E3FCC)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Available Balance',
                                          style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 13),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          '\$124.00',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white
                                                      .withValues(alpha: 0.2),
                                                  foregroundColor: Colors.white,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                                child: const Text('Withdraw'),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor:
                                                      const Color(0xFF2D5BFF),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                                child: const Text('Top Up'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // --- Recent Rides Subtitle Frame Header ---
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Recent Rides',
                                  style: TextStyle(
                                    color: Color(0xFF1A1D1E),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'View All',
                                    style: TextStyle(
                                        color: Color(0xFF2D5BFF), fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // --- Queue of Activity Cards ---
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            itemCount: recentRides.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final ride = recentRides[index];
                              final isDriver = ride["type"] == "driver";
                              return _SwissCard(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ride["route"],
                                            style: const TextStyle(
                                              color: Color(0xFF1A1D1E),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            ride["date"],
                                            style: const TextStyle(
                                                color: Color(0xFF6B7280),
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${isDriver ? '+' : ''}${ride['amount']}",
                                          style: TextStyle(
                                            color: isDriver
                                                ? const Color(0xFF10B981)
                                                : const Color(0xFF1A1D1E),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          ride["type"],
                                          style: const TextStyle(
                                              color: Color(0xFF6B7280),
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          // --- Destructive Action Interface Button Layer ---
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {}, // Invoke SignOut Bloc process hook
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xFFEF4444)
                                          .withValues(alpha: 0.2)),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: InkWell(
                                  onTap: () => ref
                                      .read(authNotifierProvider.notifier)
                                      .signOut(),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.logout_outlined,
                                          color: Color(0xFFEF4444), size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Log Out',
                                        style: TextStyle(
                                          color: Color(0xFFEF4444),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// --- High-Contrast Unified Token Design Container Frame ---
class _SwissCard extends StatelessWidget {
  final Widget child;
  const _SwissCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
