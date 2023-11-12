// ignore_for_file: prefer_const_constructors

import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';

class SignUpApp extends StatelessWidget {
  void _logIn() {}
  void _signUp() {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/LoginSignUp_BG (1) 1.png',
              // fit: BoxFit.cover,
            )),
        Scaffold(
          body: Padding( 
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16.0),
                Row(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 10.0),
                          child: Icon(Icons.account_circle,
                              color: colorScheme1.primary),
                        ),
                        labelText: 'First Name',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 10.0),
                          child: Icon(Icons.account_circle,
                              color: colorScheme1.primary),
                        ),
                        labelText: 'Last Name',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 10.0),
                      child: Icon(Icons.account_circle,
                          color: colorScheme1.primary),
                    ),
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 10.0),
                      child: Icon(Icons.account_circle,
                          color: colorScheme1.primary),
                    ),
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 10.0),
                      child: Icon(Icons.account_circle,
                          color: colorScheme1.primary),
                    ),
                    labelText: 'Birthdate',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF43C6AC),
                        foregroundColor: Colors.black),
                    child: Text("Sign Up")),
                SizedBox(height: 16.0),
                ElevatedButton(
                    onPressed: _logIn,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF43C6AC),
                        foregroundColor: Colors.black),
                    child: Text("Login")),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
