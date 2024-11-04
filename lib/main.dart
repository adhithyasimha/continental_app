import 'package:continental/homescreen/homescreen.dart';
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
      debugShowCheckedModeBanner: false, // Add this line
      home: Scaffold(
        body: HomeScreen(), // Set LoginPage as the body
      ),
    );
  }
}
