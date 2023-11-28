import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MenuPage.dart'; // Ensure this import is correct

class RestaurantPage extends StatelessWidget {
  final String restaurantName;

  RestaurantPage({Key? key, required this.restaurantName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch the menu using the static method from MenuPage
    List<MenuItem> menu = MenuPage.getMenuForRestaurant(restaurantName);

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurantName),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          // Access each MenuItem in the menu
          MenuItem menuItem = menu[index];
          return ListTile(
            title: Text(menuItem.name),
            trailing: Text('\$${menuItem.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
