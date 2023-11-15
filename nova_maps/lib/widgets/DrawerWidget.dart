import 'package:flutter/material.dart';
import '../data/DrawerItems.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material( // Add Material widget here
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildDrawerItems(context),
            ],
          ),
        ),
      );

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.all
            .map((item) => ListTile(
                  title: Text(item.title),
                  onTap: () {},
                ))
            .toList(),
      );
}
