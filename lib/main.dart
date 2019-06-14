import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import 'package:overlay_support/overlay_support.dart';
import './netease_toast.dart';

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
        onGenerateRoute: Routes.router.generator,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isShow = false;

  @override
  Widget build(BuildContext contxt) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toast demo'),
      ),
      body: NeteaseToast(
        showToast: isShow,
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 100.0),
                decoration: BoxDecoration(color: Colors.green),
                child: Container(
                  decoration: BoxDecoration(color: Colors.green),
                  width: 80,
                  height: 50,
                  child: RaisedButton(
                    child: Text('toast'),
                    onPressed: () {
                      // NeteaseOverlay(context).showToast();
                      setState(() {
                        isShow = true;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IosStyleToast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 100.0,
          child: SafeArea(
            child: DefaultTextStyle(
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        color: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Text('以为你推荐新的个性化内容')),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
