import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/another_page.dart';
import 'package:netease_music/pages/my_music.dart';
import '../components/netease_share/share_comment_page.dart';
import '../components/netease_share/utils.dart';

var anotherPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new AnotherPage();
});

var mycollectionHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return new MyCollection();
});

var commentShareHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  var playListId = params['playListId']?.first;
  var coverImgUrl = params['coverImgUrl']?.first;
  var playListName = params['playListName'][0];
  var playListUserName = params['playListUserName'][0];
  return CommentShareContainer(
      playListId,
      coverImgUrl,
      FluroConvertUtils.fluroCnParamsDecode(playListName),
      FluroConvertUtils.fluroCnParamsDecode(playListUserName));
});
