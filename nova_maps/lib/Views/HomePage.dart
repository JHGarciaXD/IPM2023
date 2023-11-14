import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nova_maps/Views/UniversityChoice.dart';
import 'package:nova_maps/widgets/MapMarkers.dart';
import 'EventsPage.dart';
import 'MenuPage.dart';
import 'WeatherPage.dart';
import 'WeatherBox.dart';
import 'NotificationsList.dart';

import 'OrsAPI.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


List listOfPoints = [];
List<LatLng> points = [];

class MyHomePage extends StatefulWidget {

  Future<void> getCoordinates(String destination) async {
    var response = await http.get(getRouteUrl("-9.20592,38.66168", destination));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      listOfPoints = data['features'][0]['geometry']['coordinates'];
      points = listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();
    }
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? notificationsEnabled = false;
  double squareOpacity = 0.5;

  late LatLng markerCoordinates;
  bool showContainer = false;

  // Navigation System
  List<String> yourNotificationList = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    // Add more notifications as needed
  ];

  void test() {
    setState(() {
      points = listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();
    });
  }

  void getCoordinates(String destination) async {
    var response = await http.get(getRouteUrl("-9.20592,38.66168", destination));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      listOfPoints = data['features'][0]['geometry']['coordinates'];
      points = listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();
      test();
    }
  }

  void showRectanglePopup(BuildContext context, LatLng point) {
    setState(() {
      showContainer = true;
      markerCoordinates = point;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text("NOVA Maps")),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              _showNotificationsPanel();
            },
          ),
        ],
      ),
      body: Stack(
        children: [

          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(38.66168, -9.20592),
              initialZoom: 17,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              CurrentLocationLayer(),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                      point: LatLng(38.66115, -9.20345),
                      width: 100,
                      height: 100,
                      child: Stack(
                          alignment: Alignment.center,
                          children: [
                            IconButton(
                              iconSize: 60,
                              icon: const Icon(Icons.location_pin),
                              color: Colors.blue.shade400,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66115, -9.20345));},
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              iconSize: 20,
                              icon: const Icon(Icons.circle),
                              color: Colors.blue.shade400,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66115, -9.20345));},
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                              iconSize: 22,
                              icon: Icon(Icons.business),
                              color: Colors.black,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66115, -9.20345));},
                            ),
                          ]
                      )
                  ),
                  Marker(
                      point: LatLng(38.66175, -9.20465),
                      width: 100,
                      height: 100,
                      child: Stack(
                          alignment: Alignment.center,
                          children: [
                            IconButton(
                              iconSize: 60,
                              icon: const Icon(Icons.location_pin),
                              color: Colors.orange.shade400,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66175, -9.20465));},
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              iconSize: 20,
                              icon: const Icon(Icons.circle),
                              color: Colors.orange.shade400,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66175, -9.20465));},
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                              iconSize: 22,
                              icon: Icon(Icons.restaurant),
                              color: Colors.black,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66175, -9.20465));},
                            ),
                          ]
                      )
                  ),
                  Marker(
                      point: LatLng(38.66085, -9.20575),
                      width: 100,
                      height: 100,
                      child: Stack(
                          alignment: Alignment.center,
                          children: [
                            IconButton(
                              iconSize: 60,
                              icon: const Icon(Icons.location_pin),
                              color: Colors.blue.shade400,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66085, -9.20575));},
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                              iconSize: 20,
                              icon: const Icon(Icons.circle),
                              color: Colors.blue.shade400,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66085, -9.20575));},
                            ),
                            IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                              iconSize: 22,
                              icon: Icon(Icons.business),
                              color: Colors.black,
                              onPressed: () {showRectanglePopup(context, LatLng(38.66085, -9.20575));},
                            ),
                          ]
                      )
                  ),
                ],
              ),
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(points: points, color: Colors.blue, strokeWidth: 5),
                ],
              ),
            ],
          ),
          if (showContainer && markerCoordinates != null)
            Center(
              child: GestureDetector(
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.withOpacity(1.0),
                  child:
                    Stack(
                        children: [
                          IconButton(
                            iconSize: 25,
                            icon: const Icon(Icons.close),
                            alignment: Alignment.topLeft,
                            color: Colors.black,
                            onPressed: () {
                              setState(() {showContainer = false;});
                            },
                          ),
                          Center(
                            child:
                          Stack(
                            children: [
                              IconButton(
                                iconSize: 45,
                                icon: const Icon(Icons.circle),
                                color: Colors.blue,
                                onPressed: () {
                                  getCoordinates(markerCoordinates.longitude.toString()+","+markerCoordinates.latitude.toString());
                                  setState(() {showContainer = false;});
                                  // Action upon circle icon press
                                },
                              ),
                              Positioned(
                                top: 7,
                                left: 7, // Adjust this value to align the second IconButton as needed
                                child: IconButton(
                                  iconSize: 30,
                                  color: Colors.grey.shade100,
                                  icon: const Icon(Icons.directions),
                                  onPressed: () {
                                    getCoordinates(markerCoordinates.longitude.toString()+","+markerCoordinates.latitude.toString());
                                    setState(() {showContainer = false;});
                                    // Action upon directions icon press
                                  },
                                ),
                              ),
                            ],
                          ),
                          ),
                    ]
                ),
                ),
              ),
            ),
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                String location = 'Costa Da Caparica';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage(location: location)),
                );
                setState(() {
                  squareOpacity = 0.8;
                });
              },
              onTapUp: (_) {
                setState(() {
                  squareOpacity = 0.5;
                });
              },
              child: Container(
                width: 120,
                height: 120,
                color: Colors.grey.withOpacity(squareOpacity),
                child: Center(
                  child: const WeatherBox(location: 'Costa Da Caparica'),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Main Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Weather'),
              onTap: () {
                String location = 'Costa Da Caparica';
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage(location: location)),
                );
              },
            ),
            ListTile(
              title: Text('Menu'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MenuPage()));
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Events'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EventsPage()));
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Information'),
              onTap: () {
                // Handle option 2
              },
            ),
            ListTile(
              title: Text('Notifications'),
              trailing: Radio(
                value: notificationsEnabled,
                groupValue: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Choose a university'),
              onTap: () {
                // Navigate to the university choice screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UniversityChoice()),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          test();
          },
        child: const Icon(
          Icons.route,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showNotificationsPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: _buildSlidingPanel(),
          ),
        );
      },
    );
  }



  Widget _buildSlidingPanel() {
    return NotificationsList(notifications: yourNotificationList);
  }


}
