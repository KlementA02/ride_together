import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/supabase_url.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseUrl.url,
    anonKey: SupabaseUrl.anonKey,
  );
  runApp(const ProviderScope(child: CarpoolStartApp()));
}


