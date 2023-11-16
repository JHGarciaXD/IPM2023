import 'package:flutter/material.dart';
import '../data/DrawerItems.dart';
import '../model/DrawerItem.dart';

class DrawerWidget extends StatelessWidget {
  final ValueChanged<DrawerItem> onSelectedItem;

  const DrawerWidget({
    Key? key,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        // Add Material widget here
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
                  onTap: () {
                    onSelectedItem(item);
                  },
                ))
            .toList(),
      );
}
