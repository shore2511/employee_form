import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateRecordPage extends StatefulWidget {
  @override
  _CreateRecordPageState createState() => _CreateRecordPageState();
}

class _CreateRecordPageState extends State<CreateRecordPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController hindiMarksController = TextEditingController();
  final TextEditingController englishMarksController = TextEditingController();
  final TextEditingController mathMarksController = TextEditingController();
  final TextEditingController csMarksController = TextEditingController();
  final TextEditingController sstMarksController = TextEditingController();

  String? selectedEmploymentType;
  String? selectedGender;

  Future<void> createForm() async {
    final url = Uri.parse("http://localhost:3001/api/v1/createForm");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "employeeId": employeeIdController.text,
        "name": nameController.text,
        "employmentType": selectedEmploymentType,
        "gender": selectedGender,
        "phoneNumber": phoneNumberController.text,
        "email": emailController.text,
        "marks": {
          "hindi": int.parse(hindiMarksController.text),
          "english": int.parse(englishMarksController.text),
          "math": int.parse(mathMarksController.text),
          "cs": int.parse(csMarksController.text),
          "sst": int.parse(sstMarksController.text),
        }
      }),
    );

    if (response.statusCode == 201) {
      // Successfully created
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Created Successfully')));
    } else {
      // Error occurred
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Record',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(171, 178, 255, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: employeeIdController,
                decoration: InputDecoration(
                  labelText: 'Employee ID',
                  prefixIcon: Icon(Icons.badge,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Employee ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedEmploymentType,
                decoration: InputDecoration(
                  labelText: 'Employment Type (Regular/Adhoc)',
                  prefixIcon: Icon(Icons.work,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                items: ['Regular', 'Adhoc'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedEmploymentType = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select employment type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: InputDecoration(
                  labelText: 'Gender (Male/Female)',
                  prefixIcon: Icon(Icons.person_outline,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select gender';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              // Subject Marks
              TextFormField(
                controller: hindiMarksController,
                decoration: InputDecoration(
                  labelText: 'Hindi Marks',
                  prefixIcon: Icon(Icons.book,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: englishMarksController,
                decoration: InputDecoration(
                  labelText: 'English Marks',
                  prefixIcon: Icon(Icons.book,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: mathMarksController,
                decoration: InputDecoration(
                  labelText: 'Math Marks',
                  prefixIcon: Icon(Icons.calculate,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: csMarksController,
                decoration: InputDecoration(
                  labelText: 'CS Marks',
                  prefixIcon: Icon(Icons.computer,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: sstMarksController,
                decoration: InputDecoration(
                  labelText: 'SST Marks',
                  prefixIcon: Icon(Icons.book,color: Color.fromRGBO(171, 178, 255, 1),),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    createForm();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(171, 178, 255, 1), // Button color
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white, // Text color
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    employeeIdController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    hindiMarksController.dispose();
    englishMarksController.dispose();
    mathMarksController.dispose();
    csMarksController.dispose();
    sstMarksController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Color.fromRGBO(171, 178, 255, 1),
      hintColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(171, 178, 255, 1)),
        ),
        labelStyle: TextStyle(color: Color.fromRGBO(171, 178, 255, 1)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Color.fromRGBO(171, 178, 255, 1),
        ),
      ),
    ),
    home: CreateRecordPage(),
  ));
}