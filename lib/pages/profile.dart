import 'package:cc206_clinic_management_website_patients/utils/session/current_user.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  final String username = '${CurrentUser.currentUser?.username}';
  final DateTime? birthdate = CurrentUser.patient?.patientBirthDate;
  final String sex = '${CurrentUser.patient?.patientSex}';
  final int? totalAppointments = CurrentUser.patient?.appointmentsList.length; // Replace with actual total appointments
  final DateTime? accountCreationDate =
      CurrentUser.currentUser?.accountCreationDate; // Replace with actual date

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage:
                      NetworkImage('https://picsum.photos/seed/377/600'),
                ),
              ),
              Center(
                child: Text(
                  '${CurrentUser.currentUser?.fullName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '@$username',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ProfileSection(
                title: 'Email',
                data: '${CurrentUser.currentUser?.email}',
                icon: Icons.email,
              ),
              ProfileSection(
                  title: 'Birthdate', data: _formatDate(birthdate), icon: Icons.cake),
              ProfileSection(
                  title: 'Sex', data: sex, icon: Icons.person_outline),
              ProfileSection(
                title: 'Total Appointments',
                data: totalAppointments.toString(),
                icon: Icons.event,
              ),
              ProfileSection(
                title: 'Account Created On',
                data: _formatDate(accountCreationDate),
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final String data;
  final IconData icon;

  const ProfileSection({
    Key? key,
    required this.title,
    required this.data,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(data),
        ],
      ),
    );
  }
}
