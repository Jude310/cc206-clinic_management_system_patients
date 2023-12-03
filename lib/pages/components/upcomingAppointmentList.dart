import 'package:cc206_clinic_management_website_patients/models/appointment_model.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/current_user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingAppointmentWidget extends StatefulWidget {
  const UpcomingAppointmentWidget({super.key});

  @override
  State<UpcomingAppointmentWidget> createState() =>
      _UpcomingAppointmentWidgetState();
}

class _UpcomingAppointmentWidgetState extends State<UpcomingAppointmentWidget> {
  final DateFormat _dateFormat = DateFormat('MMMM d, yyyy');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              FutureBuilder<List<Appointment>>(
                  future: CurrentUser.patient?.getUpcomingAppointments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          title:
                              const Center(child: CircularProgressIndicator()));
                    else if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else if (snapshot.hasData) {
                      List<Appointment> upcomingAppointments =
                          snapshot.data as List<Appointment>;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: upcomingAppointments.length == 0
                            ? 1
                            : upcomingAppointments.length,
                        itemBuilder: (context, index) {
                          if (upcomingAppointments.length != 0) {
                            return ListTile(
                              title: Text(
                                  _dateFormat.format(upcomingAppointments[index]
                                      .appointmentDate),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: upcomingAppointments[index]
                                                .isApproved ==
                                            true
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    upcomingAppointments[index].isApproved ==
                                            true
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        .appointmentDate),
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                'Reason of Appointment',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                              Text(
                                                '${upcomingAppointments[index].appointmentReason}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                  onPrimary: colorScheme1
                                      .onPrimary, // Change text color
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
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 8),
                              title: Text('No Upcoming Appointments'),
                            );
                          }
                        },
                      );
                    }
                    return const ListTile(
                      title: Text('No Upcoming Appointments'),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
