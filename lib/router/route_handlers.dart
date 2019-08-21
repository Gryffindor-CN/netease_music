import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/components/comment/comment_page.dart';
import 'package:netease_music/pages/another_page.dart';
import 'package:netease_music/pages/me/collect_page.dart';
import 'package:netease_music/pages/me/lately_play_page.dart';
import 'package:netease_music/pages/me/local_page.dart';
import 'package:netease_music/pages/my_music.dart';
import 'package:netease_music/pages/search/search.dart';
import 'package:netease_music/pages/search/search_result.dart';
import 'package:netease_music/pages/album_cover/album_cover.dart';
import 'package:netease_music/pages/home/playlistSquare/playlist_square.dart';
import 'package:netease_music/pages/home/ranking_list.dart';
import 'package:netease_music/pages/home/recommandSongs/recommend_songs.dart';
import '../pages/share/share_comment_page.dart';
import '../utils/utils.dart';

var anotherPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new AnotherPage();
});

var mycollectionHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new MyCollection();
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

var playlistSquarePageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new PlaylistSquare();
});

var rankinglistPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new RankingListPage();
});

var recommandSongsPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new RecommendSongs();
});

var latelyplayHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new LatelyPlayPage();
});

var localHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new LocalPage();
});

var collectHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new CollectPage();
});

var commentPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new CommentPage(
      int.parse(params["type"][0]),
      params["id"][0],
      FluroConvertUtils.fluroCnParamsDecode(params["name"][0]),
      FluroConvertUtils.fluroCnParamsDecode(params["author"][0]),
      params["imageUrl"][0].toString().replaceAll(')', '/'));
});

var commentShareHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  var playListId = params['playListId']?.first;
  var coverImgUrl = params['coverImgUrl']?.first;
  var playListName = params['playListName'][0];
  var playListUserName = params['playListUserName'][0];
  var type = params['type'][0];
  return CommentShareContainer(
      playListId,
      coverImgUrl,
      FluroConvertUtils.fluroCnParamsDecode(playListName),
      FluroConvertUtils.fluroCnParamsDecode(playListUserName),
      type);
});
