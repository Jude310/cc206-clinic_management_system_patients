import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'profile.dart';
import 'settings.dart';
import 'appointment_form.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class AppointmentHistory {
  bool approved;
  final DateTime date;
  String reason;
  AppointmentHistory(
      {this.approved = false, required this.date, this.reason = ' '});
}

final List<AppointmentHistory> appointmentHistories = [
  AppointmentHistory(
      approved: false, date: DateTime(2023, 10, 1), reason: 'Checkup'),
  AppointmentHistory(
      approved: true, date: DateTime(2023, 08, 5), reason: 'Fever'),
  AppointmentHistory(
      approved: false, date: DateTime(2023, 04, 25), reason: 'Severe cough'),
  AppointmentHistory(
      approved: true, date: DateTime(2022, 11, 4), reason: 'Headache'),

  // Add more appointments as needed
];
final List<AppointmentHistory> upcomingAppointments = [
  AppointmentHistory(
      approved: false, date: DateTime(2023, 12, 03), reason: 'Checkup'),
  AppointmentHistory(
      approved: true, date: DateTime(2023, 12, 04), reason: 'Fever'),
  AppointmentHistory(
      approved: false, date: DateTime(2023, 12, 05), reason: 'Severe cough'),
  AppointmentHistory(
      approved: false, date: DateTime(2024, 01, 4), reason: 'Headache'),

  // Add more appointments as needed
];

class _DashBoardState extends State<DashBoard> {
  int _currentIndex = 1;
  final DateFormat _dateFormat = DateFormat('MMMM d, yyyy');

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
                    'Welcome, \n Isaiah Louis Emmanuel Yee',
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
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 16, 5),
              child: Text(
                'Upcoming Appointments',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: upcomingAppointments.length == 0
                        ? 1
                        : appointmentHistories.length,
                    itemBuilder: (context, index) {
                      if (upcomingAppointments.length != 0) {
                        return ListTile(
                          title: Text(
                              _dateFormat
                                  .format(upcomingAppointments[index].date),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    upcomingAppointments[index].approved == true
                                        ? Colors.green
                                        : Colors.grey,
                              ),
                              SizedBox(width: 5),
                              Text(
                                upcomingAppointments[index].approved == true
                                    ? 'Approved'
                                    : 'Pending',
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                    child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 20, 20, 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Appointment\nInformation',
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              CloseButton()
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            _dateFormat.format(
                                                upcomingAppointments[index]
                                                    .date),
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Reason of Appointment',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            upcomingAppointments[index].reason,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                              );

                              // Handle the view button press
                              // You can navigate to another screen or show details
                              // related to the selected appointment.
                            },
                            style: ElevatedButton.styleFrom(
                              primary: colorScheme1
                                  .primary, // Change background color
                              onPrimary:
                                  colorScheme1.onPrimary, // Change text color
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
                      } else {
                        return ListTile(
                          title: Text('No Upcoming Appointments'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 16, 5),
              child: Text(
                'Appointment History',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: appointmentHistories.length == 0
                        ? 1
                        : appointmentHistories.length,
                    itemBuilder: (context, index) {
                      if (appointmentHistories.length != 0) {
                        return ListTile(
                          title: Text(
                              _dateFormat
                                  .format(appointmentHistories[index].date),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          subtitle: Row(
                            children: [
                              CircleAvatar(
                                radius: 5,
                                backgroundColor:
                                    appointmentHistories[index].approved == true
                                        ? Colors.green
                                        : Color.fromARGB(255, 222, 167, 2),
                              ),
                              SizedBox(width: 5),
                              Text(
                                appointmentHistories[index].approved == true
                                    ? 'Completed'
                                    : 'Cancelled',
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                    child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 20, 20, 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Appointment\nInformation',
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              CloseButton()
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            _dateFormat.format(
                                                appointmentHistories[index]
                                                    .date),
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Reason of Appointment',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          Text(
                                            appointmentHistories[index].reason,
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                              );

                              // Handle the view button press
                              // You can navigate to another screen or show details
                              // related to the selected appointment.
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme1
                                  .tertiary, // Change background color
                              onPrimary:
                                  colorScheme1.onTertiary, // Change text color
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
                      } else {
                        return ListTile(
                          title: Text('No Recent Appointments'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}