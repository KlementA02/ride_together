import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ride_together/core/shared/auth_providers.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading =
        authState.maybeWhen(loading: () => true, orElse: () => false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'JOIN\nRIDER\nTOGETHER.',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 64,
                      height: 0.9,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                'CREATE YOUR PROFILE',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 40),

              // Full Name Field
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'FULL NAME'),
                textCapitalization: TextCapitalization.words,
                enabled: !isLoading,
              ),
              const SizedBox(height: 20),

              // Phone Field
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'PHONE NUMBER'),
                keyboardType: TextInputType.phone,
                enabled: !isLoading,
              ),
              const SizedBox(height: 20),

              // Email Field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'EMAIL'),
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
              ),
              const SizedBox(height: 20),

              // Username Field
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'USERNAME'),
                enabled: !isLoading,
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'PASSWORD'),
                obscureText: true,
                enabled: !isLoading,
              ),
              const SizedBox(height: 40),

              // Sign Up Button
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        ref.read(authNotifierProvider.notifier).signUpUser(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                              fullName: _nameController.text.trim(),
                              phoneNumber: _phoneController.text.trim(),
                              username: _usernameController.text.trim(),
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
                    : const Text('CREATE ACCOUNT'),
              ),

              const SizedBox(height: 24),

              // Error feedback matching your custom failure objects
              authState.maybeWhen(
                failure: (failure) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'ERROR: ${failure.when(
                      server: (msg) => msg.toUpperCase(),
                      invalidCredentials: () => "INVALID CREDENTIALS",
                      emailAlreadyInUse: () => "EMAIL ALREADY IN USE",
                      noConnection: () => "NO CONNECTION",
                    )}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
