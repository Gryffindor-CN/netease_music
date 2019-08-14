import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/another_page.dart';
import 'package:netease_music/pages/me/collect_page.dart';
import 'package:netease_music/pages/me/lately_play_page.dart';
import 'package:netease_music/pages/me/local_page.dart';
import 'package:netease_music/pages/my_music.dart';
import 'package:netease_music/pages/search/search.dart';
import 'package:netease_music/pages/search/search_result.dart';
import 'package:netease_music/pages/album_cover/album_cover.dart';

var anotherPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new AnotherPage();
});

var mycollectionHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new MyCollection();
});

var latelyplayHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new LatelyPlayPage();
    });

var searchPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  if (params['keyword'] != null) {
    return SearchPage(
      keyword: params['keyword'][0],
    );
  }
  return SearchPage();
});

var searchResultHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new SearchResult(keyword: params['keyword'][0]);
});

var playingPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  if (params['isNew'] != null) {
    return new AlbumCoverPage(
      isNew: true,
    );
  }
  return new AlbumCoverPage();
});

var localHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new LocalPage();
    });

var collectHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new CollectPage();
    });
