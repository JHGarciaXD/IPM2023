import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:latlong2/latlong.dart';

class NavigationPage extends StatelessWidget {
  final LatLng point;
  final String name;

  const NavigationPage(this.point, this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
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
              child: const Text(
                  'One of the buildings of all time. Click below to obtain navigation directions.',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  iconSize: 60,
                  icon: const Icon(Icons.circle),
                  color: Colors.blue,
                  onPressed: () {Navigator.pop(context);},
                ),
                IconButton(
                  iconSize: 40,
                  color: Colors.grey.shade100,
                  icon: const Icon(Icons.directions),
                  onPressed: () {Navigator.pop(context);},
                ),
              ],
            ),
          ],
        ),
    );
  }
}