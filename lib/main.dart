// main.dart

import 'package:flutter/material.dart';
import 'package:globagility_app/views/welcome.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(), // Set the WelcomePage as the initial route
    );
  }
}
