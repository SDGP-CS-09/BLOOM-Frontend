import 'package:flutter/material.dart';
import 'screens/splash_screen/splash_screen.dart'; // Import SplashScreen
import 'screens/home/home_screen.dart'; // Import HomeScreen

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
      home: SplashScreen(), // Set SplashScreen as the home screen
      routes: {
        '/home': (context) => HomeScreen(), // Define named route for HomeScreen
      },
    );
  }
}