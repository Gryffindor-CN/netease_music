import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import './components/circle_bottom_bar.dart';
import './components/tab_navigator.dart';
import 'dart:ui';
import './components/netease_toast.dart';
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
  bool isShow = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    Scaffold(
        appBar: AppBar(
          title: Text('home'),
        ),
        body: Text('ss')),
    Scaffold(
        appBar: AppBar(
          title: Text('business'),
        ),
        body: Text(
          'ss',
          style: optionStyle,
        )),
    Scaffold(
        appBar: AppBar(
          title: Text('school'),
        ),
        body: Text(
          'ss',
          style: optionStyle,
        )),
  ];

  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey<_MyStatefulWidgetState>();
  }

  Widget renderCircleTab(IconData iconData) {
    return LogoApp(iconData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        body: NeteaseBottomNavBar(
          [
            {'iconData': Icons.home, 'title': 'Home'},
            {'iconData': Icons.business, 'title': 'Business'},
            {'iconData': Icons.school, 'title': 'School'}
          ],
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          child: currentIndex == 0
              ? Scaffold(
                  backgroundColor: Theme.of(context).primaryColor,
                  appBar: AppBar(
                    title: Text('home'),
                    elevation: 0.0,
                  ),
                  body: NeteaseToast(
                    toastText: '已为你推荐新的个性化内容!!!',
                    showToast: isShow,
                    child: RefreshIndicators(showToastCb: () {
                      setState(() {
                        isShow = true;
                      });
                    }),
                  ),
                )
              : _widgetOptions[currentIndex],
        ));
  }
}

class Content extends StatefulWidget {
  final String index;
  Content({this.index});
  ContentState createState() => ContentState();
}

class ContentState extends State<Content> {
  bool isShow = false;
  int currentIndex = 0;
  List<Widget> _widgetOptions = [
    Text(
      'Index 1: Business',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    ),
    Text(
      'Index 2: School',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return NeteaseBottomNavBar(
      [
        {'iconData': Icons.home, 'title': 'Home'},
        {'iconData': Icons.business, 'title': 'Business'},
        {'iconData': Icons.school, 'title': 'School'}
      ],
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      currentIndex: currentIndex,
      child: currentIndex == 0
          ? Scaffold(
              backgroundColor: Theme.of(context).primaryColor,
              appBar: AppBar(
                title: Text('home'),
                elevation: 0.0,
              ),
              body: NeteaseToast(
                toastText: '已为你推荐新的个性化内容!!!',
                showToast: isShow,
                child: RefreshIndicators(showToastCb: () {
                  setState(() {
                    isShow = true;
                  });
                }),
              ),
            )
          : _widgetOptions[currentIndex],
    );
  }
}
