import 'package:flutter/material.dart';
import 'package:nova_maps/model/DrawerItem.dart';

class DrawerItems {
  static const weather = DrawerItem(title: "Weather", icon: Icons.cloud);
  static const menu = DrawerItem(title: "Menu", icon: Icons.food_bank);
  static const events = DrawerItem(title: "Events", icon: Icons.event);
  static const notifications =
      DrawerItem(title: "Notificationsvents", icon: Icons.notifications);
  static const university =
      DrawerItem(title: "Choose a university", icon: Icons.book);

  static final List<DrawerItem> all = [
    weather,
    menu,
    events,
    notifications,
    university
  ];
}
