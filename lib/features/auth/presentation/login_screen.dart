import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'login_controller.dart';

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
    final state = ref.watch(loginControllerProvider);

    // Listen to login state changes and navigate on success
    ref.listen(loginControllerProvider, (previous, next) {
      developer.log('Login state changed: $next');

      next.whenData((_) {
        developer.log('Login successful! Navigating to home screen');
        context.go('/');
      });

     
    });

    final robertData = state.maybeWhen(
      orElse: () => null,
      data: (data) => data,
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              // Large Swiss Header
              Text(
                'RIDE TOGETHER',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 64, height: 0.9),
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
              ),
              const SizedBox(height: 24),

              // Password Field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'PASSWORD'),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              // Login Button
              ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        developer.log(
                          'Login button pressed - email: ${_emailController.text}',
                        );
                        ref
                            .read(loginControllerProvider.notifier)
                            .login(
                              _emailController.text,
                              _passwordController.text,
                            );
                      },
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('PROCEED'),
              ),

              if (state.hasError) ...[
                const SizedBox(height: 20),
                Text(
                  'ERROR: ${state.error.toString().toUpperCase()}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              // if (state.hasValue) ...[
              //   const SizedBox(height: 20),
              //   Text(
              //     'SUCCESS: ${robertData}',
              //     style: const TextStyle(
              //       color: Colors.green,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ],
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'DON\'T HAVE AN ACCOUNT? SIGN UP',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
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
