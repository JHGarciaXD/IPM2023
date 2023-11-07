import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'Views/UniversityChoice.dart';
import 'Views/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenStreetMap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UniversityChoice(),
    );
  }
}
