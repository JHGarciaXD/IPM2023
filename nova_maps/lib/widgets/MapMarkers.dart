import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nova_maps/Views/MenuPage.dart';
import 'package:nova_maps/Views/ResraurantPage.dart';

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

Marker pointOfInterestMarker(
    PointOfInterest point, BuildContext context, MyHomePageState homePage) {
  var color = const Color.fromARGB(255, 112, 173, 223);
  var icon = Icons.business;
  if (point.type == "Restaurant") {
    color = const Color.fromARGB(255, 236, 207, 134);
    icon = Icons.restaurant;
  }
  if (point.type == "ATM") {
    color = const Color.fromARGB(255, 120, 177, 122);
    icon = Icons.atm;
  }
  return _markerButton(point, color, icon, context, homePage);
}

Marker _markerButton(PointOfInterest point, Color color, IconData icon,
    BuildContext context, MyHomePageState homePage) {
  return Marker(
      point: point.coordinates,
      width: 100,
      height: 100,
      child: Stack(alignment: Alignment.center, children: [
        IconButton(
          iconSize: 60,
          icon: const Icon(Icons.location_pin),
          color: color,
          onPressed: () {
            homePage.selectPoint(point);
          },
        ),
        IconButton(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          iconSize: 20,
          icon: const Icon(Icons.circle),
          color: color,
          onPressed: () {
            homePage.selectPoint(point);
          },
        ),
        IconButton(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
          iconSize: 22,
          icon: Icon(icon),
          color: Colors.black,
          onPressed: () {
            homePage.selectPoint(point);
          },
        ),
      ]));
}

Marker selectedPointMenu(PointOfInterest point, MyHomePageState homePage) {
  return Marker(
    width: point.type == "Restaurant" ? 250 : 190,
    height: 120,
    point: point.coordinates,
    child: Center(
      child: GestureDetector(
        child: Container(
          color: Colors.grey.shade800.withOpacity(.90),
          child: Row(children: [
            IconButton(
              iconSize: 45,
              icon: const Icon(Icons.arrow_circle_left_rounded),
              alignment: Alignment.topLeft,
              onPressed: () {
                homePage.setState(() {
                  homePage.selectedPoint = null;
                });
              },
            ),
            if (point.type == "Restaurant")
              IconButton(
                iconSize: 45,
                icon: const Icon(Icons.fastfood_rounded),
                alignment: Alignment.topLeft,
                onPressed: () {
                  Navigator.push(
                    homePage.context,
                    MaterialPageRoute(builder: (context) => RestaurantPage(restaurantName: point.name,)),
                  );
                },
              ),
            IconButton(
              iconSize: 45,
              icon: const Icon(Icons.info),
              onPressed: () {
                pushNavigationPage(homePage.selectedPoint!, homePage.context);
              },
            ),
            IconButton(
              iconSize: 45,
              icon: const Icon(Icons.assistant_direction_sharp),
              onPressed: () {
                getPoints(homePage.selectedPoint?.coordinates).then((value) => {
                      homePage.setState(() {
                        homePage.navigationPoints = value;
                        homePage.selectedPoint = null;
                      })
                    });
                // Action upon circle icon press
              },
            ),
          ]),
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
