import 'package:flutter/material.dart';
import 'package:ride_together/features/auth/presentation/login_screen.dart';

class CarpoolStartApp extends StatelessWidget {
  const CarpoolStartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const StartPage());
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  // Define all test routes here
  static const List<({String name, WidgetBuilder builder})> testRoutes = [
    (name: 'Login Screen', builder: _loginScreenBuilder),
  ];

  static Widget _loginScreenBuilder(BuildContext context) =>
      const LoginScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Together - Test Hub'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: testRoutes.length,
        itemBuilder: (context, index) {
          final route = testRoutes[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: route.builder),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: Text(route.name, style: const TextStyle(fontSize: 16)),
            ),
          );
        },
      ),
    );
  }
}
