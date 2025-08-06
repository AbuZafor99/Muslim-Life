import 'package:flutter/material.dart';
import 'package:muslim_life/myapp.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  runApp(const MuslimApp());
}

