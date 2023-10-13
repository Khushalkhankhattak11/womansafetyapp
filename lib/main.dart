import 'package:flutter/material.dart';
import 'package:safetyapp/features/authentication/view/auth/login_auth.dart';
import 'package:safetyapp/utiles/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safety App",
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: LoginAuth(),
    );
  }
}
