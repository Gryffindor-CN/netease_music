import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import 'components/netease_share/bottom_share.dart';
import './components/netease_share/bottom_share_comment.dart';
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
      // theme: ThemeData.light().copyWith(canvasColor: Colors.transparent),
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: Color(0xffC20C0C),
      ),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('分享'),
      ),
      body: Builder(
        builder: (context) {
          return Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text('普通分享'),
                  onPressed: () {
                    BottomShare.showBottomShare(context);
                  },
                ),
                RaisedButton(
                  child: Text('评论分享'),
                  onPressed: () {
                    BottomShareComment.showBottomShareComment(
                      context,
                      playlistObj['id'],
                      playlistObj['coverImgUrl'],
                      playlistObj['name'],
                      playlistObj['creator']['nickname'],
                    );
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
