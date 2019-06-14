import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music/api/netease_image.dart';

import '../../material/flexible_detail_bar.dart';

class AlbumBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: new AppBar(
      //   title: new Text('FlexibleSpaceBar组件'),
      // ),z
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              //展开高度
              expandedHeight: 150.0,
              //是否随着滑动隐藏标题
              floating: false,
              //是否固定在顶部
              pinned: true,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  tooltip: 'Add new entry',
                  onPressed: () { /* ... */ },
                ),
              ],
              //可折叠的应用栏
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '可折叠的组件',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.network(
                    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1549129578802&di=f866c638ea12ad13c5d603bcc008a6c2&imgtype=0&src=http%3A%2F%2Fpic2.16pic.com%2F00%2F07%2F66%2F16pic_766297_b.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: Text('向上提拉，查看效果'),
        )
      ),
    );
  }
}

// class AlbumBox extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return _AlbumBoxState();
//   }
// }

// class _AlbumBoxState extends State<AlbumBox> {

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('全局路由页面'),
//       ),
//       body: FlexibleDetailBar(
//         background: Builder(
//           builder: (context) {
//             var t = FlexibleDetailBar.percentage(context);
//             t = Curves.ease.transform(t) / 2 + 0.2;
//             return Container(
//               foregroundDecoration: BoxDecoration(color: Colors.black.withOpacity(t)),
//               child: Image(
//                 image: NeteaseImage('http://p1.music.126.net/DrRIg6CrgDfVLEph9SNh7w==/18696095720518497.jpg'),
//                 height: 300,
//                 fit: BoxFit.cover,
//               ),
//             );
//           },
//         ),
//         content: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Spacer(),
//               Text(
//                 '林俊杰',
//                 style: TextStyle(fontSize: 20),
//               ),
//               Text('歌曲数量：100')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }