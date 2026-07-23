import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ride_together/features/auth/infrastructure/auth_repository.dart';
import '../domain/auth_failure.dart';
import '../domain/auth_user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState.initializing() = _Initializing;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated({required AuthUser user}) =
      _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.failure({required AuthFailure failure}) = _Failure;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState.initializing());

  Future<void> signUpUser({
    required String email,
    required String username,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    state = const AuthState.loading();

    final failureOrSuccess = await _repository.signUp(
      email: email,
      username: username,
      password: password,
      fullName: fullName,
      phoneNumber: phoneNumber,
    );

    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure: failure),
      (user) => AuthState.authenticated(user: user),
    );
  }

  Future<void> signInUser({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();

    final failureOrSuccess = await _repository.signIn(
      email: email,
      password: password,
    );

    state = failureOrSuccess.fold(
      (failure) => AuthState.failure(failure: failure),
      (user) => AuthState.authenticated(user: user),
    );
  }

  Future<void> signOut() async {
    await _repository.signOut();
    state = const AuthState.unauthenticated();
  }
}
