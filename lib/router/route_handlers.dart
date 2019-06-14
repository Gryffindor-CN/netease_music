import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/components/comment/comment_page.dart';
import 'package:netease_music/pages/another_page.dart';
import 'package:netease_music/pages/my_music.dart';

var anotherPageHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AnotherPage();
  }
);

var mycollectionHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new MyCollection();
  }
);

var commentPageHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new CommentPage(int.parse(params["type"][0]),params["id"][0],params["name"][0],params["author"][0],params["imageUrl"][0]);
    }
);