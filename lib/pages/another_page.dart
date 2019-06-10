import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('全局路由页面'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('全局路由页面'),
            RaisedButton(
              child: Text('返回'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}