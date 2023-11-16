import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:nova_maps/Views/WeatherPageSecundary.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nova_maps/Views/UniversityChoice.dart';
import 'package:nova_maps/widgets/MapMarkers.dart';
import '../data/DrawerItems.dart';
import '../model/DrawerItem.dart';
import '../widgets/DrawerWidget.dart';
import 'EventsPage.dart';
import 'MenuPage.dart';
import 'WeatherPage.dart';
import 'WeatherBox.dart';

String LOCATION = 'Costa Da Caparica';

class MyHomePage extends StatefulWidget {
  final VoidCallback openDrawer;
  const MyHomePage({Key? key, required this.openDrawer}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

var pointsOfInterest = [
  PointOfInterest(
      coordinates: const LatLng(38.66115, -9.20345),
      name: "Building 2",
      type: "building",
      description: "This is the compsci building."),
  PointOfInterest(
      coordinates: const LatLng(38.66175, -9.20465),
      name: "Cafeteria",
      type: "restaurant",
      description: "This is the cafeteria."),
  PointOfInterest(
      coordinates: const LatLng(38.66085, -9.20575),
      name: "Building 7",
      type: "building",
      description: "This is the math building.")
];

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double squareOpacity = 0.5;
  FocusNode searchFocusNode = FocusNode();
  OverlayEntry? overlayEntry;
  PointOfInterest? selectedPoint;
  List<LatLng> navigationPoints = [];

  @override
  void initState() {
    super.initState();
    initializeFilters();
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

  Set<String> getLocationTypes() {
    return pointsOfInterest.map((e) => e.type).toSet();
  }

  Map<String, bool> typeFilters = {};

  void initializeFilters() {
    getLocationTypes().forEach((type) {
      typeFilters[type] = true; // Initially, all types are selected
    });
  }

  void setNavigationPoints(List<LatLng> points) {
    setState(() {
      navigationPoints = points;
    });
  }

  void selectPoint(PointOfInterest point) {
    setState(() {
      selectedPoint = point;
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
    return Stack(
      children: [
        buildPage(context),
      ],
    );
  }

  Widget buildPage(BuildContext context) {
    return GestureDetector(
      child: MapPage(context),
    );
  }

  Widget MapPage(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
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
              PolylineLayer(
                polylineCulling: false,
                polylines: [
                  Polyline(
                      points: navigationPoints,
                      color: Colors.blue,
                      strokeWidth: 5),
                ],
              ),
              MarkerLayer(markers: [
                ...filteredPointsOfInterest.map(
                    (point) => pointOfInterestMarker(point, context, this)),
                if (selectedPoint != null)
                  selectedPointMenu(selectedPoint!, this)
              ]),
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
                  IconButton(
                    splashColor: Colors.grey,
                    icon: Icon(Icons.list),
                    onPressed: () {
                      _showPointsOfInterestOptions(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WeatherPageSecond(
                            location: LOCATION,
                          )),
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 74, 74, 75)
                      .withOpacity(squareOpacity),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 120,
                height: 120,
                child: Center(
                  child: const WeatherBox(location: 'Costa Da Caparica'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return ListView(
              children: typeFilters.keys.map((type) {
                return CheckboxListTile(
                  title: Text(type),
                  value: typeFilters[type],
                  onChanged: (bool? value) {
                    setModalState(() {
                      typeFilters[type] = value!;
                    });
                    _applyFilters();
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }

  List<PointOfInterest> filteredPointsOfInterest = List.from(pointsOfInterest);

  void _applyFilters() {
    setState(() {
      filteredPointsOfInterest = pointsOfInterest.where((point) {
        return typeFilters[point.type] ?? true;
      }).toList();
    });
  }

  void _showPointsOfInterestOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: ListView.builder(
            itemCount: filteredPointsOfInterest.length,
            itemBuilder: (BuildContext context, int index) {
              final point = filteredPointsOfInterest[index];
              return ListTile(
                leading: Icon(Icons.place), // You can change this icon
                title: Text(point.name),
                subtitle: Text(point.type),
                onTap: () => {
                  // Handle the selection
                  selectPoint(point),
                  Navigator.of(context).pop(),
                },
              );
            },
          ),
        );
      },
    );
  }
}
