import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/router/Routes.dart';
import './components/circle_bottom_bar.dart';
// import 'dart:ui';
import './pages/home_page.dart';
import 'components/netease_navigation_bar.dart';

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
        canvasColor: Colors.transparent,
        primaryColor: Color(0xffC20C0C),
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static GlobalKey<_MyStatefulWidgetState> _globalKey;
  int currentIndex = 0;
  int _tabIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey<_MyStatefulWidgetState>();
    this._pageController =
        PageController(initialPage: this._tabIndex, keepPage: true);
  }

  Widget renderCircleTab(IconData iconData) {
    return LogoApp(iconData);
  }

  @override
  Widget build(BuildContext context) {
    var pageChooser = [
      NeteaseHome(),
      Scaffold(
          appBar: AppBar(
            title: Text('视频'),
          ),
          body: Text(
            '视频',
          )),
      Scaffold(
          appBar: AppBar(
            title: Text('我的'),
          ),
          body: Text(
            '我的',
          )),
    ];
    return Scaffold(
        key: _globalKey,
        body: NeteaseBottomNavBar([
          {'iconData': Icons.home, 'title': '发现'},
          {'iconData': Icons.play_circle_outline, 'title': '视频'},
          {'iconData': Icons.music_video, 'title': '我的'}
        ], onTap: (int index) {
          setState(() {
            _tabIndex = index;
            _pageController.jumpToPage(index);
          });
        },
            currentIndex: _tabIndex,
            child: PageView(
              children: pageChooser,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
            )));
  }
}
