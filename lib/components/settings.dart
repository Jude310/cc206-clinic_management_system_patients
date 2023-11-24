import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigate to Account Settings
            },
            child: const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Account Settings'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Perform Logout
            },
            child: const ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log Out'),
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Page'),
      ),
      body: const Center(
        child: Text('Appointment Form Goes Here'),
      ),
    );
  }
}
