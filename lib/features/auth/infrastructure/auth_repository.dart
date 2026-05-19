import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:ride_together/features/auth/infrastructure/auth_remote_svc.dart';
import '../domain/auth_failure.dart';
import '../domain/auth_user.dart';

class AuthRepository {
  final AuthRemoteService _remoteService;

  AuthRepository(this._remoteService);

  Future<Either<AuthFailure, AuthUser>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
  }) async {
    try {
      final response = await _remoteService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        phone: phone,
      );

      return response.when(
        noConnection: () => const Left(AuthFailure.noConnection()),
        permissionDenied: () => const Left(AuthFailure.invalidCredentials()),
        error: (message) {
          if (message.contains('already registered')) {
            return const Left(AuthFailure.emailAlreadyInUse());
          }
          return Left(AuthFailure.server(message: message));
        },
        withNewData: (dto) => Right(dto.toDomain()),
      );
    } catch (e) {
      debugPrint('[AuthRepository] Failure during domain conversion: $e');
      return Left(AuthFailure.server(message: e.toString()));
    }
  }

  Future<Either<AuthFailure, AuthUser>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteService.signIn(
        email: email,
        password: password,
      );

      return response.when(
        noConnection: () => const Left(AuthFailure.noConnection()),
        permissionDenied: () => const Left(AuthFailure.invalidCredentials()),
        error: (message) {
          if (message.contains('No user found')) {
            return const Left(AuthFailure.emailAlreadyInUse());
          }
          return Left(AuthFailure.server(message: message));
        },
        withNewData: (dto) => Right(dto.toDomain()),
      );
    } catch (e) {
      debugPrint('[AuthRepository] Failure during domain conversion: $e');
      return Left(AuthFailure.server(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _remoteService.signOut();
      debugPrint('[AuthRepository] User signed out successfully.');
    } catch (e) {
      debugPrint('[AuthRepository] Failure during sign out: $e');
    }
  }
}
