import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supabase_service.g.dart';

class SupabaseService {
  final SupabaseClient _client;

  SupabaseService(this._client);

  // --- Auth Methods ---

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async => await _client.auth.signOut();

  User? get currentUser => _client.auth.currentUser;

  // --- Ride Methods ---

  /// Finds rides near a specific coordinate using the SQL function we created
  Future<List<Map<String, dynamic>>> getNearbyRides({
    required double lat,
    required double lng,
    int radius = 5000,
  }) async {
    final List<dynamic> response = await _client.rpc(
      'get_rides_near_point',
      params: {'lat': lat, 'lng': lng, 'radius_meters': radius},
    );
    return List<Map<String, dynamic>>.from(response);
  }

  /// Post a new ride
  Future<void> createRide(Map<String, dynamic> rideData) async {
    await _client.from('rides').insert(rideData);
  }

  // --- Real-time Stream ---

  /// Stream for tracking a specific ride's status (e.g., for the Passenger UI)
  Stream<List<Map<String, dynamic>>> watchRideStatus(String rideId) {
    return _client.from('rides').stream(primaryKey: ['id']).eq('id', rideId);
  }
}

// Riverpod Provider for the Service
@riverpod
SupabaseService supabaseService(Ref ref) {
  return SupabaseService(Supabase.instance.client);
}
