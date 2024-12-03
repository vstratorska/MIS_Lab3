import 'package:flutter/material.dart';
import 'package:lab2/screens/details.dart';
import 'package:lab2/screens/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      initialRoute: '/',
      routes: {
        '/' : (context) => const Home(),
        '/details': (context) => const Details(),
      },
    );
  }
}


