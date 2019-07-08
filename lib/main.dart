import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// import 'package:netease_music/pages/netease.dart';
import 'package:netease_music/router/Routes.dart';
// import 'package:flutter/animation.dart';
import './model/music.dart';
// import './components/playing_album_cover.dart';
import './components/player.dart';
import 'components/music_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Routes.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Routes.router.generator,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValueNotifierCommunication(),
    );
  }
}

// class Home extends StatefulWidget {
//   HomeState createState() => HomeState();
// }

// class HomeState extends State<Home> with TickerProviderStateMixin {
//   Widget build(BuildContext context) {
//     return AlbumCover(
//         music: Music(
//             name: '天空',
//             albumCoverImg:
//                 'https://p1.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg'));
//   }
// }

class ValueNotifierCommunication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Value Notifier Communication'),
      ),
      body: _WidgetOne(),
    );
  }
}

class _WidgetOne extends StatefulWidget {
  _WidgetOne({this.data});
  final ValueNotifierData data;
  @override
  _WidgetOneState createState() => _WidgetOneState();
}

class _WidgetOneState extends State<_WidgetOne> {
  String info;
  String playMode;

  ValueNotifierData vd = ValueNotifierData(PlayerControllerState(
      current: Music(name: '1', id: 1),
      playMode: PlayMode.sequence,
      playingList: [
        Music(name: '1', id: 1),
        Music(name: '2', id: 2),
        Music(name: '3', id: 3),
        Music(name: '4', id: 4),
        Music(name: '5', id: 5),
        Music(name: '6', id: 6),
        Music(name: '7', id: 7),
        Music(name: '8', id: 8),
      ]));

  @override
  initState() {
    super.initState();
    vd.addListener(_handleValueChanged);
    info = 'current music name: ' + vd.value.current.name;
    playMode = 'current music playmode: ' + vd.value.playMode.toString();
  }

  @override
  dispose() {
    widget.data.removeListener(_handleValueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(info),
        Text(playMode),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                int _currentIndex;
                vd.value.playingList.asMap().forEach((int index, Music music) {
                  if (music.id == vd.value.current.id) _currentIndex = index;
                });
                if (_currentIndex - 1 < 0) {
                  _currentIndex = vd.value.playingList.length - 1;
                } else {
                  _currentIndex = _currentIndex - 1;
                }
                vd.value = PlayerControllerState(
                    current: vd.value.playingList[_currentIndex],
                    playingList: vd.value.playingList,
                    playMode: vd.value.playMode);
              },
            ),
            IconButton(
              icon: Icon(Icons.play_circle_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                int _currentIndex;
                vd.value.playingList.asMap().forEach((int index, Music music) {
                  if (music.id == vd.value.current.id) _currentIndex = index;
                });
                if (_currentIndex + 1 >= vd.value.playingList.length) {
                  _currentIndex = 0;
                } else {
                  _currentIndex = _currentIndex + 1;
                }
                vd.value = PlayerControllerState(
                    current: vd.value.playingList[_currentIndex],
                    playingList: vd.value.playingList,
                    playMode: vd.value.playMode);
              },
            ),
            IconButton(
              icon: Icon(Icons.shuffle),
              onPressed: () {
                if (vd.value.playMode == PlayMode.single) {
                  vd.value = PlayerControllerState(
                      current: vd.value.current,
                      playingList: vd.value.playingList,
                      playMode: PlayMode.sequence);
                } else if (vd.value.playMode == PlayMode.sequence) {
                  vd.value = PlayerControllerState(
                      current: vd.value.current,
                      playingList: vd.value.playingList,
                      playMode: PlayMode.shuffle);
                } else if (vd.value.playMode == PlayMode.shuffle) {
                  vd.value = PlayerControllerState(
                      current: vd.value.current,
                      playingList: vd.value.playingList,
                      playMode: PlayMode.single);
                }
              },
            )
          ],
        ),
        MusicItem()
      ],
    ));
  }

  void _handleValueChanged() {
    print(vd.value.playMode.toString());
    setState(() {
      info = vd.value.current.name;
      playMode = vd.value.playMode.toString();
    });
  }
}
