import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewRecordPage extends StatefulWidget {
  @override
  _ViewRecordPageState createState() => _ViewRecordPageState();
}

class _ViewRecordPageState extends State<ViewRecordPage> {
  // List to hold the employee data
  List<dynamic> employeeData = [];

  // List of colors for different cards
  final List<Color> cardColors = [
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.blue[100]!,
    Colors.yellow[100]!,
    Colors.purple[100]!,
  ];

  // Function to fetch data from API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3001/api/v1/getForm'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        employeeData = data['data'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Record'),
        backgroundColor: Color.fromRGBO(171, 178, 255, 1),
      ),
      body: employeeData.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching data
          : ListView.builder(
        itemCount: employeeData.length,
        itemBuilder: (context, index) {
          final employee = employeeData[index];
          final cardColor = cardColors[index % cardColors.length];

          return Card(
            color: cardColor,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee ID: ${employee["employeeId"]}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('Name: ${employee["name"]}'),
                  Text('Employment Type: ${employee["employmentType"]}'),
                  Text('Gender: ${employee["gender"]}'),
                  Text('Phone Number: ${employee["phoneNumber"]}'),
                  Text('Email: ${employee["email"]}'),
                  SizedBox(height: 8),
                  Text(
                    'Marks:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Subject', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Marks', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Hindi'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${employee["marks"]["hindi"]}'),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('English'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${employee["marks"]["english"]}'),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Math'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${employee["marks"]["math"]}'),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('CS'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${employee["marks"]["cs"]}'),
                        ),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('SST'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${employee["marks"]["sst"]}'),
                        ),
                      ]),
                    ],
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