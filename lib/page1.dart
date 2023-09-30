import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// テストページ
class page1 extends StatefulWidget {
  @override
  _StationInformationPageState createState() => _StationInformationPageState();
}

class _StationInformationPageState extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.red,
    ));
  }
}
