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
      coordinates: LatLng(38.66162, -9.20681),
      name: "Tanto Faz Academic Bar",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: LatLng(38.66176, -9.20481),
      name: "Canteen",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: LatLng(38.66016, -9.20545),
      name: "My Spot Bar",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: LatLng(38.66264, -9.20518),
      name: "C@mpus Bar",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: LatLng(38.66199, -9.20787),
      name: "Nova Alquimia Restaurant",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: LatLng(38.65850, -9.20462),
      name: "Sport Bar",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: LatLng(38.66177, -9.20546),
      name: "Casa do Pessoal",
      type: "Restaurant",
      description: "..."),
  PointOfInterest(
      coordinates: const LatLng(38.66128, -9.20569),
      name: "Building 1",
      type: "Building",
      description: "Physics Department."),
  PointOfInterest(
      coordinates: const LatLng(38.66115, -9.20345),
      name: "Building 2",
      type: "Building",
      description: "This is the compsci building."),
  PointOfInterest(
      coordinates: const LatLng(38.663296, -9.207253),
      name: "Building 3",
      type: "Building",
      description: "IT Infrastructures division."),
  PointOfInterest(
      coordinates: const LatLng(38.66289, -9.20721),
      name: "Building 4",
      type: "Building",
      description: "Fablab."),
  PointOfInterest(
      coordinates: const LatLng(38.66342, -9.20686),
      name: "Building 5",
      type: "Building",
      description: "Caixa Geral de Depósitos Auditorium."),
  PointOfInterest(
      coordinates: const LatLng(38.66234, -9.20778),
      name: "Minotaur's Building",
      type: "Building",
      description: "Chemistry & Bio Chemistry Department."),
  PointOfInterest(
      coordinates: const LatLng(38.66085, -9.20575),
      name: "Building 7",
      type: "Building",
      description: "This is the math building."),
  PointOfInterest(
      coordinates: const LatLng(38.66048, -9.20662),
      name: "Building 8",
      type: "Building",
      description: "Mechanical Engineering Department."),
  PointOfInterest(
      coordinates: const LatLng(38.66021, -9.20713),
      name: "Building 9",
      type: "Building",
      description: "Civil Engineering building."),
  PointOfInterest(
      coordinates: const LatLng(38.66067, -9.20489),
      name: "Building 10",
      type: "Building",
      description: "Electrical Engineering Department."),
  PointOfInterest(
      coordinates: const LatLng(38.66293, -9.20659),
      name: "Building 11",
      type: "Building",
      description: "E-Learning Labs.")
];

class MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double squareOpacity = 0.5;
  FocusNode searchFocusNode = FocusNode();
  OverlayEntry? overlayEntry;
  PointOfInterest? selectedPoint;
  List<LatLng> navigationPoints = [];
  TextEditingController searchController = TextEditingController();
  List<PointOfInterest> filteredList = [];

  @override
  void initState() {
    super.initState();
    initializeFilters();
    searchController.addListener(_onSearchChanged);
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        showOverlay(context, filteredList);
      } else {
        removeOverlay();
      }
    });
  }

  void _onSearchChanged() {
    if (searchController.text.isNotEmpty) {
      _filterSearchResults(searchController.text);
    } else {
      removeOverlay();
    }
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
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

  void showOverlay(BuildContext context, List<PointOfInterest> filteredList) {
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // ... positioning code ...
        child: Material(
          elevation: 4.0,
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              var point = filteredList[index];
              return ListTile(
                title: Text(point.name),
                onTap: () => selectOption(point.name),
                // ... other list tile properties ...
              );
            },
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
          if (navigationPoints.isNotEmpty)
            Positioned(
              bottom: 100,
              right: 0,
              height:90,
              width: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    iconSize: 70,
                    icon: const Icon(Icons.circle),
                    alignment: Alignment.center,
                    color: Colors.red.shade300,
                    onPressed: () {
                      setState(() {
                        navigationPoints.clear();
                      });
                    },
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: const Icon(Icons.directions_off_sharp),
                    alignment: Alignment.center,
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        navigationPoints.clear();
                      });
                    },
                  ),
                ]
              )
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
                      controller: searchController,
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

  void _filterSearchResults(String query) {
    List<PointOfInterest> dummyListData = pointsOfInterest.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (query.isNotEmpty) {
      showOverlay(context, dummyListData);
      setState(() {
        filteredPointsOfInterest = dummyListData;
      });
    } else {
      setState(() {
        filteredPointsOfInterest = pointsOfInterest;
      });
    }
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
