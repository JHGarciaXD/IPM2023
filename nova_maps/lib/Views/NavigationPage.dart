import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:nova_maps/widgets/MapMarkers.dart';

class NavigationPage extends StatelessWidget {
  final PointOfInterest point;

  const NavigationPage(this.point, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(point.name),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
          children: [
            Image.network(
                'https://images.pexels.com/photos/936722/pexels-photo-936722.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
              child: Text(
                  point.description,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
            )
          ],
        ),
    );
  }
}