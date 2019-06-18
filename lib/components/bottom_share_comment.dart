import 'package:flutter/material.dart';
import '../router/Routes.dart';

class BottomShareComment {
  static showBottomShareComment(
      BuildContext context, String commentCoverImgUrl) {
    Routes.router.navigateTo(context,
        '/commentsharepage?id=61650863&coverImgUrl=${commentCoverImgUrl.toString().replaceAll('/', '_')}');
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
