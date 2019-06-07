import "package:flutter/material.dart";

import "./products.dart";

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  // Property

  List<String> _products = ["Food Tester"];

  // Method

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: RaisedButton(
              child: Text("Button"),
              onPressed: () {
                setState(() => _products.add("Advanced Food Tester"));
              }),
        ),
        Product(_products),
      ],
    );
  }
}
