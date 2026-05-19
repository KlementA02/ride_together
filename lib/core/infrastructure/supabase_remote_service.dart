// lib/core/infrastructure/supabase_remote_service.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/core/domain/remote_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//part 'supabase_remote_service.g.dart';

class SupabaseRemoteService {
  final SupabaseClient _client;

  SupabaseRemoteService(this._client);

  // ==========================================
  // AUTH BOUNDARY METHODS
  // ==========================================

  Future<RemoteResponse<User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      final user = response.user;
      if (user == null) {
        return const RemoteResponse.error('Authentication returned an empty user profile.');
      }
      return RemoteResponse.withNewData(data: user);
    } on AuthException catch (e) {
      debugPrint('[SupabaseRemoteService] Auth Error: ${e.message}');
      return RemoteResponse.error(e.message);
    } catch (e) {
      return RemoteResponse.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      debugPrint('[SupabaseRemoteService] Error during sign out: $e');
    }
  }

  User? get currentUser => _client.auth.currentUser;

  // ==========================================
  // RIDE BOUNDARY METHODS
  // ==========================================

  /// Finds rides near specific coordinates, wrapping the raw JSON maps safely
  Future<RemoteResponse<List<Map<String, dynamic>>>> getNearbyRides({
    required double lat,
    required double lng,
    int radius = 5000,
  }) async {
    try {
      final List<dynamic> response = await _client.rpc(
        'get_rides_near_point',
        params: {
          'lat': lat, 
          'lng': lng, 
          'radius_meters': radius,
        },
      );
      
      final formattedList = List<Map<String, dynamic>>.from(response);
      return RemoteResponse.withNewData(data: formattedList);
    } on PostgrestException catch (e) {
      debugPrint('[SupabaseRemoteService] Postgrest RPC Error: ${e.message}');
      return RemoteResponse.error(e.message);
    } catch (e) {
      return RemoteResponse.error(e.toString());
    }
  }

  /// Post a new ride map configuration to the backend database table
  Future<RemoteResponse<bool>> createRide(Map<String, dynamic> rideData) async {
    try {
      await _client.from('rides').insert(rideData);
      return const RemoteResponse.withNewData(data: true); 
    } on PostgrestException catch (e) {
      debugPrint('[SupabaseRemoteService] Db Insert Failure: ${e.message}');
      return RemoteResponse.error(e.message);
    } catch (e) {
      return RemoteResponse.error(e.toString());
    }
  }

  // ==========================================
  // REAL-TIME STREAM HOOKS
  // ==========================================

  /// Stream tracking a specific ride's data mutations directly
  Stream<List<Map<String, dynamic>>> watchRideStatus(String rideId) {
    return _client
        .from('rides')
        .stream(primaryKey: ['id'])
        .eq('id', rideId);
  }
}

// Global Supabase Client Provider
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

// Modern Riverpod Code Generation Provider
@riverpod
SupabaseRemoteService supabaseRemoteService(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseRemoteService(client);
}