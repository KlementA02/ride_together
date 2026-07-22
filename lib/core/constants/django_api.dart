import 'package:flutter_dotenv/flutter_dotenv.dart';

class DjangoApiConfig {
  static String get baseUrl {
    final value = dotenv.env['DJANGO_API_BASE_URL']?.trim();
    if (value == null || value.isEmpty) {
      return 'http://10.0.2.2:8000';
    }
    return value;
  }

  static String get signupPath {
    final value = dotenv.env['DJANGO_SIGNUP_PATH']?.trim();
    return value == null || value.isEmpty ? 'api/signup/' : value;
  }

  static String get loginPath {
    final value = dotenv.env['DJANGO_LOGIN_PATH']?.trim();
    return value == null || value.isEmpty ? '/api/signin/' : value;
  }

  static String get logoutPath {
    final value = dotenv.env['DJANGO_LOGOUT_PATH']?.trim();
    return value == null || value.isEmpty ? '/api/logout/' : value;
  }

  static String resolveUrl(String path) {
    final normalizedBase = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return '$normalizedBase$normalizedPath';
  }
}
