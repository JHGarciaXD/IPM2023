import 'package:flutter/material.dart';
import 'package:nova_maps/Views/HomePage.dart';

import '../data/DrawerItems.dart';
import '../model/DrawerItem.dart';
import '../widgets/DrawerWidget.dart';
import 'EventsPage.dart';
import 'MenuPage.dart';
import 'UniversityChoice.dart';
import 'WeatherPage.dart';
// Import other necessary widgets like EventsPage, MapPage, etc.

class CustomDrawerPage extends StatefulWidget {
  @override
  _CustomDrawerPageState createState() => _CustomDrawerPageState();
}

class _CustomDrawerPageState extends State<CustomDrawerPage> {
  double yOffset = 0;
  double scaleFactor = 1;
  DrawerItem item = DrawerItems.home;

  // Add any other necessary variables and enums

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildDrawer(),
        buildPage(context),
      ],
    );
  }

  void openDrawer() => setState(() {
        yOffset = 430;
      });

  void closeDrawer() => setState(() {
        yOffset = 0;
        scaleFactor = 1;
      });

  Widget buildDrawer() => SafeArea(
        child: DrawerWidget(
          onSelectedItem: (item) {
            setState(() {
              this.item = item;
            });
            closeDrawer();
          },
        ),
      );

  Widget buildPage(BuildContext context) {
    return GestureDetector(
      onTap: closeDrawer,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        transform: Matrix4.translationValues(0, yOffset, 0)..scale(scaleFactor),
        child: AbsorbPointer(
          absorbing: yOffset > 0,
          child: getDrawerPage(),
        ),
      ),
    );
  }

  Widget getDrawerPage() {
    switch (item) {
      case DrawerItems.events:
        return EventsPage(openDrawer: openDrawer);
      case DrawerItems.home:
        return MyHomePage(openDrawer: openDrawer);
      case DrawerItems.menu:
        return MenuPage(openDrawer: openDrawer);
      case DrawerItems.notifications:
        return MyHomePage(openDrawer: openDrawer);
      case DrawerItems.university:
        return UniversityChoice();
      case DrawerItems.weather:
        return WeatherPage(location: LOCATION, openDrawer: openDrawer);
      default:
        return MyHomePage(openDrawer: openDrawer);
    }
  }

  // Add any additional methods or widgets used by CustomDrawerPage
}
