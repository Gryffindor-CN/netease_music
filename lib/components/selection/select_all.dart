import 'package:flutter/material.dart';
import './selection_parent.dart';
import './circle_checkbox.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SelectAll extends StatefulWidget {
  final List songs;
  SelectAll({Key key, @required this.songs}) : super(key: key);
  @override
  SelectAllState createState() => SelectAllState();
}

class SelectAllState extends State<SelectAll> {
  bool allSelected = false;

  @override
  Widget build(BuildContext context) {
    return SelectionShareDataWidget(
        isSelectAll: allSelected,
        child: StickyHeader(
          header: Container(
            height: 50.0,
            color: Colors.blueGrey[700],
            padding: new EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              'Header #',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          content: new Container(
            child: new Text('1'),
          ),
        ));
  }
}
