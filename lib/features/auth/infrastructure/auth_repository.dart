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
          final lowerMessage = message.toLowerCase();
          if (lowerMessage.contains('already registered') ||
              lowerMessage.contains('already exists') ||
              lowerMessage.contains('username') &&
                  lowerMessage.contains('taken')) {
            return const Left(AuthFailure.emailAlreadyInUse());
          }
          return Left(AuthFailure.server(message: message));
        },
        withNewData: (record) {
          // Destructure record: record.token & record.user (AuthUserDTO)
          final userDto = record.user;

          // Optionally save record.token using Flutter Secure Storage here

          return Right(userDto.toDomain());
        },
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
          final lowerMessage = message.toLowerCase();
          if (lowerMessage.contains('invalid credentials') ||
              lowerMessage.contains('no active account') ||
              lowerMessage.contains('unable to log in')) {
            return const Left(AuthFailure.invalidCredentials());
          }
          return Left(AuthFailure.server(message: message));
        },
        withNewData: (record) {
          // Destructure record: record.token & record.user (AuthUserDTO)
          final userDto = record.user;

          // Optionally save record.token using Flutter Secure Storage here

          return Right(userDto.toDomain());
        },
      );
    } catch (e) {
      debugPrint('[AuthRepository] Failure during domain conversion: $e');
      return Left(AuthFailure.server(message: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _remoteService.signOut();
      // Optionally clear stored token from Flutter Secure Storage here
      debugPrint('[AuthRepository] User signed out successfully.');
    } catch (e) {
      debugPrint('[AuthRepository] Failure during sign out: $e');
    }
  }
}
