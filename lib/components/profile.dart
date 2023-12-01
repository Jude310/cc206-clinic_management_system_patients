import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final String username = 'cuteCoder';
  final String birthdate = 'January 1, 2000';
  final String sex = 'Male';
  final int totalAppointments = 10; // Replace with actual total appointments
  final DateTime accountCreationDate = DateTime(2022, 1, 1); // Replace with actual date

 MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage('https://picsum.photos/seed/377/600'),
                ),
              ),
              Center(
                child: Text(
                  'Isaiah Louis Emmanuel S. Yee',
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
                data: 'isaiahlouis.yee@wvsu.edu.ph',
                icon: Icons.email,
              ),
              ProfileSection(title: 'Birthdate', data: birthdate, icon: Icons.cake),
              ProfileSection(title: 'Sex', data: sex, icon: Icons.person_outline),
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

  String _formatDate(DateTime date) {
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
