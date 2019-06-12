import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../material/flexible_detail_bar.dart';

class AlbumBox extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AlbumBoxState();
  }
}

class _AlbumBoxState extends State<AlbumBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全局路由页面'),
      ),
      body: FlexibleDetailBar(),
    );
  }
}