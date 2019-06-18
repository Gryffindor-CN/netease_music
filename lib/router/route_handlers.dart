import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/another_page.dart';
import 'package:netease_music/pages/my_music.dart';
import '../components/share_comment_page.dart';
import 'dart:convert';

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
  var id = params['id']?.first;
  var coverImgUrl = params['coverImgUrl'][0];
  return CommentShareContainer(id, coverImgUrl);
});
