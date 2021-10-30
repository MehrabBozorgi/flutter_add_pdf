import 'package:flutter/material.dart';
import 'package:flutter_add_pdf/file_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FileScreen(),
    );
  }
}
