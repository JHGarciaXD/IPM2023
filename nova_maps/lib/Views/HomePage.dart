import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nova_maps/Views/UniversityChoice.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Add a GlobalKey for the Scaffold to control the drawer
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the scaffoldKey
      appBar: AppBar(
        title: Center(child: Text("NOVA Maps")),
        leading: IconButton(
          icon: Icon(Icons.menu), // Add a menu icon on the left
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer(); // Open the drawer
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Add a notification icon on the right
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
              initialCenter: LatLng(38.66242134778433, -9.205404686249338),
              initialZoom: 16,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(38.66242134778433, -9.205404686249338),
                    width: 40,
                    height: 40,
                    child: FlutterLogo(),
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () => launchUrl(
                        Uri.parse('https://openstreetmap.org/copyright')),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            child: SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    controller: controller,
                    padding: const MaterialStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0)),
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                    trailing: <Widget>[],
                  );
                }, suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            }),
          )
        ],
      ),
      // Add a Drawer for the main options
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
              title: Text('Option 1'),
              onTap: () {
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Handle option 2
              },
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Handle option 2
              },
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Handle option 1
              },
            ),
            ListTile(
              title: Text('Choose an university'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UniversityChoice()),
                );              },
            ),
            // Add more options as needed
          ],
        ),
      ),
    );
  }
}
