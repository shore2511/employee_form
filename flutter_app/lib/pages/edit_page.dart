import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  List<dynamic> forms = [];

  @override
  void initState() {
    super.initState();
    fetchForms();
  }

  Future<void> fetchForms() async {
    final response = await http.get(Uri.parse('http://localhost:3001/api/v1/getForm'));
    if (response.statusCode == 200) {
      setState(() {
        forms = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load forms');
    }
  }

  Future<void> deleteForm(String id) async {
    final response = await http.delete(Uri.parse('http://localhost:3001/api/v1/deleteForm/$id'));
    if (response.statusCode == 200) {
      setState(() {
        forms.removeWhere((form) => form['_id'] == id);
      });
    } else {
      throw Exception('Failed to delete form');
    }
  }

  Future<void> updateForm(String id, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('http://localhost:3001/api/v1/updateForm/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData),
    );
    if (response.statusCode == 200) {
      fetchForms();
    } else {
      throw Exception('Failed to update form');
    }
  }

  void showEditDialog(Map<String, dynamic> form) {
    final Map<String, dynamic> marks = form['marks'] ?? {};

    final TextEditingController employeeIdController = TextEditingController(text: form['employeeId']);
    final TextEditingController nameController = TextEditingController(text: form['name']);
    final TextEditingController employmentTypeController = TextEditingController(text: form['employmentType']);
    final TextEditingController emailController = TextEditingController(text: form['email']);
    final TextEditingController genderController = TextEditingController(text: form['gender']);
    final TextEditingController phoneNumberController = TextEditingController(text: form['phoneNumber'].toString());
    final TextEditingController hindiController = TextEditingController(text: marks['hindi']?.toString() ?? '0');
    final TextEditingController englishController = TextEditingController(text: marks['english']?.toString() ?? '0');
    final TextEditingController mathController = TextEditingController(text: marks['math']?.toString() ?? '0');
    final TextEditingController csController = TextEditingController(text: marks['cs']?.toString() ?? '0');
    final TextEditingController sstController = TextEditingController(text: marks['sst']?.toString() ?? '0');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Form'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: employeeIdController,
                    decoration: InputDecoration(
                      labelText: 'Employee ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: employmentTypeController,
                    decoration: InputDecoration(
                      labelText: 'Employment Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: genderController,
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: hindiController,
                    decoration: InputDecoration(
                      labelText: 'Hindi Marks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: englishController,
                    decoration: InputDecoration(
                      labelText: 'English Marks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: mathController,
                    decoration: InputDecoration(
                      labelText: 'Math Marks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: csController,
                    decoration: InputDecoration(
                      labelText: 'CS Marks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: sstController,
                    decoration: InputDecoration(
                      labelText: 'SST Marks',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateForm(form['_id'], {
                  'employeeId': employeeIdController.text,
                  'name': nameController.text,
                  'employmentType': employmentTypeController.text,
                  'email': emailController.text,
                  'gender': genderController.text,
                  'phoneNumber': phoneNumberController.text,
                  'marks': {
                    'hindi': int.parse(hindiController.text),
                    'english': int.parse(englishController.text),
                    'math': int.parse(mathController.text),
                    'cs': int.parse(csController.text),
                    'sst': int.parse(sstController.text),
                  },
                });
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void showDeleteDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this form?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteForm(id);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forms'),
        backgroundColor: Color.fromRGBO(171, 178, 255, 1),
      ),
      body: ListView.builder(
        itemCount: forms.length,
        itemBuilder: (context, index) {
          final form = forms[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(form['name'] ?? 'No Name'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => showEditDialog(form),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => showDeleteDialog(form['_id']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}