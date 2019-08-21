import 'package:flutter/material.dart';
import '../../router/Routes.dart';
import '../../utils/utils.dart';

class BottomShareComment {
  static showBottomShareComment(
      BuildContext context,
      int playListId,
      String commentCoverImgUrl,
      String playListName,
      String playListUserName,
      int type) {
    var _url = commentCoverImgUrl.toString().replaceAll('/', ')');
    Routes.router.navigateTo(context,
        '/commentsharepage?type=$type&playListId=$playListId&coverImgUrl=$_url&playListName=${FluroConvertUtils.fluroCnParamsEncode(playListName)}&playListUserName=${FluroConvertUtils.fluroCnParamsEncode(playListUserName)}');
  }
}
