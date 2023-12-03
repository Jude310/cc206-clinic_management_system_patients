import 'package:cc206_clinic_management_website_patients/models/appointment_model.dart';
import 'package:cc206_clinic_management_website_patients/theme/color_theme.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/current_user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentAppointmentsWidget extends StatefulWidget {
  const RecentAppointmentsWidget({super.key});

  @override
  State<RecentAppointmentsWidget> createState() =>
      _RecentAppointmentsWidgetState();
}

class _RecentAppointmentsWidgetState extends State<RecentAppointmentsWidget> {
  final DateFormat _dateFormat = DateFormat('MMMM d, yyyy');
  // late List<Appointment> appointmentHistories ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              FutureBuilder<List<Appointment>>(
                  future: CurrentUser.patient?.getPastAppointments,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          title:
                              const Center(child: CircularProgressIndicator()));
                    else if (snapshot.hasError)
                      return Center(child: Text('Error: ${snapshot.error}'));
                    else if (snapshot.hasData) {
                      List<Appointment> appointmentHistories =
                          snapshot.data as List<Appointment>;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: appointmentHistories.length == 0
                            ? 1
                            : appointmentHistories.length,
                        itemBuilder: (context, index) {
                          if (appointmentHistories.length != 0) {
                            return ListTile(
                              title: Text(
                                  _dateFormat.format(appointmentHistories[index]
                                      .appointmentDate),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 5,
                                    backgroundColor: appointmentHistories[index]
                                                .isApproved ==
                                            true
                                        ? Colors.green
                                        : Color.fromARGB(255, 222, 167, 2),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    appointmentHistories[index].isApproved ==
                                            true
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
                                                    appointmentHistories[index]
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
                                                '${appointmentHistories[index].appointmentReason} ',
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
                                  backgroundColor: colorScheme1
                                      .tertiary, // Change background color
                                  onPrimary: colorScheme1
                                      .onTertiary, // Change text color
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
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              title:
                                  Center(child: Text('No Recent Appointments')),
                            );
                          }
                        },
                      );
                    }
                    return const ListTile(
                      title: Text('No Recent Appointments'),
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
