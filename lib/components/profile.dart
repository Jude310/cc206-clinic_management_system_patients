import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage('assets/images/pfp.png'),
            ),
          ),
          Center(
            child: Text(
              'Isaiah Louis Emmanuel S. Yee',
              style: TextStyle(fontSize: 24),
            ),
          ),
          const SizedBox(height: 20),
          ProfileSection(
            title: 'Email',
            data: 'isaiahlouis.yee@wvsu.edu.ph',
            icon: Icons.email,
          ),
          ProfileSection(title: 'Info', data: 'Cute', icon: Icons.info),
          ProfileSection(
            title: 'Hobbies',
            data: 'Studying, Sleeping, Eating, Learning, Playing',
            icon: Icons.gamepad,
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              'My Biography',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              ' I am a computer science student at West Visayas State University (WVSU). At 20 years old, I have had a learning journey with its own pace, marked by moments of shyness and a strong desire to learn. My academic path has had its challenges, and I sometimes felt like I am catching up slowly in the ever-changing world of computer science. But my determination to learn remains unwavering. While I would not call myself an exceptional coder, I am eager to learn and improve.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
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
          Text(title),
          const Spacer(),
          Text(data),
        ],
      ),
    );
  }
}
