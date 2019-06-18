import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import 'components/bottom_share.dart';
import './components/bottom_share_comment.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Routes.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // onGenerateRoute: Routes.router.generator,
      theme: ThemeData.light().copyWith(canvasColor: Colors.transparent),
      home: DemoWidget(),
    );
  }
}

class DemoWidget extends StatefulWidget {
  @override
  DemoWidgetState createState() => DemoWidgetState();
}

class DemoWidgetState extends State<DemoWidget> {
  Map<String, dynamic> playlistObj = {};

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  void getHttp() async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/user/playlist?uid=1788319348");
      var result = json.decode(response.toString());
      setState(() {
        playlistObj = result['playlist'][1];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分享'),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: Container(
              child: RaisedButton(
                child: Text('share'),
                onPressed: () {
                  BottomShareComment.showBottomShareComment(
                      context, playlistObj['coverImgUrl']);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
