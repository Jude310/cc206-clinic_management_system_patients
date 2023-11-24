import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'appointment_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

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
        return const ProfileScreen();
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
          const Text('Home Page'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
