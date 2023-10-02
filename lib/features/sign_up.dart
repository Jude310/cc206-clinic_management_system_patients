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
  bool _isExistingUser = false;

  void _signUp() {
    String name = _nameController.text;
    String birthdate = _birthdateController.text;

    // In a real application, you would validate and store the data as needed.
    print("Name: $name");
    print("Birthdate: $birthdate");
    print("Is Existing User: $_isExistingUser");

    // You can add further logic to handle user registration.
  }

  void _signInWithGoogle() async {
    try {
      // Use the GoogleSignIn class to initiate Google Sign-In.
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

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
              controller: _birthdateController,
              decoration: InputDecoration(
                labelText: "Birthdate",
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isExistingUser,
                  onChanged: (value) {
                    setState(() {
                      _isExistingUser = value ?? false;
                    });
                  },
                ),
                Text("I am an existing user"),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signUp,
              child: Text("Sign Up"),
            ),
            SizedBox(height: 16.0),
            OutlinedButton(
              onPressed: _signInWithGoogle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/google_logo.png", // Add the path to your Google logo image
                    height: 24.0,
                  ),
                  SizedBox(width: 8.0),
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
