import 'package:flutter/material.dart';

class ValidationScreen extends StatelessWidget {
  const ValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrierung'),
        backgroundColor: const Color(0xFF66A5AD),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            spacing: 16,
            children: [
              Text(
                'Neuen Account anlegen',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateUsername,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'e-Mail',
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validatePassword,
                obscureText: !true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Account erstellen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String abc = "abcdefghijklmnopqrstuvwxyz";
String abcUpper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
String abcLowerUpper = abc + abcUpper;
String numbers = "0123456789";
String specialChars = "!@#\$%^&*()_+[]{}|;:,.<>?";
String umlauts = "äöüßÄÖÜ";
String specialCharsUmlauts = specialChars + umlauts;

String? validateUsername(String? userInput) {
  if (userInput == null || userInput.isEmpty) {
    return 'Bitte geben Sie einen Benutzernamen ein';
  }
  if (userInput.length < 3) {
    return 'Benutzername muss mindestens 3 Zeichen lang sein';
  }
  if (userInput.length > 20) {
    return 'Benutzername darf maximal 20 Zeichen lang sein';
  }
  if (userInput.contains(' ')) {
    return 'Benutzername darf keine Leerzeichen enthalten';
  }
  if (userInput.contains('Benutzername')) {
    return 'Benutzername darf nicht "Benutzername" enthalten';
  }
  if (!abcLowerUpper.contains(userInput[0])) {
    return 'Benutzername muss mit einem Buchstaben beginnen';
  }
  if (userInput.contains(specialCharsUmlauts)) {
    return 'Benutzername darf keine Sonderzeichen enthalten';
  }
  return null;
}

String? validateEmail(String? userInput) {
  if (userInput == null || userInput.isEmpty) {
    return 'Bitte geben Sie eine E-Mail-Adresse ein';
  }

  if (!userInput.contains('@')) {
    return 'E-Mail-Adresse muss ein "@"-Zeichen enthalten';
  }
  if (!userInput.contains('.')) {
    return 'E-Mail-Adresse muss einen Punkt enthalten';
  }
  if (userInput.contains(' ')) {
    return 'E-Mail-Adresse darf keine Leerzeichen enthalten';
  }

  if (userInput.indexOf('@') == 0 ||
      userInput.indexOf('@') == userInput.length - 1) {
    return 'Das "@"-Zeichen ist an einer ungültigen Position.';
  }

  int atIndex = userInput.indexOf('@');
  int dotIndex = userInput.lastIndexOf('.');
  if (dotIndex < atIndex ||
      dotIndex == atIndex + 1 ||
      dotIndex == userInput.length - 1) {
    return 'Ungültige Punkt-Position nach dem "@"-Zeichen.';
  }

  if (userInput.split('@').length - 1 > 1) {
    return 'E-Mail-Adresse darf nur ein "@"-Zeichen enthalten.';
  }

  return null;
}

String? validatePassword(String? userInput) {
  if (userInput == null || userInput.isEmpty) {
    return 'Bitte geben Sie ein Passwort ein.';
  }
  if (userInput.length < 8) {
    return 'Passwort muss mindestens 8 Zeichen lang sein.';
  }
  if (userInput.length > 50) {
    return 'Passwort darf maximal 50 Zeichen lang sein.';
  }

  if (userInput.contains(' ')) {
    return 'Passwort darf keine Leerzeichen enthalten.';
  }

  if (userInput.toLowerCase().contains('passwort')) {
    return 'Passwort darf nicht "Passwort" enthalten.';
  }

  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  for (int i = 0; i < userInput.length; i++) {
    String char = userInput[i];

    if (abcUpper.contains(char)) {
      hasUppercase = true;
    } else if (abc.contains(char)) {
      hasLowercase = true;
    } else if (numbers.contains(char)) {
      hasNumber = true;
    } else if (specialCharsUmlauts.contains(char)) {
      hasSpecialChar = true;
    }
  }

  if (!hasUppercase) {
    return 'Passwort muss mindestens einen Großbuchstaben enthalten.';
  }
  if (!hasLowercase) {
    return 'Passwort muss mindestens einen Kleinbuchstaben enthalten.';
  }
  if (!hasNumber) {
    return 'Passwort muss mindestens eine Zahl enthalten.';
  }
  if (!hasSpecialChar) {
    return 'Passwort muss mindestens ein Sonderzeichen enthalten.';
  }

  return null;
}
