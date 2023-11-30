import 'package:cc206_clinic_management_website_patients/features/log_in/log_in_page.dart';
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
                _logOut(context);
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Log Out'),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _showDeleteAccountConfirmation(context);
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

  void _showDeleteAccountConfirmation(BuildContext context) {
    TextEditingController confirmationController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Column(
            children: [
              Text('To confirm, type "Farmacia Hinosa"'),
              const SizedBox(height: 8),
              TextFormField(
                controller: confirmationController,
                decoration: InputDecoration(labelText: 'Confirmation'),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (confirmationController.text == 'Farmacia Hinosa') {
                        // Implement logic for account deletion
                        Navigator.pop(context);
                      } else {
                        // Handle incorrect confirmation
                        // You might want to show an error message
                      }
                    },
                    child: Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _logOut(BuildContext context) {
    // Implement logic to log out
    // For now, just navigate back to the login page
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage()));
  }
}
