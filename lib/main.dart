// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';
// import 'package:netease_music/pages/netease.dart';
// import 'package:netease_music/router/Routes.dart';
// import './components/circle_bottom_bar.dart';
// import './components/tab_navigator.dart';
// import 'dart:ui';
// import './components/netease_toast.dart';
// import './pages/home_page.dart';
// import 'components/netease_navigation_bar.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   MyApp() {
//     final router = new Router();
//     Routes.configureRoutes(router);
//     Routes.router = router;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       // onGenerateRoute: Routes.router.generator,
//       theme: ThemeData(
//         primaryColor: Color(0xffC20C0C),
//       ),
//       home: MyStatefulWidget(),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   MyStatefulWidget({Key key}) : super(key: key);

//   @override
//   _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget>
//     with AutomaticKeepAliveClientMixin {
//   static GlobalKey<_MyStatefulWidgetState> _globalKey;
//   int currentIndex = 0;
//   @override
//   bool get wantKeepAlive => true;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

//   static List<Widget> _widgetOptions = <Widget>[
//     Scaffold(
//         appBar: AppBar(
//           title: Text('home'),
//         ),
//         body: Text('ss')),
//     Scaffold(
//         appBar: AppBar(
//           title: Text('business'),
//         ),
//         body: Text(
//           'ss',
//           style: optionStyle,
//         )),
//     Scaffold(
//         appBar: AppBar(
//           title: Text('school'),
//         ),
//         body: Text(
//           'ss',
//           style: optionStyle,
//         )),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _globalKey = GlobalKey<_MyStatefulWidgetState>();
//   }

//   Widget renderCircleTab(IconData iconData) {
//     return LogoApp(iconData);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _globalKey,
//         body: NeteaseBottomNavBar(
//           [
//             {'iconData': Icons.home, 'title': 'Home'},
//             {'iconData': Icons.business, 'title': 'Business'},
//             {'iconData': Icons.school, 'title': 'School'}
//           ],
//           onTap: (value) {
//             setState(() {
//               currentIndex = value;
//             });
//           },
//           currentIndex: currentIndex,
//           child:
//               currentIndex == 0 ? NeteaseHome() : _widgetOptions[currentIndex],
//         ));
//   }
// }

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class TabbedAppBarSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new DefaultTabController(
        length: choices.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text('Tabbed AppBar'),
            bottom: new TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return new Tab(
                  text: choice.title,
                  icon: new Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: new TabBarView(
            children: choices.map((Choice choice) {
              return new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new ChoiceCard(choice: choice),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CAR', icon: Icons.directions_car),
  const Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  const Choice(title: 'BOAT', icon: Icons.directions_boat),
  const Choice(title: 'BUS', icon: Icons.directions_bus),
  const Choice(title: 'TRAIN', icon: Icons.directions_railway),
  const Choice(title: 'WALK', icon: Icons.directions_walk),
];

class ChoiceCard extends StatefulWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;
  @override
  ChoiceCardState createState() => ChoiceCardState();
}

class ChoiceCardState extends State<ChoiceCard>
    with AutomaticKeepAliveClientMixin {
  int flag = 1;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Card(
      color: Colors.white,
      child: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text('$flag'),
            RaisedButton(
              onPressed: () {
                setState(() {
                  flag = 2;
                });
              },
              child: Text('22'),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(new TabbedAppBarSample());
}
