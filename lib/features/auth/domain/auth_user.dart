// lib/features/auth/domain/auth_user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    required String email,
    required String fullName,
    required String phoneNumber,
    required bool isDriver,
  }) = _AuthUser;
}