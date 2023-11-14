import 'package:flutter/cupertino.dart';
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
    var response =
        await http.get(getRouteUrl("-9.20592,38.66168", destination));
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

class NotificationDetails {
  final String title;
  final String explanation;
  final String date;

  NotificationDetails({
    required this.title,
    required this.explanation,
    required this.date,
  });
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? notificationsEnabled = true;
  double squareOpacity = 0.5;
  FocusNode searchFocusNode = FocusNode();
  OverlayEntry? overlayEntry;

  late LatLng markerCoordinates;
  bool showContainer = false;

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        showOverlay(context);
      } else {
        removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }



  // Navigation System
  Map<String, NotificationDetails> notificationDetails = {
    'Notification 1': NotificationDetails(
      title: 'Atenção Obras',
      explanation: 'Edificio 7 com obras no corredor xpto',
      date: '2023-11-14',
    ),
    'Notification 2': NotificationDetails(
      title: 'Parque 7 fechado',
      explanation: 'Até domingo, vão ocorrer limpezas no parque.',
      date: '2023-11-15',
    ),
    'Notification 3': NotificationDetails(
      title: 'Cantina fechada',
      explanation: 'Cantina só abre a partir de dezembro',
      date: '2023-11-16',
    ),
    // Add more details as needed
  };
  void test() {
    setState(() {
      points = listOfPoints
          .map((p) => LatLng(p[1].toDouble(), p[0].toDouble()))
          .toList();
    });
  }

  void getCoordinates(String destination) async {
    var response =
        await http.get(getRouteUrl("-9.20592,38.66168", destination));
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

  void showOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: keyboardHeight > 0
            ? 60
            : MediaQuery.of(context).size.height -
                320, // Adjust based on your UI
        left: 40,
        right: 40,
        child: Material(
          elevation: 4.0,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                  title: Text('Option 1'),
                  onTap: () => selectOption('Option 1')),
              ListTile(
                  title: Text('Option 2'),
                  onTap: () => selectOption('Option 2')),
              // Add more options here
            ],
          ),
        ),
      ),
    );
    overlayState?.insert(overlayEntry!);
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  void selectOption(String option) {
    // Handle the selection
    removeOverlay();
    // You can also set the selected option to the search bar if needed
    // searchController.text = option;
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
          PopupMenuButton<String>(
            icon: Icon(Icons.notifications),
            onSelected: _handleNotificationSelection,
            itemBuilder: (BuildContext context) {
              return notificationDetails.keys.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(choice),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Handle delete action here
                          _deleteNotification(choice);
                        },
                      ),
                    ],
                  ),
                );
              }).toList();
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
                      child: Stack(alignment: Alignment.center, children: [
                        IconButton(
                          iconSize: 60,
                          icon: const Icon(Icons.location_pin),
                          color: Colors.blue.shade400,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66115, -9.20345));
                          },
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          iconSize: 20,
                          icon: const Icon(Icons.circle),
                          color: Colors.blue.shade400,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66115, -9.20345));
                          },
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                          iconSize: 22,
                          icon: Icon(Icons.business),
                          color: Colors.black,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66115, -9.20345));
                          },
                        ),
                      ])),
                  Marker(
                      point: LatLng(38.66175, -9.20465),
                      width: 100,
                      height: 100,
                      child: Stack(alignment: Alignment.center, children: [
                        IconButton(
                          iconSize: 60,
                          icon: const Icon(Icons.location_pin),
                          color: Colors.orange.shade400,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66175, -9.20465));
                          },
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          iconSize: 20,
                          icon: const Icon(Icons.circle),
                          color: Colors.orange.shade400,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66175, -9.20465));
                          },
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                          iconSize: 22,
                          icon: Icon(Icons.restaurant),
                          color: Colors.black,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66175, -9.20465));
                          },
                        ),
                      ])),
                  Marker(
                      point: LatLng(38.66085, -9.20575),
                      width: 100,
                      height: 100,
                      child: Stack(alignment: Alignment.center, children: [
                        IconButton(
                          iconSize: 60,
                          icon: const Icon(Icons.location_pin),
                          color: Colors.blue.shade400,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66085, -9.20575));
                          },
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          iconSize: 20,
                          icon: const Icon(Icons.circle),
                          color: Colors.blue.shade400,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66085, -9.20575));
                          },
                        ),
                        IconButton(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                          iconSize: 22,
                          icon: Icon(Icons.business),
                          color: Colors.black,
                          onPressed: () {
                            showRectanglePopup(
                                context, LatLng(38.66085, -9.20575));
                          },
                        ),
                      ])),
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
          Positioned(
            bottom: 40,
            right: 15,
            left: 15,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    splashColor: Colors.grey,
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      _showFilterOptions(context);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: const Color.fromARGB(255, 255, 255, 255),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search..."),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showContainer && markerCoordinates != null)
            Center(
              child: GestureDetector(
                child: Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey.withOpacity(1.0),
                  child: Stack(children: [
                    IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.close),
                      alignment: Alignment.topLeft,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          showContainer = false;
                        });
                      },
                    ),
                    Center(
                      child: Stack(
                        children: [
                          IconButton(
                            iconSize: 45,
                            icon: const Icon(Icons.circle),
                            color: Colors.blue,
                            onPressed: () {
                              getCoordinates(
                                  markerCoordinates.longitude.toString() +
                                      "," +
                                      markerCoordinates.latitude.toString());
                              setState(() {
                                showContainer = false;
                              });
                              // Action upon circle icon press
                            },
                          ),
                          Positioned(
                            top: 7,
                            left:
                                7, // Adjust this value to align the second IconButton as needed
                            child: IconButton(
                              iconSize: 30,
                              color: Colors.grey.shade100,
                              icon: const Icon(Icons.directions),
                              onPressed: () {
                                getCoordinates(
                                    markerCoordinates.longitude.toString() +
                                        "," +
                                        markerCoordinates.latitude.toString());
                                setState(() {
                                  showContainer = false;
                                });
                                // Action upon directions icon press
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
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
                  MaterialPageRoute(
                      builder: (context) => WeatherPage(location: location)),
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
                color: const Color.fromARGB(255, 74, 74, 75)
                    .withOpacity(squareOpacity),
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
              decoration: BoxDecoration(),
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
                  MaterialPageRoute(
                      builder: (context) => WeatherPage(location: location)),
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
              title: Text('Notifications'),
              trailing: Checkbox(
                value: notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    notificationsEnabled = value!;
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blueAccent,
      //   onPressed: () {
      //     test();
      //   },
      //   child: const Icon(
      //     Icons.route,
      //     color: Colors.white,
      //   ),
      // ),
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

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.filter_1),
                  title: Text('Filter Option 1'),
                  onTap: () => {
                        // Handle Filter Option 1
                        Navigator.of(context).pop(),
                      }),
              ListTile(
                leading: Icon(Icons.filter_2),
                title: Text('Filter Option 2'),
                onTap: () => {
                  // Handle Filter Option 2
                  Navigator.of(context).pop(),
                },
              ),
              // Add more options as needed
            ],
          ),
        );
      },
    );
  }
  void _handleNotificationSelection(String choice) {
    NotificationDetails details =
        notificationDetails[choice] ??
            NotificationDetails(
              title: 'Unknown Title',
              explanation: 'No explanation available',
              date: 'Unknown Date',
            );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(details.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(details.explanation),
              SizedBox(height: 10),
              Text('Date: ${details.date}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget _buildSlidingPanel() {
    return Column(
      children: [
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: notificationDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notificationKey = notificationDetails.keys.toList()[index];
                    final NotificationDetails details = notificationDetails[notificationKey]!;

                    return Dismissible(
                      key: Key(notificationKey),
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        // Handle notification deletion
                        setState(() {
                          notificationDetails.remove(notificationKey);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListTile(
                          title: Text(details.title),
                          onTap: () {
                            _handleNotificationSelection(notificationKey);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  void _deleteNotification(String notificationKey) {
    setState(() {
      notificationDetails.remove(notificationKey);
    });
  }

}