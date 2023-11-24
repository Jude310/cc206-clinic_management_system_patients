import 'package:flutter/material.dart';
import 'features/log_in_page.dart';
import 'theme/color_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: colorScheme1,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: LogInPage());
  }
}
