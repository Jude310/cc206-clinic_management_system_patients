import 'package:flutter/material.dart';

class AppointmentFormPage extends StatelessWidget {
  const AppointmentFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Form'),
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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              // Implement appointment submission logic here
              // You can use _titleController.text and _descriptionController.text to get the form data
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
