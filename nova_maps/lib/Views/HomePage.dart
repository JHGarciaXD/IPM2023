import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nova_maps/Views/UniversityChoice.dart';
import 'package:nova_maps/widgets/MapMarkers.dart';
import 'EventsPage.dart';
import 'WeatherPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? notificationsEnabled = false;
  double squareOpacity = 0.5;

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
              // Handle the notification action here
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
                  buildingButton(
                      const LatLng(38.66115, -9.20345),
                      "Building 2",
                      context
                  ),
                  restaurantButton(
                      const LatLng(38.66175, -9.20465),
                      "Cafeteria",
                      context
                  ),
                  buildingButton(
                      const LatLng(38.66085, -9.20575),
                      "Building 7",
                      context
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage()),
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
                color: Colors.blue.withOpacity(squareOpacity),
                child: Center(
                  child: Text(
                    'Weather',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherPage()),
                );
              },
            ),
            ListTile(
              title: Text('Menu'),
              onTap: () {
               
                // Handle option 2
              },
            ),
            ListTile(
              title: Text('Events'),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage()));
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
    );
  }
}
