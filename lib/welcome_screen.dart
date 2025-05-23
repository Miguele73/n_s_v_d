import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String username;

  const WelcomeScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Screen'),
        backgroundColor: Color(0xFF66A5AD),
      ),
      body: Center(child: Text('Willkommen, $username!')),
    );
  }
}
