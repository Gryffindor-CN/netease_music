import 'package:flutter/material.dart';
import '../../router/Routes.dart';
import './utils.dart';

class BottomShareComment {
  static showBottomShareComment(BuildContext context, int playListId,
      String commentCoverImgUrl, String playListName, String playListUserName) {
    var _url = commentCoverImgUrl.toString().replaceAll('/', '_');
    Routes.router.navigateTo(context,
        '/commentsharepage?playListId=$playListId&coverImgUrl=$_url&playListName=${FluroConvertUtils.fluroCnParamsEncode(playListName)}&playListUserName=${FluroConvertUtils.fluroCnParamsEncode(playListUserName)}');
    // Scaffold.of(context).showBottomSheet((context) {
    //   return Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     decoration: BoxDecoration(color: Color(0xffA17B6E)),
    //     child: ListView.builder(
    //       physics: BouncingScrollPhysics(),
    //       itemCount: 500,
    //       itemBuilder: (BuildContext context, int index) {
    //         return Text('$index');
    //       },
    //     ),
    //   );
    // });
  }
}
