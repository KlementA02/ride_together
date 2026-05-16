import 'package:ride_together/core/domain/remote_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:flutter/material.dart';
import 'auth_user_dto.dart';

class AuthRemoteService {
  final supabase.SupabaseClient _supabaseClient;

  AuthRemoteService(this._supabaseClient);

  Future<RemoteResponse<AuthUserDTO>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      // 1. Sign up user on Supabase Auth
      final authResponse = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone_number': phone,
        },
      );

      final user = authResponse.user;
      if (user == null) {
        return const RemoteResponse.error('User registration returned an empty record.');
      }

      // 2. Fetch or construct the initial DTO payload
      final rawDto = {
        'uid': user.id,
        'email': user.email ?? email,
        'full_name': fullName,
        'phone_number': phone,
        'is_driver': false,
      };

      return RemoteResponse.withNewData(data: AuthUserDTO.fromJson(rawDto));
    } on supabase.AuthException catch (e) {
      debugPrint('[AuthRemoteService] Supabase Auth Error: ${e.message}');
      return RemoteResponse.error(e.message);
    } catch (e) {
      debugPrint('[AuthRemoteService] Unexpected Exception: $e');
      rethrow;
    }
  }

Future<RemoteResponse<AuthUserDTO>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Sign in user on Supabase Auth
      final authResponse = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null) {
        return const RemoteResponse.error('User sign-in returned an empty record.');
      }

      // 2. Fetch or construct the initial DTO payload
      final rawDto = {
        'uid': user.id,
        'email': user.email ?? email,
      };

      return RemoteResponse.withNewData(data: AuthUserDTO.fromJson(rawDto));
    } on supabase.AuthException catch (e) {
      debugPrint('[AuthRemoteService] Supabase Auth Error: ${e.message}');
      return RemoteResponse.error(e.message);
    } catch (e) {
      debugPrint('[AuthRemoteService] Unexpected Exception: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } catch (e) {
      debugPrint('[AuthRemoteService] Error during sign out: $e');
    }
  }
}