import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/player.dart';
import '../model/music.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

///key which save playing music to local preference
const String _PREF_KEY_PLAYING = "quiet_player_playing";

///key which save playing music list to local preference
const String _PREF_KEY_PLAYLIST = "quiet_player_playlist";

///key which save playing mode to local preference
const String _PREF_KEY_PLAY_MODE = "quiet_player_play_mode";

PlayerController quiet = PlayerController._private();

class PlayerController {
  PlayerController._private() : super() {
    _init();
  }

  List<Music> playingList = [];

  void playNext(int value) {}

  void setPlayMode(PlayMode playmode) {}

  void _init() async {
    var preference = await SharedPreferences.getInstance();
    playingList = [Music(name: 'abc', id: 1)];
    Music _current;
    List<Music> _playingList;
    PlayMode _playMode;
    try {
      if (preference.get(_PREF_KEY_PLAYING) != null) {
        _current = json.decode(preference.get(_PREF_KEY_PLAYING));
        print(_current);
      } else {
        _current = Music();
      }
    } catch (e) {}

    // quietPlayerController = MusicController(PlayerControllerState(
    //     current: Music(name: '1', id: 1),
    //     playMode: PlayMode.sequence,
    //     playingList: [
    //       Music(name: '1', id: 1),
    //       Music(name: '2', id: 2),
    //       Music(name: '3', id: 3),
    //       Music(name: '4', id: 4),
    //       Music(name: '5', id: 5),
    //       Music(name: '6', id: 6),
    //       Music(name: '7', id: 7),
    //       Music(name: '8', id: 8),
    //     ]));
  }
}

class PlayerControllerState {
  PlayerControllerState({this.current, this.playMode, this.playingList});
  Music current;
  List<Music> playingList;
  PlayMode playMode;

  PlayerControllerState.uninitialized() : this();
}

enum PlayMode {
  ///aways play single song
  single,

  ///play current list sequence
  sequence,

  ///random to play next song
  shuffle
}

class QuietShareData extends InheritedWidget {
  QuietShareData({@required this.data, Widget child}) : super(child: child);

  final PlayerControllerState data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static QuietShareData of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(QuietShareData);
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(QuietShareData old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.data != data;
  }
}

class Quiet extends StatefulWidget {
  Quiet({@required this.child, this.music});
  final Music music;
  final Widget child;
  @override
  _QuietState createState() => _QuietState();
}

class _QuietState extends State<Quiet> {
  List<Music> _playingList = [];
  ValueNotifierData vd = ValueNotifierData(PlayerControllerState(
    current: Music(name: 'abc', id: 2),
  ));
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    var preference = await SharedPreferences.getInstance();

    setState(() {
      _playingList.add(Music(name: 'world', id: 1));
    });

    vd.addListener(() {




















































    });
  }

  @override
  Widget build(BuildContext context) {
    return QuietShareData(
      data: PlayerControllerState(
          current:
              widget.music != null ? widget.music : Music(name: 'abc', id: 2),
          playingList: _playingList),
      child: widget.child,
    );
  }
}

class ValueNotifierData extends ValueNotifier<PlayerControllerState> {
  ValueNotifierData(value) : super(value);
}
