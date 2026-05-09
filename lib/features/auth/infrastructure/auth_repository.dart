import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final SupabaseClient _client;

  AuthRepository(this._client);

  /// Signs up a new user and creates their profile record
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    // 1. Create the Auth User
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user != null) {
      // 2. Create the Profile entry in our custom table
      await _client.from('profiles').insert({
        'id': user.id,
        'full_name': fullName,
        'phone_number': phone,
        'is_driver': false, // Default to passenger
      });
    }
  }

  /// Modern Swiss-style Login
  Future<AuthResponse> login(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email, 
      password: password,
    );
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(Supabase.instance.client);
}