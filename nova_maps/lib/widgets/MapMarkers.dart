import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../Views/HomePage.dart';
import '../Views/NavigationPage.dart';
import '../Views/OrsAPI.dart';

class PointOfInterest {
  final LatLng coordinates;
  final String name;
  final String type;
  final String description;

  PointOfInterest({
    required this.coordinates,
    required this.name,
    required this.type,
    required this.description,
  });
}

var pointsOfInterest = [
  PointOfInterest(
      coordinates: const LatLng(38.66115, -9.20345),
      name: "Building 2",
      type: "Building",
      description: "This is the compsci building."
  ),
  PointOfInterest(
      coordinates: const LatLng(38.66175, -9.20465),
      name: "Cafeteria",
      type: "Restaurant",
      description: "This is the cafeteria."
  ),
  PointOfInterest(
      coordinates: const LatLng(38.66085, -9.20575),
      name: "Building 7",
      type: "Building",
      description: "This is the math building."
  )
];

Marker pointOfInterestMarker(
    PointOfInterest point,
    BuildContext context,
    MyHomePageState homePage
) {
  var color = Colors.blue.shade400;
  var icon = Icons.business;
  if(point.type == "Restaurant"){
    color = Colors.yellow.shade700;
    icon = Icons.restaurant;
  }
  return _markerButton(point, color, icon, context, homePage);
}

Marker _markerButton(
    PointOfInterest point,
    Color color,
    IconData icon,
    BuildContext context,
    MyHomePageState homePage
) {
  return Marker(
      point: point.coordinates,
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            iconSize: 60,
            icon: const Icon(Icons.location_pin),
            color: color,
            onPressed: () {homePage.selectPoint(point);},
          ),
          IconButton(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            iconSize: 20,
            icon: const Icon(Icons.circle),
            color: color,
            onPressed: () {homePage.selectPoint(point);},
          ),
          IconButton(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
            iconSize: 22,
            icon: Icon(icon),
            color: Colors.black,
            onPressed: () {homePage.selectPoint(point);},
          ),
        ]
      )
  );
}

Marker selectedPointMenu(PointOfInterest point, MyHomePageState homePage){
  return Marker(
    width: 190,
    height: 120,
    point: point.coordinates,
    child: Center(
      child: GestureDetector(
        child: Container(
          color: Colors.grey.shade800.withOpacity(.90),
          child: Row(
              children: [
            IconButton(
              iconSize: 45,
              icon: const Icon(Icons.arrow_circle_left_rounded),
              alignment: Alignment.topLeft,
              color: Colors.yellow.shade200,
              onPressed: () {
                homePage.setState(() {
                  homePage.selectedPoint = null;
                });
              },
            ),
            IconButton(
              iconSize: 45,
              icon: const Icon(Icons.info),
              color: Colors.blue.shade200,
              onPressed: () {
                pushNavigationPage(
                    homePage.selectedPoint!,
                    homePage.context
                );
              },
            ),
            IconButton(
              iconSize: 45,
              icon: const Icon(Icons.assistant_direction_sharp),
              color: Colors.green.shade200,
              onPressed: () {
                getPoints(homePage.selectedPoint?.coordinates).then((value) =>
                {
                  homePage.setState(() {
                    homePage.navigationPoints = value;
                    homePage.selectedPoint = null;
                  })
                });
                // Action upon circle icon press
              },
            ),
          ]
              ),
            ),
          ),
        ),
      );
}

void pushNavigationPage(PointOfInterest point, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => NavigationPage(point)),
  );
}