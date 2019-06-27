import "package:flutter/material.dart";
import 'package:unitice/model/category.dart';
import 'package:unitice/widget/app_bar_title.dart';

class SearchPage extends StatefulWidget {
  final List<Category> categories;

  SearchPage(this.categories);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _currentCategoryName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(title: "검색"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              DropdownButton(
                value: _currentCategoryName,
                hint: Center(child: Text("카테고리")),
                items: widget.categories.map((category) {
                  return DropdownMenuItem<String>(
                    child: Center(child: Text(category.description)),
                    value: category.description,
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    _currentCategoryName = item;
                  });
                },
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                ),
              ),
              FlatButton(
                child: Text("검색"),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
