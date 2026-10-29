import 'package:flutter/material.dart';

// MADL Task 2: Basic Hello World app..
void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Scaffold(
    appBar: AppBar(title: Text('My First Flutter App')),
    body: Center(child: Text('Hello World!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
  ),
));