// lib/core/shared/null_value_checkers.dart

/// Safely evaluates incoming JSON values to guarantee a fallback integer.
int intValueChecker(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? 0;
  if (value is double) return value.toInt();
  return 0;
}

/// Safely evaluates incoming JSON values to guarantee a fallback double.
double doubleValueChecker(dynamic value) {
  if (value == null) return 0.0;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

/// Safely evaluates incoming JSON values to guarantee a fallback String.
String stringValueChecker(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  return value.toString();
}

/// Safely evaluates incoming JSON values to guarantee a fallback boolean status.
bool boolValueChecker(dynamic value) {
  if (value == null) return false;
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) {
    final lower = value.toLowerCase().trim();
    return lower == 'true' || lower == '1';
  }
  return false;
}