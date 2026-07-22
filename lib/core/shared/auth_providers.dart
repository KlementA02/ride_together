
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/features/auth/infrastructure/auth_remote_svc.dart';
import 'package:ride_together/features/auth/infrastructure/auth_repository.dart';
import 'package:ride_together/features/auth/application/auth_state.dart';

final _authRemoteServiceProvider = Provider<AuthRemoteService>((ref) {
  return AuthRemoteService();
});

final _authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(_authRemoteServiceProvider));
});

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(_authRepositoryProvider));
});
