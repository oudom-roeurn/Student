import 'package:flutter/material.dart';
import 'package:storage/view/homescreen.dart';
import 'package:storage/view/mainpage.dart';

void main(List<String> args) {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
