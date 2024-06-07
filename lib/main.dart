import 'package:flutter/material.dart';
import 'text_recognition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ML Kit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextRecognition(),
    );
  }
}
