import 'package:flutter/material.dart';

class Restaurant {
  final String name;
  final List<MenuItem> menu;

  Restaurant({required this.name, required this.menu});
}

class MenuItem {
  final String category;
  final String name;
  final double price;

  MenuItem({required this.category, required this.name, required this.price});
}

class MenuPage extends StatelessWidget {
  final VoidCallback openDrawer;

  MenuPage({required this.openDrawer});

  static List<MenuItem> getMenuForRestaurant(String restaurantName) {
    for (var restaurant in restaurants) {
      print("-------------------" + restaurant.name ==
          restaurantName +
              "----------------\n" +
              "-------------" +
              restaurant.name +
              "," +
              restaurantName);
      if (restaurant.name == restaurantName) {
        return restaurant.menu;
      }
    }
    return []; // Return an empty list if the restaurant is not found
  }

  static final List<Restaurant> restaurants = [
    Restaurant(
      name: 'A Tia',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'Canteen',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'Casa Do Pessoal',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'C@mpus Bar',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'My Spot Bar',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 3', price: 15.99),
        MenuItem(category: 'Meals', name: 'Meal 4', price: 17.99),
        MenuItem(category: 'Desserts', name: 'Dessert 3', price: 6.99),
        MenuItem(category: 'Desserts', name: 'Dessert 4', price: 8.99),
      ],
    ),
    Restaurant(
      name: 'Tanto Faz Academic Bar',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'Nova Alquimia Restaurant',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];

          return ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(restaurant.name),
              ],
            ),
            children: [
              for (var menuItem in restaurant.menu)
                ListTile(
                  title: Text(menuItem.name),
                  trailing: Text('\$${menuItem.price.toStringAsFixed(2)}'),
                ),
            ],
          );
        },
      ),
    );
  }
}

class MenuPage2 extends StatelessWidget {
  MenuPage2({super.key});

  final List<Restaurant> restaurants = [
    Restaurant(
      name: 'A Tia',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'Cantina',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'Casa Do Pessoal',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
    Restaurant(
      name: 'MySpot',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 3', price: 15.99),
        MenuItem(category: 'Meals', name: 'Meal 4', price: 17.99),
        MenuItem(category: 'Desserts', name: 'Dessert 3', price: 6.99),
        MenuItem(category: 'Desserts', name: 'Dessert 4', price: 8.99),
      ],
    ),
    Restaurant(
      name: 'TantoFaz',
      menu: [
        MenuItem(category: 'Meals', name: 'Meal 1', price: 10.99),
        MenuItem(category: 'Meals', name: 'Meal 2', price: 12.99),
        MenuItem(category: 'Desserts', name: 'Dessert 1', price: 5.99),
        MenuItem(category: 'Desserts', name: 'Dessert 2', price: 7.99),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];

          return ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(restaurant.name),
              ],
            ),
            children: [
              for (var menuItem in restaurant.menu)
                ListTile(
                  title: Text(menuItem.name),
                  trailing: Text('\$${menuItem.price.toStringAsFixed(2)}'),
                ),
            ],
          );
        },
      ),
    );
  }
}
