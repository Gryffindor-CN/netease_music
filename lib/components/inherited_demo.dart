import 'package:flutter/material.dart';
import '../model/music.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

const String _PREF_KEY_PLAYING = "player_playing";

///key which save playing music list to local preference
const String _PREF_KEY_PLAYLIST = "player_playlist";

///key which save playing mode to local preference
const String _PREF_KEY_PLAY_MODE = "player_play_mode";

class User {
  String firstName;
  String lastName;
  String email;

  User(this.firstName, this.lastName, this.email);
}

class PlayerControllerState {
  PlayerControllerState({this.current, this.playMode, this.playingList});
  Music current;
  List<Music> playingList;
  PlayMode playMode;

  PlayerControllerState.uninitialized() : this();
}

class _InheritedStateContainer extends InheritedWidget {
  // Data 是你整个的状态(state). 在我们的例子中就是 'User'
  final StateContainerState data;

  // 必须传入一个 孩子widget 和你的状态.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // 这个一个内建方法可以在这里检查状态是否有变化. 如果没有变化就不需要重新创建所有Widget.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;
  final PlayerControllerState player;

  StateContainer({
    @required this.child,
    this.player,
  });

  // 这个是所有一切的秘诀. 写一个你自己的'of'方法，像MediaQuery.of and Theme.of
  // 简单的说，就是：从指定的Widget类型获取data.
  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => new StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  // Whichever properties you wanna pass around your app as state
  PlayerControllerState player;

  void play(Music music) {
    int _currentIndex = -1;
    List<Music> _playingList;

    player.playingList.asMap().forEach((int index, Music item) {
      if (item.id == music.id) {
        _currentIndex = index;
      }
    });

    if (_currentIndex == -1) {
      _playingList = player.playingList;
      _playingList.add(music);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(
          _PREF_KEY_PLAYING,
          json.encode(music, toEncodable: (e) => e.toMap()),
        );
        prefs.setString(_PREF_KEY_PLAYLIST,
            json.encode(_playingList, toEncodable: (e) => e.toMap()));

        setState(() {
          player = (PlayerControllerState(
              current: music,
              playMode: player.playMode,
              playingList: _playingList));
        });
      });
    } else {
      setState(() {
        player = (PlayerControllerState(
            current: music,
            playMode: player.playMode,
            playingList: player.playingList));
      });
    }
  }

  void playNext() {
    int _currentIndex;
    player.playingList.asMap().forEach((int index, Music music) {
      if (music.id == player.current.id) {
        _currentIndex = index;
      }
    });

    if (_currentIndex + 1 >= player.playingList.length) {
      _currentIndex = 0;
    } else {
      _currentIndex = _currentIndex + 1;
    }
    setState(() {
      player = (PlayerControllerState(
          current: player.playingList[_currentIndex ?? 0],
          playMode: player.playMode,
          playingList: player.playingList));
    });
  }

  void playPrev() {
    int _currentIndex;
    player.playingList.asMap().forEach((int index, Music music) {
      if (music.id == player.current.id) {
        _currentIndex = index;
      }
    });
    if (_currentIndex - 1 < 0) {
      _currentIndex = player.playingList.length - 1;
    } else {
      _currentIndex = _currentIndex - 1;
    }

    setState(() {
      player = (PlayerControllerState(
          current: player.playingList[_currentIndex ?? 0],
          playMode: player.playMode,
          playingList: player.playingList));
    });
  }

  void pause(Music music) {}

  void switchPlayMode() {
    switch (player.playMode) {
      case PlayMode.single:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 1);
          setState(() {
            player = (PlayerControllerState(
                current: player.current,
                playMode: PlayMode.sequence,
                playingList: player.playingList));
          });
        });

        break;
      case PlayMode.sequence:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 2);
          setState(() {
            player = (PlayerControllerState(
                current: player.current,
                playMode: PlayMode.shuffle,
                playingList: player.playingList));
          });
        });

        break;
      case PlayMode.shuffle:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 0);
          setState(() {
            player = (PlayerControllerState(
                current: player.current,
                playMode: PlayMode.single,
                playingList: player.playingList));
          });
        });

        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _getSavedInfo();
  }

  void _getSavedInfo() async {
    // var pref = await SharedPreferences.getInstance();
    // pref.remove(_PREF_KEY_PLAYLIST);
    // pref.remove(_PREF_KEY_PLAYING);
    var preference = await SharedPreferences.getInstance();
    Music current = Music(name: '');
    List<Music> playingList = [];
    PlayMode playMode = PlayMode.values[0];

    if (preference.getString(_PREF_KEY_PLAYING) != null) {
      current = Music.fromMap(json.decode(preference.get(_PREF_KEY_PLAYING)));
    }

    if (preference.get(_PREF_KEY_PLAYLIST) != null) {
      playingList = (json.decode(preference.get(_PREF_KEY_PLAYLIST)) as List)
          .cast<Map>()
          .map(Music.fromMap)
          .toList();
    }
    if (preference.get(_PREF_KEY_PLAY_MODE) != null) {
      playMode = PlayMode.values[preference.getInt(_PREF_KEY_PLAY_MODE) ?? 0];
    }

    setState(() {
      player = (PlayerControllerState(
          current: current, playMode: playMode, playingList: playingList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

enum PlayMode {
  ///aways play single song
  single,

  ///play current list sequence
  sequence,

  ///random to play next song
  shuffle
}
