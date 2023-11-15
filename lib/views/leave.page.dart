import 'package:flutter/material.dart';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  // Placeholder values for dropdown
  String _selectedLeaveType = 'Sick Leave';

  // Variables to store selected date and time
  DateTime? _startDate;
  DateTime? _endDate;

  // Function to show date picker
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

  // Function to show time picker
  Future<void> _selectTime(bool isStartDate) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        isStartDate
            ? _startDate = DateTime(
                _startDate!.year,
                _startDate!.month,
                _startDate!.day,
                picked.hour,
                picked.minute,
              )
            : _endDate = DateTime(
                _endDate!.year,
                _endDate!.month,
                _endDate!.day,
                picked.hour,
                picked.minute,
              );
      });
    }
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
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Employee ID',
                enabled:
                    false, // Set this property to false to disable the TextField
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
                        'Vacation',
                        'Personal Leave',
                        'Unpaid Leave',
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
                              _startDate != null
                                  ? '$_startDate'.split(' ')[1].substring(0, 5)
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
                              _endDate != null
                                  ? '$_endDate'.split(' ')[1].substring(0, 5)
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
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Comments'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement leave request submission logic
              },
              child: Text('Submit Leave Request'),
            ),
          ],
        ),
      ),
    );
  }
}
