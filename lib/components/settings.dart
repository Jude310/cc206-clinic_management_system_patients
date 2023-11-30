import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Negative Colors Settings
              },
              child: ListTile(
                leading: Icon(Icons.invert_colors),
                title: Text('Negative Colors'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _showUpdateUsernameForm(context);
              },
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Update Username'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _showUpdatePasswordForm(context);
              },
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text('Update Password'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Perform Logout
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navigate to Account Deletion Request
              },
              child: ListTile(
                leading: Icon(Icons.delete),
                title: Text('Request Account Deletion'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateUsernameForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Username'),
          content: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'New Username'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to update username
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showUpdatePasswordForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Password'),
          content: Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Current Password'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to update password
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        );
      },
    );
  }
}
