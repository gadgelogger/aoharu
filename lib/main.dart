import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:teamc/login.dart';

void main() {
  OpenAI.apiKey = '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';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
