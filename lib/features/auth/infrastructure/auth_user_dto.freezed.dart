// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthUserDTO _$AuthUserDTOFromJson(Map<String, dynamic> json) {
  return _AuthUserDTO.fromJson(json);
}

/// @nodoc
mixin _$AuthUserDTO {
  @JsonKey(fromJson: stringValueChecker)
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringValueChecker)
  String get email => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringValueChecker)
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name', fromJson: stringValueChecker)
  String get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
  String get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_driver', fromJson: boolValueChecker)
  bool get isDriver => throw _privateConstructorUsedError;

  /// Serializes this AuthUserDTO to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthUserDTOCopyWith<AuthUserDTO> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserDTOCopyWith<$Res> {
  factory $AuthUserDTOCopyWith(
          AuthUserDTO value, $Res Function(AuthUserDTO) then) =
      _$AuthUserDTOCopyWithImpl<$Res, AuthUserDTO>;
  @useResult
  $Res call(
      {@JsonKey(fromJson: stringValueChecker) String uid,
      @JsonKey(fromJson: stringValueChecker) String email,
      @JsonKey(fromJson: stringValueChecker) String username,
      @JsonKey(name: 'full_name', fromJson: stringValueChecker) String fullName,
      @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
      String phoneNumber,
      @JsonKey(name: 'is_driver', fromJson: boolValueChecker) bool isDriver});
}

/// @nodoc
class _$AuthUserDTOCopyWithImpl<$Res, $Val extends AuthUserDTO>
    implements $AuthUserDTOCopyWith<$Res> {
  _$AuthUserDTOCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? username = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? isDriver = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isDriver: null == isDriver
          ? _value.isDriver
          : isDriver // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserDTOImplCopyWith<$Res>
    implements $AuthUserDTOCopyWith<$Res> {
  factory _$$AuthUserDTOImplCopyWith(
          _$AuthUserDTOImpl value, $Res Function(_$AuthUserDTOImpl) then) =
      __$$AuthUserDTOImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(fromJson: stringValueChecker) String uid,
      @JsonKey(fromJson: stringValueChecker) String email,
      @JsonKey(fromJson: stringValueChecker) String username,
      @JsonKey(name: 'full_name', fromJson: stringValueChecker) String fullName,
      @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
      String phoneNumber,
      @JsonKey(name: 'is_driver', fromJson: boolValueChecker) bool isDriver});
}

/// @nodoc
class __$$AuthUserDTOImplCopyWithImpl<$Res>
    extends _$AuthUserDTOCopyWithImpl<$Res, _$AuthUserDTOImpl>
    implements _$$AuthUserDTOImplCopyWith<$Res> {
  __$$AuthUserDTOImplCopyWithImpl(
      _$AuthUserDTOImpl _value, $Res Function(_$AuthUserDTOImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? username = null,
    Object? fullName = null,
    Object? phoneNumber = null,
    Object? isDriver = null,
  }) {
    return _then(_$AuthUserDTOImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isDriver: null == isDriver
          ? _value.isDriver
          : isDriver // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserDTOImpl extends _AuthUserDTO {
  const _$AuthUserDTOImpl(
      {@JsonKey(fromJson: stringValueChecker) required this.uid,
      @JsonKey(fromJson: stringValueChecker) required this.email,
      @JsonKey(fromJson: stringValueChecker) required this.username,
      @JsonKey(name: 'full_name', fromJson: stringValueChecker)
      required this.fullName,
      @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
      required this.phoneNumber,
      @JsonKey(name: 'is_driver', fromJson: boolValueChecker)
      required this.isDriver})
      : super._();

  factory _$AuthUserDTOImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserDTOImplFromJson(json);

  @override
  @JsonKey(fromJson: stringValueChecker)
  final String uid;
  @override
  @JsonKey(fromJson: stringValueChecker)
  final String email;
  @override
  @JsonKey(fromJson: stringValueChecker)
  final String username;
  @override
  @JsonKey(name: 'full_name', fromJson: stringValueChecker)
  final String fullName;
  @override
  @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
  final String phoneNumber;
  @override
  @JsonKey(name: 'is_driver', fromJson: boolValueChecker)
  final bool isDriver;

  @override
  String toString() {
    return 'AuthUserDTO(uid: $uid, email: $email, username: $username, fullName: $fullName, phoneNumber: $phoneNumber, isDriver: $isDriver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUserDTOImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isDriver, isDriver) ||
                other.isDriver == isDriver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, uid, email, username, fullName, phoneNumber, isDriver);

  /// Create a copy of AuthUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserDTOImplCopyWith<_$AuthUserDTOImpl> get copyWith =>
      __$$AuthUserDTOImplCopyWithImpl<_$AuthUserDTOImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserDTOImplToJson(
      this,
    );
  }
}

abstract class _AuthUserDTO extends AuthUserDTO {
  const factory _AuthUserDTO(
      {@JsonKey(fromJson: stringValueChecker) required final String uid,
      @JsonKey(fromJson: stringValueChecker) required final String email,
      @JsonKey(fromJson: stringValueChecker) required final String username,
      @JsonKey(name: 'full_name', fromJson: stringValueChecker)
      required final String fullName,
      @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
      required final String phoneNumber,
      @JsonKey(name: 'is_driver', fromJson: boolValueChecker)
      required final bool isDriver}) = _$AuthUserDTOImpl;
  const _AuthUserDTO._() : super._();

  factory _AuthUserDTO.fromJson(Map<String, dynamic> json) =
      _$AuthUserDTOImpl.fromJson;

  @override
  @JsonKey(fromJson: stringValueChecker)
  String get uid;
  @override
  @JsonKey(fromJson: stringValueChecker)
  String get email;
  @override
  @JsonKey(fromJson: stringValueChecker)
  String get username;
  @override
  @JsonKey(name: 'full_name', fromJson: stringValueChecker)
  String get fullName;
  @override
  @JsonKey(name: 'phone_number', fromJson: stringValueChecker)
  String get phoneNumber;
  @override
  @JsonKey(name: 'is_driver', fromJson: boolValueChecker)
  bool get isDriver;

  /// Create a copy of AuthUserDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthUserDTOImplCopyWith<_$AuthUserDTOImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
