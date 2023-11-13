// welcome_page.dart

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
            HyperlinkWidget(
              text: 'My Time Entry',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimeEntryPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
