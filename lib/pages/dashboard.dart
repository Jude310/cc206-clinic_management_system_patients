import 'package:cc206_clinic_management_website_patients/pages/components/recentAppointmentList.dart';
import 'package:cc206_clinic_management_website_patients/pages/components/upcomingAppointmentList.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  void initState() {
    
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          icon: Icon(Icons.calendar_month),
          label: 'Appointments',
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
      return FloatingActionButton.extended(
        label: Text('Book Appointment'),
        icon: Icon(Icons.add),
        backgroundColor: colorScheme1.tertiary,
        foregroundColor: colorScheme1.onTertiary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AppointmentFormPage()),
          );
        },
      );
    } else {
      return null;
    }
  }

  Widget _getDashboardScreen() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              margin: EdgeInsets.all(16),
              color: colorScheme1.primary,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/Farmacia 3.svg',
                      color: colorScheme1.onPrimary,
                      width: 80,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Farmacia\nHinosa',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              color: colorScheme1.primary,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Welcome, \n ${CurrentUser.currentUser?.fullName}!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorScheme1.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            UpcomingAppointmentWidget(),
            RecentAppointmentsWidget(),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

