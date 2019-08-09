import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/redux/app.dart' as prefix1;
import 'package:netease_music/router/Routes.dart';
import './components/circle_bottom_bar.dart';
import './components/musicplayer/inherited_demo.dart';
import './pages/home/home_page.dart';
import 'components/netease_navigation_bar.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:audioplayers/audioplayers.dart';
import './pages/me/home_page.dart';
import './redux/app.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String _RECENT_PLAY_COUNT = 'recent_play_count';

void main() {
  Future<NeteaseState> appInitState = NeteaseState.initial();
  recentplayMiddleware(
      Store<NeteaseState> store, action, NextDispatcher next) async {
    if (action is AddToRecentPlayAction) {
      List<Music> _playingList = [];
      var _index = -1;
      try {
        var prefs = await SharedPreferences.getInstance();
        if (prefs.get(_RECENT_PLAY_COUNT) == null) {
          _playingList.add(action.music);
          prefs.setString(_RECENT_PLAY_COUNT,
              json.encode(_playingList, toEncodable: (e) => e.toMap()));
        } else {
          _playingList = (json.decode(prefs.get(_RECENT_PLAY_COUNT)) as List)
              .cast<Map>()
              .map(Music.fromMap)
              .toList();
          _playingList.forEach((Music music) {
            if (action.music.id == music.id) {
              _index = music.id;
            }
          });
          if (_index == -1) {
            _playingList.add(action.music);
            prefs.setString(_RECENT_PLAY_COUNT,
                json.encode(_playingList, toEncodable: (e) => e.toMap()));
            store.dispatch(UpdateRecentPlayAction(flag: true));
            next(action);
          } else {
            store.dispatch(UpdateRecentPlayAction(flag: false));
            next(action);
          }
        }
      } catch (e) {
        print(e);
      }
    }
    next(action);
  }

  appInitState.then((data) {
    Store<NeteaseState> store = Store<NeteaseState>(appReducer,
        initialState: data, middleware: [recentplayMiddleware]);
    runApp(StateContainer(
      child: MyApp(appstore: store),
    ));
  });
}

class MyApp extends StatelessWidget {
  MyApp({this.appstore}) {
    final router = new Router();
    Routes.configureRoutes(router);
    Routes.router = router;
  }
  final Store<NeteaseState> appstore;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<NeteaseState>(
      store: appstore,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xffC20C0C),
          textTheme: TextTheme(
              body1: TextStyle(color: Color(0xff271416)),
              title: TextStyle(
                fontSize: 15.0,
              ),
              subtitle: TextStyle(color: Color(0xffaaaaaa), fontSize: 11.0)),
        ),
        home: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static GlobalKey<_MyStatefulWidgetState> _globalKey;
  int currentIndex = 0;
  int _tabIndex = 0;
  PageController _pageController;
  AudioPlayer audioPlayer;
  @override
  void initState() {
    super.initState();
    _globalKey = GlobalKey<_MyStatefulWidgetState>();
    this._pageController =
        PageController(initialPage: this._tabIndex, keepPage: true);
    _initFluwx();
  }

  _initFluwx() async {
    await fluwx.register(
        appId: "wx6c75e0c403d1d801",
        doOnAndroid: true,
        doOnIOS: true,
        enableMTA: false);
    await fluwx.isWeChatInstalled();
  }

  Widget renderCircleTab(IconData iconData) {
    return LogoApp(iconData);
  }

  @override
  Widget build(BuildContext context) {
    var pageChooser = [
      NeteaseHome(),
      Scaffold(
          appBar: AppBar(
            title: Text('视频'),
          ),
          body: Text(
            '视频',
          )),
      MeHomePage()
    ];
    return Scaffold(
        key: _globalKey,
        body: NeteaseBottomNavBar([
          {'iconData': Icons.home, 'title': '发现'},
          {'iconData': Icons.play_circle_outline, 'title': '视频'},
          {'iconData': Icons.music_video, 'title': '我的'}
        ], onTap: (int index) {
          setState(() {
            _tabIndex = index;
            _pageController.jumpToPage(index);
          });
        },
            currentIndex: _tabIndex,
            child: PageView(
              children: pageChooser,
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
            )));
  }
}

// enum Actions { AddToCollection, AddToRecentPlay, AddToRadio, AddToLocal }
