import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ride_together/core/router/app_router.dart';
import 'package:ride_together/core/theme/app_theme.dart';

class CarpoolStartApp extends ConsumerWidget {
  const CarpoolStartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We watch our appRouter provider here
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'InnoX Pool',
      debugShowCheckedModeBanner: false,
      
      // Use the Swiss/Monochrome theme we built
      theme: AppTheme.lightTheme,
      
      // Connect GoRouter to the MaterialApp
      routerConfig: router,
    );
  }
}