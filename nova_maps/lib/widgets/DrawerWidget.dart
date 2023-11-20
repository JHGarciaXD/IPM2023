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

  Widget buildDrawerItems(BuildContext context) => Container(
        // Set the background color here
        child: Column(
          children: DrawerItems.all
              .map((item) => ListTile(
                    title: Text(item.title),
                    leading: Icon(item.icon),
                    trailing: item.hasRadioButton
                        ? Radio(
                            value: null, // Provide the appropriate value
                            groupValue:
                                null, // Provide the appropriate group value
                            onChanged:
                                null, // Provide the appropriate onChanged callback
                          )
                        : null,
                    onTap: () {
                      onSelectedItem(item);
                    },
                  ))
              .toList(),
        ),
      );
}
