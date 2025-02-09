import 'package:flutter/material.dart';
import 'screens/splash_screen/splash_screen.dart'; // Import SplashScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(), // Use SplashScreen as the home screen
    );
  }
}