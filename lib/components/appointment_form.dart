import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentFormPage extends StatelessWidget {
  const AppointmentFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Appointment'),
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _reasonController,
            decoration: InputDecoration(
              labelText: 'Reason of Visit',
              border: OutlineInputBorder(),
              contentPadding: const EdgeInsets.all(16.0),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 8.0),
              Text(
                'Selected Date: ${_dateFormat.format(_selectedDate)}',
                style: TextStyle(fontSize: 16.0),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => _selectDate(context),
                child: const Text(
                  'Choose Date',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Implement appointment submission logic here
              // You can use _reasonController.text and _selectedDate to get the form data
            },
            child: const Text('Submit'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
            ),
          ),
        ],
      ),
    );
  }
}
