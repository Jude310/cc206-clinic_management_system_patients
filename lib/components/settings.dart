import 'package:cc206_clinic_management_website_patients/features/log_in/log_in_page.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                SvgPicture.asset(
                  'assets/logo/Farmacia 3.svg',
                  color: colorScheme1.primary,
                  width: 80,
                ),
                SizedBox(
                  width: 10,
                ),
                const Text(
                  'Farmacia Hinosa',
                  style: TextStyle(
                    color: Color(0xFF191645),
                    fontFamily: 'Montserrat',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Settings',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () => _showUpdateUsernameForm(context),
                    leading: Icon(Icons.person),
                    title: Text('Update Username'),
                  ),
                  ListTile(
                    leading: Icon(Icons.invert_colors),
                    title: Text('Negative Colors'),
                  ),
                  ListTile(
                    onTap: () => _showUpdatePasswordForm(context),
                    leading: Icon(Icons.lock),
                    title: Text('Update Password'),
                  ),
                  ListTile(
                    onTap: () => _logOut(context),
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Log Out'),
                  ),
                  ListTile(
                    onTap: () => _showDeleteAccountConfirmation(context),
                    leading: Icon(Icons.delete),
                    title: Text('Request Account Deletion'),
                  ),
                ],
              ),
              
            ],
          ),
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
            mainAxisSize: MainAxisSize.min,
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
            mainAxisSize: MainAxisSize.min,
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
            mainAxisSize: MainAxisSize.min,
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
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LogInPage()));
  }
}
