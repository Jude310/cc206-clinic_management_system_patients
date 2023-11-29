import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'appointment_form.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

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
        return const MyProfile();
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Card(
            child: SizedBox(
            height: 100,
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome Angel Jude Diones',
              textAlign: TextAlign.center,),
              ]            
            ),
            ),
          ),
          const Text('Appointment History',
          textAlign: TextAlign.center,),
          const SizedBox(height: 20),
        ],
          ),
    );
  }
}
