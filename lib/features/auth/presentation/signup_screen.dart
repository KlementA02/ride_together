import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'signup_controller.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
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
    final state = ref.watch(signupControllerProvider);

    debugPrint(state.error.toString());

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
                'JOIN\n RIDER\nTOGETHER.',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 64, height: 0.9),
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
              ),
              const SizedBox(height: 20),

              // Phone Field
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'PHONE NUMBER'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),

              // Email Field
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'EMAIL'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'PASSWORD'),
                obscureText: true,
              ),
              const SizedBox(height: 40),

              // Sign Up Button
              ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () => ref
                          .read(signupControllerProvider.notifier)
                          .signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                            fullName: _nameController.text,
                            phone: _phoneController.text,
                          ),
                child: state.isLoading
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

              if (state.hasError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    'ERROR: ${state.error.toString().toUpperCase()}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
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
