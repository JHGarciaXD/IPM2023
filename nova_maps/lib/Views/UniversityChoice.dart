import 'package:flutter/material.dart';
import 'package:nova_maps/Views/CustomDrawerPage.dart.dart';
import 'package:nova_maps/Views/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double SPACING = 30;

class UniversityChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.0),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UniversityButton(
                      text: "NOVA FCT",
                      onPressed: () {
                        updateFirstTime();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomDrawerPage(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.0),
                    UniversityButton(
                      text: 'NOVA Medical School',
                      onPressed: () {
                        _showInDevelopmentPopup(context);
                      },
                    ),
                    SizedBox(height: 24.0),
                    UniversityButton(
                      text: 'NOVA FCSH',
                      onPressed: () {
                        _showInDevelopmentPopup(context);
                      },
                    ),
                    SizedBox(height: 24.0),
                    UniversityButton(
                      text: 'NOVA IMS',
                      onPressed: () {
                        _showInDevelopmentPopup(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0), // Added spacing before the footer
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Project done by group 8 IPM 2023/2024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    //fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> updateFirstTime() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('IsFirstTime', false);
}

void _showInDevelopmentPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'In Development',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text(
              'This map is not finished.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: Size(40, 20),
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

class UniversityButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  UniversityButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          padding: EdgeInsets.all(16),
          textStyle: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
