import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
// import 'package:flutter/animation.dart';
import './model/music.dart';
// import './components/playing_album_cover.dart';
import 'package:dio/dio.dart';
import './components/inherited_demo.dart';
import './components/playing_album_cover.dart';
import 'dart:convert';

void main() {
  runApp(StateContainer(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Routes.router = router;
  }
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Routes.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        key: _globalKey,
        appBar: AppBar(
          title: Text('qiang'),
        ),
        body: MusicDetail(),
      ),
    );
  }
}

class MusicDetail extends StatefulWidget {
  @override
  _MusicDetailState createState() => _MusicDetailState();
}

class _MusicDetailState extends State<MusicDetail> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> _getSongUrl(int id) async {
    var _songUrl = '';
    try {
      Response response = await Dio().get(
          'http://192.168.206.133:3000/song/url?id=$id&timestamp=${DateTime.now().millisecondsSinceEpoch}');
      var result = json.decode(response.toString())['data'][0]['url'];
      _songUrl = result;
      return _songUrl;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);

    return Center(
        child: Column(
      children: <Widget>[
        RaisedButton(
          child: Text('海阔天空'),
          onPressed: () async {
            var _url = await _getSongUrl(178895);

            store.play(Music(
                name: '海阔天空',
                id: 178895,
                aritstId: 11127,
                aritstName: 'Beyond',
                albumName: '海阔天空',
                albumId: 34430029,
                albumCoverImg:
                    'https://p1.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg',
                songUrl: _url));
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AlbumCover(
                  music: Music(
                      name: '海阔天空',
                      id: 347230,
                      aritstId: 11127,
                      aritstName: 'Beyond',
                      albumName: '海阔天空',
                      albumId: 34430029,
                      albumCoverImg:
                          'https://p1.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg'));
            }));
          },
        ),
        RaisedButton(
          child: Text('你瞒我瞒'),
          onPressed: () async {
            var _url = await _getSongUrl(25718007);
            store.play(Music(
                name: '你瞒我瞒',
                id: 25718007,
                aritstId: 2127,
                aritstName: '陈柏宇',
                albumName: 'Can’t Be Half',
                albumId: 2292012,
                albumCoverImg:
                    'http://p1.music.126.net/PLPrwYq-7fN1zqzoDT8Lhg==/109951163676678119.jpg',
                songUrl: _url));
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AlbumCover(
                  music: Music(
                      name: '你瞒我瞒',
                      id: 25718007,
                      aritstId: 2127,
                      aritstName: '陈柏宇',
                      albumName: 'Can’t Be Half',
                      albumId: 2292012,
                      albumCoverImg:
                          'http://p1.music.126.net/PLPrwYq-7fN1zqzoDT8Lhg==/109951163676678119.jpg'));
            }));
          },
        ),
        RaisedButton(
          child: Text('我走后'),
          onPressed: () async {
            var _url = await _getSongUrl(1370047789);
            store.play(Music(
                name: '我走后',
                id: 1370047789,
                aritstId: 30616479,
                aritstName: '小咪',
                albumName: '我走后',
                albumId: 79634961,
                albumCoverImg:
                    'http://p1.music.126.net/NqiiABaxJQFQeWkLd_sKzQ==/109951163842098152.jpg',
                songUrl: _url));
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AlbumCover(
                  music: Music(
                      name: '我走后',
                      id: 1370047789,
                      aritstId: 30616479,
                      aritstName: '小咪',
                      albumName: '我走后',
                      albumId: 79634961,
                      albumCoverImg:
                          'http://p1.music.126.net/NqiiABaxJQFQeWkLd_sKzQ==/109951163842098152.jpg'));
            }));
          },
        ),
        RaisedButton(
          child: Text('遗憾'),
          onPressed: () {
            store.play(Music(
                name: '遗憾',
                id: 25650033,
                aritstId: 4393,
                aritstName: '李代沫',
                albumName: '遗憾',
                albumId: 2266009,
                albumCoverImg:
                    'http://p1.music.126.net/jEoJh6uUBsZCC_zncoPp2w==/938982930173076.jpg',
                songUrl: 'http://mpge.5nd.com/2019/2019-7-5/92476/1.mp3'));
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AlbumCover(
                  music: Music(
                      name: '遗憾',
                      id: 25650033,
                      aritstId: 4393,
                      aritstName: '李代沫',
                      albumName: '遗憾',
                      albumId: 2266009,
                      albumCoverImg:
                          'http://p1.music.126.net/jEoJh6uUBsZCC_zncoPp2w==/938982930173076.jpg'));
            }));
          },
        ),
        RaisedButton(
          child: Text('list'),
          onPressed: () async {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return AlbumCover();
            }));
            // int result = await audioPlayer.play(
            //     'http://m10.music.126.net/20190710182906/624c40d94cde3ad8ec87976428e6f21e/ymusic/0fd6/4f65/43ed/a8772889f38dfcb91c04da915b301617.mp3');
          },
        ),
      ],
    ));
  }
}

// class ValueNotifierCommunication extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final store = StateContainer.of(context);

//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Value Notifier Communication'),
//         ),
//         body: Center(
//           child: Column(
//             children: <Widget>[
//               store.player == null
//                   ? Text('')
//                   : Text('current:${store.player.current.name}'),
//               store.player == null
//                   ? Text('')
//                   : Text('playmode:${store.player.playMode.toString()}'),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       store.playPrev();
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.play_circle_outline),
//                     onPressed: () async {},
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.arrow_forward),
//                     onPressed: () {
//                       store.playNext();
//                     },
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.shuffle),
//                     onPressed: () {
//                       store.switchPlayMode();
//                     },
//                   )
//                 ],
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   store.play(Music(
//                       name: '海阔天空',
//                       id: 347230,
//                       aritstId: 11127,
//                       aritstName: 'Beyond',
//                       albumName: '海阔天空',
//                       albumCoverImg:
//                           'https://p1.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg'));
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (BuildContext context) {
//                     return AlbumCover(
//                         music: Music(
//                             name: '海阔天空',
//                             id: 347230,
//                             aritstId: 11127,
//                             aritstName: 'Beyond',
//                             albumName: '海阔天空',
//                             albumCoverImg:
//                                 'https://p1.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg'));
//                   }));
//                 },
//                 child: Text('22'),
//               )
//             ],
//           ),
//         ));
//   }
// }
