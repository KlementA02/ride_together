import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ride_together/core/constants/django_api.dart';
import 'package:ride_together/core/domain/remote_response.dart';
import 'auth_user_dto.dart';

class AuthRemoteService {
  final Dio _dio;

  AuthRemoteService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  /// Sets or clears the Bearer token in Dio default headers
  void _setAuthToken(String token) {
    if (token.isNotEmpty) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<RemoteResponse<({String token, AuthUserDTO user})>> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String username,
  }) async {
    try {
      final response = await _dio.post(
        DjangoApiConfig.resolveUrl(DjangoApiConfig.signupPath),
        data: {
          'username': username,
          'email': email,
          'password': password,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final payload = response.data is String
            ? jsonDecode(response.data as String)
            : response.data as Map<String, dynamic>;

        final token = payload['token'] as String? ?? '';
        final userData = (payload['user'] ?? payload) as Map<String, dynamic>;
        debugPrint('[AuthRemoteService] signup user data: $userData');

        if (token.isNotEmpty) {
          _setAuthToken(token);
        }

        final user = AuthUserDTO.fromJson(userData);
        debugPrint('[AuthRemoteService] Registration successful');

        return RemoteResponse.withNewData(
          data: (token: token, user: user),
        );
      } else {
        return RemoteResponse.error(
          'Registration failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      debugPrint(
          '[AuthRemoteService] ❌ Registration error: ${e.response?.data ?? e.message}');
      return RemoteResponse.error(
          _extractDjangoMessage(e) ?? 'Registration failed.');
    } catch (e) {
      debugPrint('[AuthRemoteService] ❌ Error during registration: $e');
      rethrow;
    }
  }

  Future<RemoteResponse<({String token, AuthUserDTO user})>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        DjangoApiConfig.resolveUrl(DjangoApiConfig.loginPath),
        data: {
          'username':
              email, // Or 'email', matching your Django backend login view
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final payload = response.data is String
            ? jsonDecode(response.data as String)
            : response.data as Map<String, dynamic>;

        final token = payload['token'] as String? ?? '';
        final userData = (payload['user'] ?? payload) as Map<String, dynamic>;
        debugPrint('Response received: ${response.data}');

        if (token.isNotEmpty) {
          _setAuthToken(token);
        }

        final user = AuthUserDTO.fromJson(userData);
        debugPrint('[AuthRemoteService] Login successful');

        return RemoteResponse.withNewData(
          data: (token: token, user: user),
        );
      } else {
        return RemoteResponse.error(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      debugPrint(
          '[AuthRemoteService] ❌ Login error: ${e.response?.data ?? e.message}');
      return RemoteResponse.error(
          _extractDjangoMessage(e) ?? 'Sign in failed.');
    } catch (e) {
      debugPrint('[AuthRemoteService] ❌ Error during login: $e');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _dio.post(DjangoApiConfig.resolveUrl(DjangoApiConfig.logoutPath));
    } catch (e) {
      debugPrint('[AuthRemoteService] Error during sign out: $e');
    } finally {
      _setAuthToken(''); // Clear token headers on logout
    }
  }

  String? _extractDjangoMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      if (data.containsKey('detail')) return data['detail']?.toString();
      if (data.containsKey('message')) return data['message']?.toString();
      if (data.containsKey('error')) return data['error']?.toString();
      if (data.containsKey('errors')) {
        final errors = data['errors'];
        if (errors is Map) return errors.values.join(', ');
        return errors.toString();
      }
      // Django DRF validation error standard output (e.g., {"username": ["This field is required."]})
      return data.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(' | ');
    }
    if (data is String && data.isNotEmpty) return data;
    return e.message;
  }
}
