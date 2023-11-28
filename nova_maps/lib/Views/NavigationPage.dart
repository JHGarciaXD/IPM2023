import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:nova_maps/widgets/MapMarkers.dart';

class NavigationPage extends StatelessWidget {
  final PointOfInterest point;
  final String imageUrl;

  const NavigationPage(this.point, this.imageUrl, {super.key});

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
                imageUrl
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