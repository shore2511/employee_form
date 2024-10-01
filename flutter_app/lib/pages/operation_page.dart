import 'package:flutter/material.dart';
import 'package:flutter_app/pages/trainer_page.dart';
import 'package:flutter_app/pages/view_record_page.dart';
import 'package:flutter_app/pages/edit_page.dart';
import 'package:animate_do/animate_do.dart';
import 'create_record_page.dart';

class OperationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Work Wise',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(171, 178, 255, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SlideInLeft(
                child: CustomCard(
                  title: 'Create Record',
                  icon: Icons.add_box,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateRecordPage()),
                    );
                  },
                ),
              ),
              SlideInRight(
                child: CustomCard(
                  title: 'View Record',
                  icon: Icons.view_list,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewRecordPage()),
                    );
                  },
                ),
              ),
              SlideInLeft(
                child: CustomCard(
                  title: 'Edit Record',
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditPage()),
                    );
                  },
                ),
              ),
              SlideInRight(
                child: CustomCard(
                  title: 'Trainer',
                  icon: Icons.person,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrainerPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomCard({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 40,
                color: Color.fromRGBO(171, 178, 255, 1),
              ),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


