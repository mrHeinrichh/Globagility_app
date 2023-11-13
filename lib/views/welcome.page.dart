import 'package:flutter/material.dart';
import 'package:globagility_app/views/leave.page.dart';
import 'package:globagility_app/views/official_business.page.dart';
import 'package:globagility_app/views/overtime.page.dart';
import 'package:globagility_app/views/time_entry.page.dart';
import 'package:globagility_app/widgets/hyperlink.widget.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to My App!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            HyperlinkWidget(
              text: 'New Leave-of-Absence',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaveRequestPage()),
                );
              },
            ),
            HyperlinkWidget(
              text: 'New Overtime',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OvertimePage()),
                );
              },
            ),
            HyperlinkWidget(
              text: 'New Official Business',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OfficialBusinessPage()),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                _showMyTimeEntryModal(context);
              },
              child: Text(
                'My Time Entry',
                style: TextStyle(
                  color: Colors.blue, // You can customize the text color
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMyTimeEntryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text('Organization 1'),
                    value: 'Organization 1',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Organization 2'),
                    value: 'Organization 2',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Organization 3'),
                    value: 'Organization 3',
                  ),
                ],
                onChanged: (String? value) {
                  // Handle organization change
                },
                hint: Text('Select an Organization'),
                isExpanded: true,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Please input Employee ID',
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeEntryPage()),
                  );
                },
                child: Text('Proceed'),
              ),
            ],
          ),
        );
      },
    );
  }
}
