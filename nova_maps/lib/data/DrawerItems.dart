import 'package:flutter/material.dart';
import 'package:nova_maps/model/DrawerItem.dart';


class DrawerItems {
  static const home = DrawerItem(title: "Home", icon: Icons.home);
  static const weather = DrawerItem(title: "Weather", icon: Icons.cloud);
  static const menu = DrawerItem(title: "Menu", icon: Icons.food_bank);
  static const events = DrawerItem(title: "Events", icon: Icons.event);
  static const notifications = DrawerItem(title: "Notifications", icon: Icons.notifications, hasRadioButton: true);
  static const university = DrawerItem(title: "Choose your university", icon: Icons.book);

  static final List<DrawerItem> all = [
    home,
    weather,
    menu,
    events,
    notifications,
    university
  ];
}
