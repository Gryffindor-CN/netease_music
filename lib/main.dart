import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
import './components/song_detail_dialog.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';
import './components/netease_share/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

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
        primarySwatch: Colors.blue,
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
  List<int> likelist = [];
  List<dynamic> songlist = [];
  List<int> commentlist = [];

  ScrollController _scrollController;
  int songCommentTotal = 0;

  void getSongDetail(int id) async {
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/song/detail?ids=$id");
      var result = json.decode(response.toString());
      getSongComment(result['songs'][0]['id']).then((data) {
        setState(() {
          songlist.add(result['songs'][0]);
          commentlist.add(data['total']);
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
    [33911781, 36270426, 1370897787].asMap().forEach((index, item) {
      getSongDetail(item);
    });
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text('弹起'),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListTile(
              leading: Text('${index + 1}'),
              title: songlist.length > 0
                  ? Text(songlist[index]['name'])
                  : Text('----'),
              trailing: InkWell(
                child: Icon(Icons.more_vert),
                onTap: () {
                  showModalBottomSheet(
                      context: _globalKey.currentContext,
                      builder: (BuildContext context) {
                        return SongDetailDialog(
                            songlist[index]['name'],
                            songlist[index]['al']['name'],
                            songlist[index]['ar'][0]['name'],
                            songlist[index]['al']['picUrl'],
                            songlist[index]['alia'].length == 0
                                ? ''
                                : '（${songlist[index]['alia'][0]}）',
                            [
                              {
                                'leadingIcon':
                                    AntDesign.getIconData('playcircleo'),
                                'title': '下一首播放',
                                'callback': null
                              },
                              {
                                'leadingIcon':
                                    AntDesign.getIconData('plussquareo'),
                                'title': '收藏到歌单',
                                'callback': () {}
                              },
                              {
                                'leadingIcon':
                                    AntDesign.getIconData('download'),
                                'title': '下载',
                                'callback': () {}
                              },
                              {
                                'leadingIcon':
                                    AntDesign.getIconData('message1'),
                                'title': '评论(${commentlist[index]})',
                                'callback': () {}
                              },
                              {
                                'leadingIcon':
                                    AntDesign.getIconData('sharealt'),
                                'title': '分享',
                                'callback': () {
                                  Navigator.of(context).pop();
                                  BottomShare.showBottomShare(context);
                                }
                              },
                              {
                                'leadingIcon': AntDesign.getIconData('adduser'),
                                'title':
                                    '歌手：${songlist[index]['ar'][0]['name']}',
                                'callback': () {}
                              },
                              {
                                'leadingIcon': AntDesign.getIconData('adduser'),
                                'title': '专辑：${songlist[index]['al']['name']}',
                                'callback': () {}
                              },
                              {
                                'leadingIcon': AntDesign.getIconData('youtube'),
                                'title': '查看视频',
                                'callback': () {}
                              },
                              {
                                'leadingIcon':
                                    AntDesign.getIconData('barchart'),
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
              ),
            ),
          );
        },
      )),
    );
  }
}
