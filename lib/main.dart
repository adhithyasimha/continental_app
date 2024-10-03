import 'package:continental/authpage/login.dart'; // Adjust the import path as necessary
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      theme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(), // Dark slate theme
      ),
      home: Scaffold(
        appBar: AppBar(
          // Using ShadAppBar for a pure Shadcn experience
          title: const Text('Continental'),
        ),
        body: const LoginPage(), // Set LoginPage as the body
      ),
    );
  }
}
