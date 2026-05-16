import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/core/shared/auth_providers.dart';

import 'package:ride_together/features/auth/presentation/signup_screen.dart';
import 'package:ride_together/features/auth/presentation/login_screen.dart';
import 'package:ride_together/features/home/presentation/home_screen.dart';

// Manual Provider definition - no build_runner or .g.dart file required!
final appRouterProvider = Provider<GoRouter>((ref) {
  // Watch your domain auth state slice so the router recreates/redirects when state shifts
  final authState = ref.watch(authNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final matchedPath = state.matchedLocation;
      
      // Map your DDD state machine conditions directly
      final bool isAuthenticated = authState.maybeWhen(
        authenticated: (_) => true,
        orElse: () => false,
      );

      final isGoingToLogin = matchedPath == '/login';
      final isGoingToSignup = matchedPath == '/signup';

      // Navigation Route Guards
      if (!isAuthenticated) {
        // If they are headed to login or signup, allow safe passage
        if (isGoingToLogin || isGoingToSignup) return null;
        // Otherwise, force them back to the login wall
        return '/login';
      }

      // If they are authenticated but hit an auth entry gate, push them home
      if (isAuthenticated && (isGoingToLogin || isGoingToSignup)) {
        return '/';
      }

      // Allow normal progression
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
});