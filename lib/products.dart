import "package:flutter/material.dart";

class Product extends StatelessWidget {
  // Property

  final List<String> _products;

  // Constructor

  Product(this._products);

  // Method

  Card _makeCard(String title) {
    return Card(
      child: Column(
        children: [
          Image.asset("assets/food.jpg"),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: _products.map((product) => _makeCard(product)).toList());
  }
}
