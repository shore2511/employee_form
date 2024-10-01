import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> employeeData = [];
  bool isLoading = true;
  String selectedChartType = 'Bar';

  @override
  void initState() {
    super.initState();
    fetchEmployeeData();
  }

  Future<void> fetchEmployeeData() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3001/api/v1/getForm'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success']) {
          setState(() {
            employeeData = jsonResponse['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          throw Exception('Failed to load employee data: ${jsonResponse['message']}');
        }
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load employee data');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Dashboard'),
        backgroundColor: Color.fromRGBO(171, 178, 255, 1),
        actions: [
          DropdownButton<String>(
            value: selectedChartType,
            items: <String>['Bar', 'Line', 'Area', 'Pie']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedChartType = newValue!;
              });
            },
            dropdownColor: Color.fromRGBO(171, 178, 255, 1),
            iconEnabledColor: Colors.white,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Total Number of Employees: ${employeeData.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ..._buildSubjectCharts(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSubjectCharts() {
    final subjects = ['hindi', 'english', 'math', 'cs', 'sst'];
    final subjectNames = ['Hindi', 'English', 'Math', 'CS', 'SST'];
    List<Widget> charts = [];

    for (int i = 0; i < subjects.length; i++) {
      final subjectData = _generateGraphData(subjects[i]);
      final maxMark = subjectData.isNotEmpty ? subjectData.map((data) => data.mark).reduce((a, b) => a > b ? a : b) : 0;
      final minMark = subjectData.isNotEmpty ? subjectData.map((data) => data.mark).reduce((a, b) => a < b ? a : b) : 0;

      charts.add(
        Column(
          children: [
            Text(
              '${subjectNames[i]} Marks',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Max: $maxMark, Min: $minMark'),
            SizedBox(
              height: 300,
              child: selectedChartType == 'Pie'
                  ? SfCircularChart(
                legend: Legend(isVisible: true),
                series: _getPieSeries(subjectData),
              )
                  : SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 100,
                  interval: 20,
                ),
                series: _getCartesianSeries(subjectData),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      );
    }

    return charts;
  }

  List<CartesianSeries<ChartData, String>> _getCartesianSeries(List<ChartData> data) {
    switch (selectedChartType) {
      case 'Line':
        return [
          LineSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.range,
            yValueMapper: (ChartData data, _) => data.mark,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ];
      case 'Area':
        return [
          AreaSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.range,
            yValueMapper: (ChartData data, _) => data.mark,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ];
      case 'Bar':
      default:
        return [
          ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.range,
            yValueMapper: (ChartData data, _) => data.mark,
            dataLabelSettings: DataLabelSettings(isVisible: true),
          ),
        ];
    }
  }

  List<PieSeries<ChartData, String>> _getPieSeries(List<ChartData> data) {
    return [
      PieSeries<ChartData, String>(
        dataSource: data,
        xValueMapper: (ChartData data, _) => data.range,
        yValueMapper: (ChartData data, _) => data.mark,
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    ];
  }

  List<ChartData> _generateGraphData(String subject) {
    if (employeeData.isEmpty) {
      return [];
    }

    final List<int> marks = [];

    for (var employee in employeeData) {
      var employeeMarks = employee['marks'];
      if (employeeMarks != null && employeeMarks[subject] != null) {
        marks.add(employeeMarks[subject]);
      }
    }

    final List<ChartData> chartData = [];
    final ranges = ['0-20', '20-40', '40-60', '60-80', '80-100'];
    final List<int> rangeCounts = List.filled(5, 0);

    for (var mark in marks) {
      if (mark >= 0 && mark < 20) {
        rangeCounts[0]++;
      } else if (mark >= 20 && mark < 40) {
        rangeCounts[1]++;
      } else if (mark >= 40 && mark < 60) {
        rangeCounts[2]++;
      } else if (mark >= 60 && mark < 80) {
        rangeCounts[3]++;
      } else if (mark >= 80 && mark <= 100) {
        rangeCounts[4]++;
      }
    }

    for (int i = 0; i < ranges.length; i++) {
      chartData.add(ChartData(ranges[i], rangeCounts[i].toDouble()));
    }

    return chartData;
  }
}

class ChartData {
  final String range;
  final double mark;

  ChartData(this.range, this.mark);
}