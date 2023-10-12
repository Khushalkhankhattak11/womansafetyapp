import 'package:flutter/material.dart';
import 'package:safetyapp/features/userapp/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Safety App", 
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}