import 'dart:convert';

import 'package:cc206_clinic_management_website_patients/models/appointment_model.dart';
import 'package:cc206_clinic_management_website_patients/utils/session/sessions.dart';

class Patient {
  final String patientId;
  final String patientFName;
  final String patientLName;
  final String patientMName;
  final String patientSuffix;
  final DateTime patientBirthDate;
  final String patientSex;
  late List<Appointment> appointmentsList;

  Patient({
    required this.patientId,
    required this.patientFName,
    required this.patientLName,
    required this.patientMName,
    required this.patientSuffix,
    required this.patientBirthDate,
    required this.patientSex,
    this.appointmentsList = const [],
  });

  List<Appointment> get getAllAppointments => appointmentsList!;

  Future<List<Appointment>> get getUpcomingAppointments async {
    return List<Appointment>.from(appointmentsList.where(
        (appointment) => appointment.appointmentDate.isAfter(DateTime.now())));
  }

  Future<List<Appointment>> get getPastAppointments async{
    return List<Appointment>.from(appointmentsList.where(
        (appointment) => appointment.appointmentDate.isBefore(DateTime.now())));
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      patientId: json['_id'],
      patientFName: json['patientFName'],
      patientLName: json['patientLName'],
      patientMName: json['patientMName'],
      patientSuffix: json['patientSuffix'],
      patientBirthDate: DateTime.parse(json['patientBirthDate']),
      patientSex: json['patientSex'],
      appointmentsList: List<Appointment>.from(json['patientAppointments']
          .map((appointmentJson) => Appointment.fromJson(appointmentJson))),
    );
  }

  Future refetchAppointments() async {
    var _response = await Session.get('$patientId/appointments');

    if (_response.statusCode == 200) {
      final jsonData = json.decode(_response.body);
      if (jsonData.containsKey('getAppointments')) {
        // Extract the appointmentList array
        final List<dynamic> appointmentList = jsonData['getAppointments'];
        appointmentsList = appointmentList
            .map((appointmentJson) => Appointment.fromJson(appointmentJson))
            .toList();
      } else {
        throw Exception('Invalid response format: Missing appointmentList');
      }
    } else {
      throw Exception('Failed to load appointments: ${_response.statusCode}');
    }
  }
}
