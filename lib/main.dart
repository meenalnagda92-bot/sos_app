import 'package:flutter/material.dart';
import 'package:sos_app/screens/login_screen.dart';
import 'package:sos_app/theme/app_theme.dart';

void main() {
  runApp(const SosApp());
}

class SosApp extends StatelessWidget {
  const SosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}