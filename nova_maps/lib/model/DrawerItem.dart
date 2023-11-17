import 'package:flutter/material.dart';

class DrawerItem {
  final String title;
  final IconData icon;
  final bool hasRadioButton; // New property for radio button

  const DrawerItem({required this.title, required this.icon, this.hasRadioButton = false});
}