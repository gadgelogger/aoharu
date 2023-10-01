import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:teamc/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // OpenAiのAPIキー設定
  OpenAI.apiKey = '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';

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const Login(),
    );
  }
}
