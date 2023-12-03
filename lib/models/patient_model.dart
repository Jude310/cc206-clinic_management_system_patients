import 'dart:convert';
import 'dart:developer' as developer;
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
  List<String> appointmentsListId;
  List<Appointment> appointmentsList = [];

  Patient({
    required this.patientId,
    required this.patientFName,
    required this.patientLName,
    required this.patientMName,
    this.patientSuffix = '',
    required this.patientBirthDate,
    required this.patientSex,
    this.appointmentsListId = const [],
  }) {
    refetchAppointments();
  }
  @override
  String toString() {
    return 'Patient{patientId: $patientId, patientFName: $patientFName, patientLName: $patientLName, patientMName: $patientMName, patientSuffix: $patientSuffix, patientBirthDate: $patientBirthDate, patientSex: $patientSex, appointmentsListId: $appointmentsListId, appointmentsList: $appointmentsList}';
  }

  List<Appointment> get getAllAppointments => appointmentsList;

  Future<List<Appointment>> get getUpcomingAppointments async {
    await refetchAppointments();
    return List<Appointment>.from(appointmentsList.where(
        (appointment) => appointment.appointmentDate.isAfter(DateTime.now())));
  }

  Future<List<Appointment>> get getPastAppointments async {
    await refetchAppointments();
    return List<Appointment>.from(appointmentsList.where(
        (appointment) => appointment.appointmentDate.isBefore(DateTime.now())));
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    developer.log(json.toString(), name: 'Patient.fromJson');
    return Patient(
      patientId: json['_id'],
      patientFName: json['patientFName'],
      patientLName: json['patientLName'],
      patientMName: json['patientMName'],
      patientSuffix: json['patientSuffix'] ?? '',
      patientBirthDate: DateTime.parse(json['patientBirthDate']),
      patientSex: json['patientSex'],
      appointmentsListId: List<String>.from(json['patientAppointments']),
    );
  }

  Future refetchAppointments() async {
    // developer.log(this.toString(), name: 'Patient');
    appointmentsList = [];
    var _response = await Session.get('/patients/$patientId/appointments');
    // developer.log(_response.body, name: 'Patient.refetchAppointments');
    if (_response.statusCode == 200) {
      final jsonData = json.decode(_response.body);
      if (jsonData.containsKey('getAppointments')) {
        // Extract the appointmentList array
        final List<dynamic> _appointments =
            jsonData['getAppointments']['patientAppointments'];
        appointmentsList = _appointments
            .map((appointmentJson) => Appointment.fromJson(appointmentJson))
            .toList();
        // developer.log(appointmentsList.toString(),name: 'appointments');
      } else {
        throw Exception('Invalid response format: Missing appointmentList');
      }
    } else {
      throw Exception('Failed to load appointments: ${_response.statusCode}');
    }
  }
}
