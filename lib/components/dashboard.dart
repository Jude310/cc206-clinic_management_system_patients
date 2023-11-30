import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'appointment_form.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

final List<String> appointmentHistories = [
    'Appointment 1 - Date 1',
    'Appointment 2 - Date 2',
    // Add more appointments as needed
  ];

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation App'),
      ),
      body: _getBody(),
      bottomNavigationBar: _getBottomNavigationBar(),
      floatingActionButton: _getFloatingActionButton(),
    );
  }

  Widget _getBody() {
    switch (_currentIndex) {
      case 0:
        return MyProfile();
      case 1:
        return _getDashboardScreen(); // Use a separate function for the dashboard
      case 2:
        return const SettingsScreen();
      default:
        return Container();
    }
  }

  Widget _getBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home Page',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  Widget? _getFloatingActionButton() {
    if (_currentIndex == 1) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppointmentFormPage()),
          );
        },
        child: const Icon(Icons.add),
      );
    } else {
      return null;
    }
  }

 Widget _getDashboardScreen() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.all(16),
              child: Container(
                height: 150,
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Welcome Angel Jude Diones',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Appointment History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: appointmentHistories.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(appointmentHistories[index]),
                        trailing: ElevatedButton(
                          onPressed: () {
                            // Handle the view button press
                            // You can navigate to another screen or show details
                            // related to the selected appointment.
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Change button color
                          ),
                          child: Text(
                            'View',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white, // Change text color
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}