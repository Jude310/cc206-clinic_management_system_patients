import 'package:cc206_clinic_management_website_patients/features/sign_up.dart';
import 'package:flutter/material.dart';
import 'theme/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hinosa Sign Up Page',
      theme: ThemeData(
        colorScheme: colorScheme1,
        useMaterial3: true,
      ),
      home: SignUpApp(),
    );
  }
}
