// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ride_together/core/shared/null_value_checkers.dart';
import '../domain/auth_user.dart';

part 'auth_user_dto.freezed.dart';
part 'auth_user_dto.g.dart';

@freezed
class AuthUserDTO with _$AuthUserDTO {
  const AuthUserDTO._();

  const factory AuthUserDTO({
    @JsonKey(fromJson: stringValueChecker) required String uid,
    @JsonKey(fromJson: stringValueChecker) required String email,
    @JsonKey(fromJson: stringValueChecker) required String username,
    @JsonKey(name: 'full_name', fromJson: stringValueChecker) required String fullName,
    @JsonKey(name: 'phone_number', fromJson: stringValueChecker) required String phoneNumber,
    @JsonKey(name: 'is_driver', fromJson: boolValueChecker) required bool isDriver,
  }) = _AuthUserDTO;

  factory AuthUserDTO.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDTOFromJson(json);

  AuthUser toDomain() => AuthUser(
        uid: uid,
        email: email,
        username: username,
        fullName: fullName,
        phoneNumber: phoneNumber,
        isDriver: isDriver,
      );
}