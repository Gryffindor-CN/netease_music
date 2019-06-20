import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import './components/song_detail_dialog.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import './components/netease_share/bottom_share.dart';

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
        canvasColor: Colors.transparent,
        primaryColor: Color(0xffC20C0C),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<dynamic> songs = [];
  ScrollController _scrollController;
  int songCommentTotal = 0;

  void getHttp() async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/song/detail?ids=1339725941");
      var result = json.decode(response.toString());

      getSongComment(result['songs'][0]['id']).then((data) {
        print(data['total']);
        setState(() {
          songs = result['songs'];

          songCommentTotal = data['total'];
        });
      });
    } catch (e) {
      print(e);
    }
  }

  getSongComment(int id) async {
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/comment/music?id=$id");
      var result = json.decode(response.toString());

      return result;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getHttp();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      key: _globalKey,
      appBar: AppBar(
        title: Text('pull up'),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: _globalKey.currentContext,
              builder: (BuildContext context) {
                return SongDetailDialog(
                    songs[0]['name'],
                    songs[0]['al']['name'],
                    songs[0]['ar'][0]['name'],
                    songs[0]['al']['picUrl'],
                    songs[0]['alia'][0], [
                  {
                    'leadingIcon': AntDesign.getIconData('playcircleo'),
                    'title': '下一首播放',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('plussquareo'),
                    'title': '收藏到歌单',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('download'),
                    'title': '下载',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('message1'),
                    'title': '评论($songCommentTotal)',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('sharealt'),
                    'title': '分享',
                    'callback': () {
                      Navigator.of(context).pop();
                      BottomShare.showBottomShare(context);
                    }
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('adduser'),
                    'title': '歌手：${songs[0]['ar'][0]['name']}',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('adduser'),
                    'title': '专辑：${songs[0]['al']['name']}',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('youtube'),
                    'title': '查看视频',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('barchart'),
                    'title': '人气榜应援',
                    'callback': () {}
                  },
                  {
                    'leadingIcon': AntDesign.getIconData('delete'),
                    'title': '删除',
                    'callback': () {}
                  }
                ]);
              });
        },
        child: Text('do pull up'),
      ),
    );
  }
}
