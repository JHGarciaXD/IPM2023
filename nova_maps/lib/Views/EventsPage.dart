import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  final List<Event> events = [
    Event(
      title: 'Flutter Hackathon',
      date: '2023-11-11',
      time: '10:00 AM - 6:00 PM',
      location: 'Google Office, Lisbon, Portugal',
      imageUrl: 'https://example.com/flutter-hackathon.png',
      description: 'A one-day hackathon for Flutter developers of all levels.',
    ),
    Event(
      title: 'Dart Conference',
      date: '2023-11-18',
      time: '9:00 AM - 5:00 PM',
      location: 'Porto Congress Centre, Porto, Portugal',
      imageUrl: 'https://example.com/dart-conference.png',
      description: 'A one-day conference for Dart developers of all levels.',
    ),
  ];

  final VoidCallback openDrawer;

  EventsPage({required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.8,
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(event: event),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.0),
                      ),
                      child: Image.network(
                        event.imageUrl,
                        height: 120.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.title,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Date: ${event.date}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Time: ${event.time}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          Text(
                            'Location: ${event.location}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            event.description,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Event {
  final String title;
  final String date;
  final String time;
  final String location;
  final String imageUrl;
  final String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    required this.description,
  });
}

class EventDetailsPage extends StatelessWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              event.imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16.0),
            Text(
              'Date: ${event.date}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Time: ${event.time}',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Location: ${event.location}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              event.description,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
