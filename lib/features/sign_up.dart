// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();

  void _logIn () {
    
  }
  void _signUp() {
    String name = _nameController.text;
    String birthdate = _birthdateController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmpasswordController.text;
    

    // In a real application, you would validate and store the data as needed.
    print("Name: $name");
    print("Birthdate: $birthdate");
    print("Email: $email");
    print("Phone: $phone");
    print("Password: $password");
    print("Confirm Password: $confirmPassword");
    // You can add further logic to handle user registration.
  }

  void _signInWithGoogle() async {
    try {
      // Use the GoogleSignIn class to initiate Google Sign-In.
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        print("Google Sign-In successful.");
        print("User ID: ${googleUser.id}");
        print("User Display Name: ${googleUser.displayName}");
        print("User Email: ${googleUser.email}");
      } else {
        print("Google Sign-In canceled.");
      }
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.datetime,
              controller: _birthdateController,
              decoration: InputDecoration(
                labelText: "Birthdate",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
              ),
            ),
            SizedBox(height: 16.0),
             TextField(
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              controller: _confirmpasswordController,
              decoration: InputDecoration(
                labelText: "Confirm Password",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signUp,
              child: Text("Sign Up"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _logIn,
              child: Text("Login"),
            ),
            SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: _signInWithGoogle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign In with Google"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
