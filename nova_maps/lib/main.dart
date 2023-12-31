import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nova_maps/Theme/ThemeConstant.dart';
import 'package:nova_maps/Theme/ThemeManager.dart';
import 'package:nova_maps/widgets/DrawerWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/CustomDrawerPage.dart.dart';
import 'Views/UniversityChoice.dart';
import 'Views/HomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool firstTime = prefs.getBool('IsFirstTime') ?? true;

  runApp(MyApp(isFirstTime: firstTime));
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false
      title: 'OpenStreetMap',
      theme: darkTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: CustomDrawerPage(),
    );
  }
}
