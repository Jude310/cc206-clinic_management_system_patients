import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Submit Login function
            },
            child: const Text('Login'),
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
    );
  }
}
