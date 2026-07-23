// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthUserDTOImpl _$$AuthUserDTOImplFromJson(Map<String, dynamic> json) =>
    _$AuthUserDTOImpl(
      uid: stringValueChecker(json['uid']),
      email: stringValueChecker(json['email']),
      username: stringValueChecker(json['username']),
      fullName: stringValueChecker(json['fullName']),
      phoneNumber: stringValueChecker(json['phoneNumber']),
      isDriver: boolValueChecker(json['isDriver']),
    );

Map<String, dynamic> _$$AuthUserDTOImplToJson(_$AuthUserDTOImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'username': instance.username,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'isDriver': instance.isDriver,
    };
