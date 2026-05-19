// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserDTOImpl _$$AuthUserDTOImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserDTOImpl(
      uid: stringValueChecker(json['uid']),
      email: stringValueChecker(json['email']),
      fullName: stringValueChecker(json['full_name']),
      phoneNumber: stringValueChecker(json['phone_number']),
      isDriver: boolValueChecker(json['is_driver']),
    );

Map<String, dynamic> _$$AuthUserDTOImplToJson(_$AuthUserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'full_name': instance.fullName,
      'phone_number': instance.phoneNumber,
      'is_driver': instance.isDriver,
    };
