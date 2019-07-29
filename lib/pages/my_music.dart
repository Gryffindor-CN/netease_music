import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music/router/Routes.dart';
import './artist/artist_page.dart';

class MyMusic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyMusicState();
  }
}

/// 第一步：在 MaterialApp 或 Scaffold 的 [body] 部分，维护一个 Navigator，实现局部路由。
/// 第二步：利用 [onGenerateRoute] （重新）定义路由映射，主要目的是使 Navigator 外部的 [context] 能够以参数的形式传入内部，实现局部路由页面内，可跳转全局路由。
/// 重点：局部路由必须使用 Navigator 的 [context]，而 [pageContext] 是 MaterialApp 给它的，所以它并不属于 Navigator，
/// 因此 Routes.router.navigateTo(pageContext, '/anotherpage') 和 Routes.router.navigateTo(context, '/mymusic/mycollection') 是不同的实例。
/// 路由跳转全都是利用 Fluro 的 [navigateTo] 方法。
class _MyMusicState extends State<MyMusic> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        RoutePageBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (_, __, ___) => MyMusicHome(
                  pageContext: context,
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return PageRouteBuilder(
          pageBuilder: builder,
        );
      },
    );
  }
}

class MyMusicHome extends StatelessWidget {
  final BuildContext pageContext;

  const MyMusicHome({Key key, this.pageContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('第一页'),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.home),
            onPressed: () {
              Routes.router.navigateTo(pageContext, '/anotherpage');
            },
          ),
        ],
      ),
      body: Center(
        child: Center(
          child: Column(
            children: <Widget>[
              Text('测试：第一页'),
              RaisedButton(
                child: Text('下一页'),
                onPressed: () {
                  Routes.router.navigateTo(context, '/mymusic/mycollection');
                },
              ),
              RaisedButton(
                child: Text('歌手'),
                onPressed: () {
                  // Routes.router.navigateTo(context, '/mymusic/mycollection');
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ArtistPage(2116);
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCollection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('我的收藏'),
            RaisedButton(
              child: Text('返回'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
