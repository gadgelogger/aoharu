import 'package:flutter/material.dart';
import 'package:teamc/create_post.dart';
import 'package:teamc/login.dart';

void main() {
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
      home: CreatePost(),
    );
  }
}
