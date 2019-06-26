import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
// import './router/home/application.dart';
import '../router/Routes.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final int tabItem;

  @override
  State<StatefulWidget> createState() {
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  void initState() {
    super.initState();
  }

  void _push(BuildContext context, {int materialIndex: 500}) {}

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: widget.navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (RouteSettings) {
          RoutePageBuilder builder;
          switch (RouteSettings.name) {
            case '/':
              builder = (_, __, ___) => Content(index: widget.tabItem);
              break;
          }
          return PageRouteBuilder(
            pageBuilder: builder,
          );
        });
  }
}

class Content extends StatelessWidget {
  final int index;
  Content({this.index});
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 1: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$index'),
      ),
      body: Center(
        child: RaisedButton(
          child: _widgetOptions[index],
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return Detail();
            }));
            // Navigator.of(context).pushNamed('/detail');
          },
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '页面B',
        ),
      ),
      body: Center(
        child: Text('测试测试'),
      ),
    );
  }
}
