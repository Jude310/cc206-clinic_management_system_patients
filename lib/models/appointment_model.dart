class Appointment {
  final String id;
  final DateTime appointmentDate;
  String? appointmentReason;
  String? appointmentDiagnosis;
  bool isApproved;
  bool isCompleted;

  Appointment({
    required this.id,
    required this.appointmentDate,
    this.appointmentReason,
    this.appointmentDiagnosis,
    this.isApproved = false,
    this.isCompleted = false,
  }) {
    if (appointmentReason == '') {
      appointmentReason = 'No reason provided';
    }
    if (appointmentDiagnosis == '') {
      appointmentDiagnosis = 'No diagnosis provided';
    }

    if (DateTime.now().isAfter(appointmentDate)) {
      isCompleted = true;
    }
    if (DateTime.now().isBefore(appointmentDate)) {
      isApproved = true;
    }
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      appointmentReason: json['appointmentReason'],
      appointmentDiagnosis: json['appointmentDiagnosis'],
    );
  }
}
