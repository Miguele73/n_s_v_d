import 'package:flutter/material.dart';
import 'package:n_s_v_d/main_screen.dart';
// import 'package:n_s_v_d/login_screen.dart';
// import 'package:n_s_v_d/validation_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainScreen());
  }
}
