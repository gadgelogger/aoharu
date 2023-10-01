import 'package:flutter/material.dart';

// 共通でスナックバーを表示
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
