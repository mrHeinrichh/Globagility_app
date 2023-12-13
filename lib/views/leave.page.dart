import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LeaveRequestPage extends StatefulWidget {
  final String authToken;

  LeaveRequestPage({required this.authToken});

  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  String _selectedEmployeeType = 'Regular Exempt';
  String _selectedLeaveType = 'Sick Leave';
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _employeeIdController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _commentsController = TextEditingController();

  Future<void> _selectDate(bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        isStartDate ? _startDate = picked : _endDate = picked;
      });
    }
  }

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != (isStartTime ? _startTime : _endTime)) {
      setState(() {
        isStartTime ? _startTime = picked : _endTime = picked;
      });
    }
  }

  String _getDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) {
      return '';
    }
    return DateTime(date.year, date.month, date.day, time.hour, time.minute)
        .toIso8601String();
  }

  Future<void> _submitLeaveRequest() async {
    final url = Uri.parse('http://10.0.2.2:5000/api/leaves');

    final leaveRequestData = {
      "employeeId": int.parse(_employeeIdController.text),
      "employeeNumber": "100120",
      "employeeName": _fullNameController.text,
      "employeeType": _selectedEmployeeType,
      "leaveType": _selectedLeaveType,
      "startTime": _getDateTime(_startDate, _startTime),
      "endTime": _getDateTime(_endDate, _endTime),
      "startDate": _startDate!.toIso8601String(),
      "endDate": _endDate!.toIso8601String(),
      "status": "Pending",
      "reason": _reasonController.text,
      "comments": _commentsController.text,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.authToken}',
        },
        body: jsonEncode(leaveRequestData),
      );

      if (response.statusCode == 200) {
        print('Leave request submitted successfully');
        print(response.body);
        print(jsonDecode(response.body));
        print(response.statusCode);
      } else {
        print(
            'Failed to submit leave request. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        // You can display an error message to the user
      }
    } catch (e) {
      print('Error submitting leave request: $e');
      // You can display an error message to the user
    }
  }

  String _formatTimeOfDay(TimeOfDay? time) {
    if (time == null) {
      return '';
    }
    return '${time.hour}:${time.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Request Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _employeeIdController,
              decoration: InputDecoration(
                labelText: 'Employee ID',
                enabled: true,
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Employee Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      value: _selectedEmployeeType,
                      onChanged: (value) {
                        setState(() {
                          _selectedEmployeeType = value!;
                        });
                      },
                      items: <String>[
                        'Regular Exempt',
                        'Regular Non Exempt',
                        'Contractor',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Leave Type',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownButton<String>(
                      value: _selectedLeaveType,
                      onChanged: (value) {
                        setState(() {
                          _selectedLeaveType = value!;
                        });
                      },
                      items: <String>[
                        'Sick Leave',
                        'Vacation Leave',
                        'Maternity Leave',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Start Date and Time',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectDate(true),
                            child: Text(
                              _startDate != null
                                  ? '$_startDate'.split(' ')[0]
                                  : 'Select Date',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectTime(true),
                            child: Text(
                              _startTime != null
                                  ? '${_startTime!.hour}:${_startTime!.minute}'
                                  : 'Select Time',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'End Date and Time',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectDate(false),
                            child: Text(
                              _endDate != null
                                  ? '$_endDate'.split(' ')[0]
                                  : 'Select Date',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _selectTime(false),
                            child: Text(
                              _endTime != null
                                  ? '${_endTime!.hour}:${_endTime!.minute}'
                                  : 'Select Time',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _reasonController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            TextField(
              controller: _commentsController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Comments'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitLeaveRequest,
              child: Text('Submit Leave Request'),
            ),
          ],
        ),
      ),
    );
  }
}
