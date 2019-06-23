import "package:flutter/material.dart";

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("학교 이름"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, row) {
          return ListTile(
            title: Text("title"),
            subtitle: Text("subtitle"),
          );
        },
      ),
    );
  }
}
