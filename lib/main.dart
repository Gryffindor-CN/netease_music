import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
// import 'package:flutter_icons/flutter_icons.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShareWidget(),
    );
  }
}

class ShareWidget extends StatefulWidget {
  @override
  ShareWidgetState createState() => ShareWidgetState();
}

class ShareWidgetState extends State<ShareWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
  }

  Widget _buildShareIcons() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 46.0,
                      height: 46.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7), shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/friend_circle_16.png',
                      ),
                    ),
                    Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                  ],
                ),
                onTap: () {
                  print('share');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 46.0,
                      height: 46.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7), shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/friend_circle_32.png',
                      ),
                    ),
                    Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                  ],
                ),
                onTap: () {
                  print('share');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 46.0,
                      height: 46.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7), shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/friend_circle_32.png',
                      ),
                    ),
                    Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                  ],
                ),
                onTap: () {
                  print('share');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 46.0,
                      height: 46.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7), shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/friend_circle_32.png',
                      ),
                    ),
                    Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                  ],
                ),
                onTap: () {
                  print('share');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7), shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/friend_circle_32.png',
                      ),
                    ),
                    Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                  ],
                ),
                onTap: () {
                  print('share');
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 46.0,
                      height: 46.0,
                      decoration: BoxDecoration(
                          color: Color(0xfff7f7f7), shape: BoxShape.circle),
                      child: Image.asset(
                        'assets/icons/friend_circle_32.png',
                      ),
                    ),
                    Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                  ],
                ),
                onTap: () {
                  print('share');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareInterior() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: Text('分享至'),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 46.0,
                          height: 46.0,
                          decoration: BoxDecoration(
                              color: Color(0xfff7f7f7), shape: BoxShape.circle),
                          child: Icon(Icons.mail_outline),
                        ),
                        Text('云音乐动态', style: TextStyle(fontSize: 10.0))
                      ],
                    ),
                    onTap: () {
                      print('share');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: InkWell(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 46.0,
                          height: 46.0,
                          decoration: BoxDecoration(
                              color: Color(0xfff7f7f7), shape: BoxShape.circle),
                          child: Icon(Icons.music_note),
                        ),
                        Text('私信', style: TextStyle(fontSize: 10.0))
                      ],
                    ),
                    onTap: () {
                      print('share');
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分享'),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text('share'),
            onPressed: () {
              showModalBottomSheet<Null>(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return BottomSheet(
                      animationController: AnimationController(vsync: this),
                      backgroundColor: Colors.transparent,
                      onClosing: () {},
                      enableDrag: true,
                      builder: (BuildContext context) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16))),
                          height: 280,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: _buildShareInterior(),
                                ),
                                Divider(),
                                Flexible(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        _buildShareIcons(),
                                        Container(
                                          // margin: EdgeInsets.only(top: 10.0),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 60.0,
                                          child: InkWell(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '取消',
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        )
                                      ],
                                    ))
                              ]),
                        );
                      },
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
