import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AppointmentFormPage extends StatelessWidget {
  const AppointmentFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Appointment',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: AppointmentForm(),
    );
  }
}

class AppointmentForm extends StatefulWidget {
  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final TextEditingController _reasonController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('MMMM d, yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _sendAppointmentRequest() async {
    final Map<String, dynamic> appointmentData = {
      'subject': 'Appointment Request',
      'text':
          'Name: John Cena\nAppointment Date: ${_dateFormat.format(_selectedDate)}\nReason: ${_reasonController.text}',
    };

    final String jsonData = jsonEncode(appointmentData);

    try {
      final http.Response response = await http.post(
        Uri.parse('http://localhost:3200/email/send-dynamic-email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Appointment request sent successfully!');
      } else {
        print(
            'Failed to send appointment request. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (error) {
      print('Error sending appointment request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a Date for your Appointment',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Card(
              color: Colors.blue, // Change this to your colorScheme1.primary
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: -10,
                    child: Opacity(
                      opacity: 0.4,
                      child: Image.asset(
                        'assets/images/calendar.png',
                        width: 150,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 105,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected Date:',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  color: Colors
                                      .white, // Change this to your colorScheme1.onPrimary
                                ),
                              ),
                              Text(
                                _dateFormat.format(_selectedDate),
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .white, // Change this to your colorScheme1.onPrimary
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => _selectDate(context),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors
                                  .orange, // Change this to your colorScheme1.tertiary
                              primary: Colors
                                  .white, // Change this to your colorScheme1.onSecondary
                              padding: const EdgeInsets.all(5.0),
                            ),
                            child: Icon(
                              Icons.edit_calendar_outlined,
                              color: Colors
                                  .blue, // Change this to your colorScheme1.primary
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Reason for Appointment',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              maxLines: 6,
              controller: _reasonController,
              decoration: InputDecoration(
                hintText: 'Indicate any reason for your appointment...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                contentPadding: const EdgeInsets.all(12.0),
              ),
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  await _sendAppointmentRequest();
                  Navigator.pop(context);
                },
                child: const Text('Submit',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  primary:
                      Colors.blue, // Change this to your colorScheme1.primary
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
