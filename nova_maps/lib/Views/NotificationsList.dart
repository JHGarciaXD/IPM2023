import 'package:flutter/material.dart';

class NotificationsList extends StatelessWidget {
  final List<String> notifications;

  const NotificationsList({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(notifications[index]),
          // Add more ListTile customization as needed
        );
      },
    );
  }
}
