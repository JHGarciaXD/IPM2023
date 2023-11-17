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

class _CustomDrawerPageState extends State<CustomDrawerPage> {
  double yOffset = 0;
  double scaleFactor = 1;
  DrawerItem item = DrawerItems.home;
  String title = "NOVA Maps";
  bool? notificationsEnabled = true;

  // Add any other necessary variables and enums

  void _deleteNotification(String notificationKey) {
    setState(() {
      notificationDetails.remove(notificationKey);
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              if (yOffset == 0)
                openDrawer();
              else
                closeDrawer();
            },
          ),
          title: Text(title), // Replace with your title
          actions: [
            if (item == DrawerItems.home || item == DrawerItems.notifications)
              PopupMenuButton<String>(
                icon: Icon(Icons.notifications),
                onSelected: _handleNotificationSelection,
                offset: Offset(0, 50), // Adjust the offset as needed
                itemBuilder: (BuildContext context) {
                  return notificationDetails.keys.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              choice,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Handle delete action here
                                _deleteNotification(choice);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
          ],
        ),
        body: Stack(
          children: [
            buildDrawer(), // Assuming this is your drawer widget
            buildPage(context), // Your main page content
          ],
        ),
        // You can add other Scaffold properties like floatingActionButton, drawer, etc.
      ),
    );
  }

  void openDrawer() => setState(() {
        yOffset = (48.00*(DrawerItems.all.length));
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
        {
          title = "Events";
          return EventsPage(openDrawer: openDrawer);
        }
      case DrawerItems.home:
        title = "NOVA Maps";
        return MyHomePage(openDrawer: openDrawer);
      case DrawerItems.menu:
        title = "Menu";
        return MenuPage(openDrawer: openDrawer);
      case DrawerItems.notifications:
        title = "Notifications";
        return MyHomePage(openDrawer: openDrawer);
      case DrawerItems.university:
        title = "NOVA Maps";
        return UniversityChoice();
      case DrawerItems.weather:
        title = "NOVA Maps";
        return WeatherPage(location: LOCATION, openDrawer: openDrawer);
      default:
        return MyHomePage(openDrawer: openDrawer);
    }
  }

  void _handleNotificationSelection(String choice) {
    NotificationDetails details = notificationDetails[choice] ??
        NotificationDetails(
          title: 'Unknown Title',
          explanation: 'No explanation available',
          date: 'Unknown Date',
        );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            details.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(
                'Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                details.explanation,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Text(
                'Date: ${details.date}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Set the button's background color
                    minimumSize: Size(
                        40, 20), // Set the minimum width and height as needed
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Add any additional methods or widgets used by CustomDrawerPage
}
