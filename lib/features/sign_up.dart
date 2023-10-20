// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpApp extends StatelessWidget {
  void _logIn() {}
  void _signUp() {}
  void _signInWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign Up Page")),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "Birthdate",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm Password",
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: _signUp,
                child: Text("Sign Up"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF43C6AC),
                    foregroundColor: Colors.black)),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: _logIn,
                child: Text("Login"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF43C6AC),
                    foregroundColor: Colors.black)),
            SizedBox(height: 16.0),
            OutlinedButton(
                onPressed: _signInWithGoogle,
                child: Text("Sign In with Google"),
                style: OutlinedButton.styleFrom(foregroundColor: Colors.black)),
          ],
        ),
      ),
    );
  }
}
