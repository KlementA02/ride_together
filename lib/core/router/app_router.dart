import 'package:go_router/go_router.dart';
import 'package:ride_together/features/auth/presentation/signup_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../features/auth/presentation/login_screen.dart';
import '../../../features/home/presentation/home_screen.dart'; // We'll create this next

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    // Redirect logic based on Auth State
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggingIn = state.matchedLocation == '/login';

      if (session == null && !isLoggingIn) return '/login';
      if (session != null && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
    ],
  );
}