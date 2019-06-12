import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/pages/another_page.dart';
import 'package:netease_music/pages/my_music.dart';

import '../components/base/album_box.dart';

var albumHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return new AlbumBox();
  }
);

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