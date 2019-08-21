import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/router/route_handlers.dart';

class Routes {
  static Router router;

  /// 为统一管理，分为一、二级路由
  /// 根据业务模块，添加起始路由节点 “/mymusic“

  // 一级路由
  static String anotherPage = '/anotherpage';

  static String searchPage = '/home/searchpage';

  static String searchResPage = '/home/searchresultpage';

  static String albumconverPage = '/albumcoverpage';

  static String playlistSquarePage = '/home/playlistsquare/playlistsquarepage';

  static String rankinglistPage = '/home/rankinglistpage';

  static String recommandSongsPage = '/home/recommandSongs/recommandsongspage';

  // 二级路由
  static String mycollection = '/mymusic/mycollection';

  static String latelyPlayPage = '/mymusic/latelyplay';

  static String localPage = '/mymusic/local';
  static String collectPage = '/mymusic/collect';

  // 歌曲评论页
  static String commentPage = '/commentpage';

  /// 过渡动画在路由定义[router.define]时给定，没有特殊要求的情况下，统一使用 [TransitionType.native]
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ROUTE WAS NOT FOUND !!!');
    });
    router.define(anotherPage,
        handler: anotherPageHandler, transitionType: TransitionType.native);
    router.define(mycollection,
        handler: mycollectionHandler, transitionType: TransitionType.native);
    router.define(searchPage,
        handler: searchPageHandler, transitionType: TransitionType.inFromRight);
    router.define(searchResPage,
        handler: searchResultHandler,
        transitionType: TransitionType.inFromRight);
    router.define(albumconverPage,
        handler: playingPageHandler,
        transitionType: TransitionType.inFromRight);

    router.define(playlistSquarePage,
        handler: playlistSquarePageHandler,
        transitionType: TransitionType.inFromRight);
    router.define(rankinglistPage,
        handler: rankinglistPageHandler,
        transitionType: TransitionType.inFromRight);
    router.define(recommandSongsPage,
        handler: recommandSongsPageHandler,
        transitionType: TransitionType.inFromRight);

    router.define(latelyPlayPage,
        handler: latelyplayHandler,
        transitionType: TransitionType.native);
    router.define(localPage,
        handler: localHandler,
        transitionType: TransitionType.native);
    router.define(collectPage,
        handler: collectHandler,
        transitionType: TransitionType.native);
	  router.define(commentPage, handler: commentPageHandler, transitionType: TransitionType.native);
  }
}
