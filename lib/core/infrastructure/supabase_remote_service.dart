// lib/core/infrastructure/supabase_remote_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ride_together/core/constants/django_api.dart';
import 'package:ride_together/core/domain/remote_response.dart';

class DjangoRemoteService {
  final Dio _dio;

  DjangoRemoteService({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(connectTimeout: const Duration(seconds: 10), receiveTimeout: const Duration(seconds: 10)));

  Future<RemoteResponse<Map<String, dynamic>>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        DjangoApiConfig.resolveUrl(DjangoApiConfig.loginPath),
        data: {'email': email, 'password': password},
      );

      final payload = response.data is String
          ? jsonDecode(response.data as String)
          : response.data as Map<String, dynamic>;

      return RemoteResponse.withNewData(data: payload);
    } on DioException catch (e) {
      debugPrint('[DjangoRemoteService] Auth Error: ${e.response?.data ?? e.message}');
      return RemoteResponse.error(_extractMessage(e) ?? 'Authentication failed.');
    } catch (e) {
      return RemoteResponse.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _dio.post(DjangoApiConfig.resolveUrl(DjangoApiConfig.logoutPath));
    } catch (e) {
      debugPrint('[DjangoRemoteService] Error during sign out: $e');
    }
  }

  Future<RemoteResponse<List<Map<String, dynamic>>>> getNearbyRides({
    required double lat,
    required double lng,
    int radius = 5000,
  }) async {
    try {
      final response = await _dio.get(
        DjangoApiConfig.resolveUrl('/api/rides/nearby/'),
        queryParameters: {
          'lat': lat,
          'lng': lng,
          'radius_meters': radius,
        },
      );

      final payload = response.data is String
          ? jsonDecode(response.data as String)
          : response.data;

      final formattedList = List<Map<String, dynamic>>.from(payload as List<dynamic>);
      return RemoteResponse.withNewData(data: formattedList);
    } on DioException catch (e) {
      debugPrint('[DjangoRemoteService] Request Error: ${e.response?.data ?? e.message}');
      return RemoteResponse.error(_extractMessage(e) ?? 'Unable to fetch rides.');
    } catch (e) {
      return RemoteResponse.error(e.toString());
    }
  }

  Future<RemoteResponse<bool>> createRide(Map<String, dynamic> rideData) async {
    try {
      await _dio.post(DjangoApiConfig.resolveUrl('/api/rides/'), data: rideData);
      return const RemoteResponse.withNewData(data: true);
    } on DioException catch (e) {
      debugPrint('[DjangoRemoteService] Db Insert Failure: ${e.response?.data ?? e.message}');
      return RemoteResponse.error(_extractMessage(e) ?? 'Ride creation failed.');
    } catch (e) {
      return RemoteResponse.error(e.toString());
    }
  }

  String? _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      if (data.containsKey('detail')) return data['detail']?.toString();
      if (data.containsKey('message')) return data['message']?.toString();
      if (data.containsKey('error')) return data['error']?.toString();
      if (data.containsKey('errors')) return data['errors'].toString();
    }
    if (data is String && data.isNotEmpty) return data;
    return e.message;
  }
}