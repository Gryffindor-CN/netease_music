import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import 'components/selection/select_all.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import './pages/nearest_play.dart';
import './router/Routes.dart';

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
          primaryColor: Color(0xffC20C0C),
          textTheme: TextTheme(
              body1: TextStyle(color: Color(0xff271416)),
              title: TextStyle(fontSize: 14.0),
              subtitle: TextStyle(color: Colors.grey, fontSize: 12.0)),
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routes.router.navigateTo(context, '/nearestplaypage');
        },
        child: Text('最近播放'),
      ),
    );
  }
}

// class HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> lists = [];

//   void _httpRequest() async {
//     try {
//       Response response = await Dio()
//           .get("http://192.168.206.133:3000/user/record?uid=1788319348&type=1");
//       var result = json.decode(response.toString())['weekData'];
//       result.forEach((item) {
//         // print(item['song']['song']['name']);
//         lists.add({
//           'name': item['song']['song']['name'],
//           'id': item['song']['song']['id'],
//           'artist': item['song']['song']['artist']['name'],
//           'artistId': item['song']['song']['artist']['id'],
//         });
//       });

//       setState(() {});
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _httpRequest();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TabbedAppBarSample();
//   }
// }
