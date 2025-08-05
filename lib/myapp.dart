import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muslim_life/ui/screens/splash_screen.dart';

class MuslimApp extends StatelessWidget {
  const MuslimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
