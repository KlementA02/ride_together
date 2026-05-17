// lib/features/auth/presentation/login_screen.dart
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ride_together/core/shared/auth_providers.dart';
import 'package:ride_together/features/auth/presentation/signup_screen.dart';
import 'package:ride_together/features/auth/application/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading =
        authState.maybeWhen(loading: () => true, orElse: () => false);

    // Structural listener watching state machine output triggers
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      developer.log('Login context mutation detected: $next');

      next.maybeWhen(
        authenticated: (user) {
          developer
              .log('Auth confirmed for UID: ${user.uid}. Routing to home.');
          context.go('/');
        },
        orElse: () {},
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              Text(
                'RIDE TOGETHER',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 64,
                      height: 0.9,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'LOG IN TO YOUR ACCOUNT',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 60),

              // Email Field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'EMAIL'),
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),

              // Password Field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'PASSWORD'),
                obscureText: true,
                enabled: !isLoading,
              ),
              const SizedBox(height: 24),

              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {}, child: const Text('FORGOT PASSWORD?'))),

              // Login Button
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        developer
                            .log('Attempting login pipeline via DDD notifier.');
                        authState.maybeWhen(
                          orElse: () {
                            ref.read(authNotifierProvider.notifier).signInUser(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                          },
                        );
                      },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('PROCEED'),
              ),

              // System Error Output Block using high-contrast design
              authState.maybeWhen(
                failure: (failure) => Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'ERROR: ${failure.when(
                      server: (msg) => msg.toUpperCase(),
                      invalidCredentials: () => "INVALID CREDENTIALS",
                      emailAlreadyInUse: () => "EMAIL ALREADY IN USE",
                      noConnection: () => "NO CONNECTION",
                    )}',
                    style: const TextStyle(
                      color: Colors
                          .black, // Monochrome design aesthetic accentuation
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),

              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          // Safe context navigation back to signup panel page
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const SignupScreen()),
                          );
                        },
                  child: const Text(
                    "DON'T HAVE AN ACCOUNT? SIGN UP",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
