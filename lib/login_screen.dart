import 'package:flutter/material.dart';
import 'package:n_s_v_d/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bool _isObscured = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String _username = 'MigUele';
  final String _password = '12345678';

  void _login() {
    final String enteredUsername = _usernameController.text;
    final String enteredPassword = _passwordController.text;

    print('Eingegebener Benutzername: $enteredUsername');
    print('Eingegebenes Passwort: $enteredPassword');

    if (enteredUsername == _username && enteredPassword == _password) {
      print('Login erfolgreich!');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(username: enteredUsername),
        ),
      );
    } else {
      print('Login fehlgeschlagen! Ungültige Anmeldeinformationen.');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ungültiger Benutzername oder Passwort'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFF66A5AD),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Benutzername',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: !_isObscured,
                decoration: const InputDecoration(
                  labelText: 'Passwort',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
