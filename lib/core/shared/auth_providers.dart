
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/features/auth/infrastructure/auth_remote_svc.dart';
import 'package:ride_together/features/auth/infrastructure/auth_repository.dart';
import 'package:ride_together/features/auth/application/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

final supabaseClientProvider = Provider((ref) => supabase.Supabase.instance.client);

final authRemoteServiceProvider = Provider<AuthRemoteService>((ref) {
  return AuthRemoteService(ref.watch(supabaseClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authRemoteServiceProvider));
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});
