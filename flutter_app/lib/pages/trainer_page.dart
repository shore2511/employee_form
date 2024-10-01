import 'package:flutter/material.dart';

class TrainerPage extends StatelessWidget {
  final List<Map<String, dynamic>> trainers = [
    {
      'name': 'John Doe',
      'subject': 'Mathematics',
      'icon': Icons.calculate,
    },
    {
      'name': 'Jane Smith',
      'subject': 'Science',
      'icon': Icons.science,
    },
    {
      'name': 'Emily Johnson',
      'subject': 'History',
      'icon': Icons.history_edu,
    },
    {
      'name': 'Michael Brown',
      'subject': 'Art',
      'icon': Icons.brush,
    },
    {
      'name': 'Linda Davis',
      'subject': 'Music',
      'icon': Icons.music_note,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainers'),
        backgroundColor: Color.fromRGBO(171, 178, 255, 1),
      ),
      body: ListView.builder(
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          final trainer = trainers[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(trainer['icon'], color: Color.fromRGBO(171, 178, 255, 1)),
              title: Text(trainer['name']),
              subtitle: Text(trainer['subject']),
            ),
          );
        },
      ),
    );
  }
}

