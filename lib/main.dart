import 'package:flutter/material.dart';
import 'package:suitmedia_test/pages/home.dart';
import 'package:suitmedia_test/pages/palindrome.dart';
import 'package:suitmedia_test/pages/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    print("pausing..");
    await Future.delayed(const Duration(seconds: 3));
    print("done pausing..");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'palindrome',
      routes: {
        'palindrome': (context) => const PalindromePage(),
        'home': (context) => const HomePage(),
        'user': (context) => const UserPage(),
      },
    );
  }
}
