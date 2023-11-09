import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Page'),
        leading: IconButton(
          icon: Icon(Icons.close), // Add a close icon
          onPressed: () {
            Navigator.pop(context); // Close the WeatherPage and go back to the main page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Weather Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // You can add weather information widgets here
          ],
        ),
      ),
    );
  }
}
