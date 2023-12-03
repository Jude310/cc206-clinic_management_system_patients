import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';

import 'features/log_in/log_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hinosa Log In Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: colorScheme1,
        useMaterial3: true,
        // Add your theme configuration here
      ),
      home: LogInPage(),
    );
  }
}

// class AppNavigator extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: GlobalKey<NavigatorState>(),
//       onGenerateRoute: (settings) {
//         late Widget page;
//         switch (settings.name) {
//           case '/signup':
//             page = SignUp();
//             break;
//           case '/login':
//             page = LogInPage(); // Add your login page
//             break;
//           default:
//             // If the route is not found, navigate to the signup page by default
//             page = SignUp();
//         }

//         return MaterialPageRoute(builder: (context) => page);
//       },
//     );

//   }
// }
