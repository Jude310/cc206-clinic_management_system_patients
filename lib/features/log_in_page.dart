import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LogInPage extends StatelessWidget {
  LogInPage({super.key});
  final logInFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: logInFormKey,
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/logo/logo_1.svg',
                    width: 300,
                  ),
                  const Text(
                    'Patient Login',
                    
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      prefixIcon:
                          Padding(
                            padding: EdgeInsets.only(left: 16.0,right: 10.0),
                            child: Icon(Icons.account_circle, color: colorScheme1.primary),
                          ),
                      labelText: 'Username',
                    ),
                  
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Icon(Icons.vpn_key, color: colorScheme1.primary),
                      ),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 95.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Submit Login function
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            colorScheme1.tertiary),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: accentFgColor , fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  //make a hyperlink text
                      
                  const Text(
                    'No account? Cick here to Sign up',
                    style: TextStyle(
                      fontSize: 12.0,
                      decoration: TextDecoration.underline,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
