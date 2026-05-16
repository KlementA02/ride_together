import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/supabase_url.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Supabase.initialize(
    url: SupabaseUrl.url,
    anonKey: SupabaseUrl.anonKey,
  );
  runApp(const ProviderScope(child: CarpoolStartApp()));
}
