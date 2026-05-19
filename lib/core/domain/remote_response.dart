import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_response.freezed.dart';

@freezed
class RemoteResponse<T> with _$RemoteResponse<T> {
  const RemoteResponse._();
  const factory RemoteResponse.noConnection() = _NoConnection<T>;
  const factory RemoteResponse.permissionDenied() = _PermissionDenied<T>;
  const factory RemoteResponse.withNewData({required T data}) = _WithNewData<T>;
  const factory RemoteResponse.error(String message) = _Error<T>;
}
