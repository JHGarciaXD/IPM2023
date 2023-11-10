import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../Views/NavigationPage.dart';

void pushNavigationPage(LatLng point, String name, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NavigationPage(point, name)),
  );
}

Marker buildingButton(LatLng point, String name, BuildContext context) {
  return markerButton(point, Colors.blue.shade400, Icons.business, name, context);
}

Marker restaurantButton(LatLng point, String name, BuildContext context) {
  return markerButton(point, Colors.yellow.shade700, Icons.restaurant, name, context);
}

Marker markerButton(LatLng point, Color color, IconData icon, String name, BuildContext context) {
  return Marker(
      point: point,
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            iconSize: 60,
            icon: const Icon(Icons.location_pin),
            color: color,
            onPressed: () {pushNavigationPage(point, name, context);},
          ),
          IconButton(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            iconSize: 20,
            icon: const Icon(Icons.circle),
            color: color,
            onPressed: () {pushNavigationPage(point, name, context);},
          ),
          IconButton(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
            iconSize: 22,
            icon: Icon(icon),
            color: Colors.black,
            onPressed: () {pushNavigationPage(point, name, context);},
          ),
        ]
      )
  );
}