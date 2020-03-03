import 'package:flutter/material.dart';
import 'package:xmux_website/main_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XMUX Official Website',
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}
