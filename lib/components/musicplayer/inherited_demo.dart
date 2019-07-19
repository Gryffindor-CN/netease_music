import 'package:flutter/material.dart';
import '../../model/music.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../repository/netease.dart';

const String _PREF_KEY_PLAYING = "player_playing";

///key which save playing music list to local preference
const String _PREF_KEY_PLAYLIST = "player_playlist";

///key which save playing mode to local preference
const String _PREF_KEY_PLAY_MODE = "player_play_mode";

class PlayerControllerState {
  PlayerControllerState(
      {this.audioPlayer,
      this.current,
      this.playMode,
      this.playingList,
      this.isPlaying = false,
      this.position = Duration.zero,
      this.duration,
      this.time = 0.0});
  final AudioPlayer audioPlayer;
  final Music current;
  final List<Music> playingList;
  final PlayMode playMode;
  final bool isPlaying;
  final Duration position;
  final Duration duration;
  final double time;

  PlayerControllerState.uninitialized() : this();
}

class _InheritedStateContainer extends InheritedWidget {
  final StateContainerState data;
  // 必须传入一个 孩子widget 和你的状态.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

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

  Future<void> play(Music music) async {
    int _currentIndex = -1;
    List<Music> _playingList;

    player.playingList.asMap().forEach((int index, Music item) {
      if (item.id == music.id) {
        _currentIndex = index;
      }
    });

    if (_currentIndex == -1) {
      _playingList = player.playingList;
      var _url = await _getSongUrl(music.id);
      var _comment = await _getSongComment(music.id);

      music.songUrl = _url;
      music.commentCount = _comment;
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
              audioPlayer: player.audioPlayer,
              current: music,
              playMode: player.playMode,
              playingList: _playingList,
              isPlaying: player.isPlaying,
              position: player.position,
              duration: player.duration,
              time: player.time));
        });
      });
    } else {
      setState(() {
        _playingList = player.playingList;
        _playingList[_currentIndex].songUrl = music.songUrl;
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString(
            _PREF_KEY_PLAYING,
            json.encode(music, toEncodable: (e) => e.toMap()),
          );
          prefs.setString(_PREF_KEY_PLAYLIST,
              json.encode(_playingList, toEncodable: (e) => e.toMap()));

          player = (PlayerControllerState(
              current: music,
              playMode: player.playMode,
              playingList: player.playingList));
        });
      });
    }
  }

  Future<void> playShuffle() {
    final _random = new Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    int _currentIndex;
    int ran;
    player.playingList.asMap().forEach((int index, Music music) {
      if (music.id == player.current.id) {
        _currentIndex = index;
      }
    });
    ran = next(0, player.playingList.length);
    player.playingList.asMap().forEach((int index, Music music) {
      if (ran == _currentIndex) {
        ran = next(0, player.playingList.length);
      }
    });
    setState(() {
      player = (PlayerControllerState(
          audioPlayer: player.audioPlayer,
          current: player.playingList[ran ?? 0],
          playMode: player.playMode,
          playingList: player.playingList,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  Future<void> playNext() {
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
          audioPlayer: player.audioPlayer,
          current: player.playingList[_currentIndex ?? 0],
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  Future<void> playPrev() {
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
          audioPlayer: player.audioPlayer,
          current: player.playingList[_currentIndex ?? 0],
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  void pause(Music music) {}

  Future<void> switchPlayMode() {
    switch (player.playMode) {
      case PlayMode.single:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 1);
          setState(() {
            player = (PlayerControllerState(
                audioPlayer: player.audioPlayer,
                current: player.current,
                playMode: PlayMode.sequence,
                playingList: player.playingList,
                isPlaying: player.isPlaying,
                position: player.position,
                duration: player.duration,
                time: player.time));
          });
        });

        break;
      case PlayMode.sequence:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 2);
          setState(() {
            player = (PlayerControllerState(
                audioPlayer: player.audioPlayer,
                current: player.current,
                playMode: PlayMode.shuffle,
                playingList: player.playingList,
                isPlaying: player.isPlaying,
                position: player.position,
                duration: player.duration,
                time: player.time));
          });
        });

        break;
      case PlayMode.shuffle:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 0);
          setState(() {
            player = (PlayerControllerState(
                audioPlayer: player.audioPlayer,
                current: player.current,
                playMode: PlayMode.single,
                playingList: player.playingList,
                isPlaying: player.isPlaying,
                position: player.position,
                duration: player.duration,
                time: player.time));
          });
        });

        break;
    }
  }

  Future<void> switchPlayingState(bool state) {
    setState(() {
      player = (PlayerControllerState(
          audioPlayer: player.audioPlayer,
          current: player.current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: state,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  Future<void> setPlayingState(Duration pos, Duration dur, double time) {
    setState(() {
      player = (PlayerControllerState(
          audioPlayer: player.audioPlayer,
          current: player.current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: pos,
          duration: dur,
          time: time));
    });
  }

  void setPlayer(AudioPlayer audioPlayer) {
    setState(() {
      player = (PlayerControllerState(
          audioPlayer: audioPlayer,
          current: player.current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    // try {
    //   Response response =
    //       await Dio().get("http://192.168.206.133:3000/song/url?id=$id");
    //   var data = json.decode(response.toString())['data'][0];
    //   return data['url'];
    // } catch (e) {
    //   print(e);
    // }
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  // 获取歌曲评论数
  _getSongComment(int id) async {
    // try {
    //   Response response =
    //       await Dio().get("http://192.168.206.133:3000/comment/music?id=$id");
    //   var result = json.decode(response.toString())['total'];

    //   return result;
    // } catch (e) {
    //   print(e);
    // }
    var result = await NeteaseRepository.getSongComment(id);
    return result['total'];
  }

  @override
  void initState() {
    super.initState();
    _getSavedInfo();
  }

  void _getSavedInfo() async {
    // var pref = await SharedPreferences.getInstance();
    // pref.remove(_PREF_KEY_PLAYLIST);
    // pref.remove(_PREF_KEY_PLAY_MODE);
    var preference = await SharedPreferences.getInstance();
    Music current = Music(name: '');
    List<Music> playingList = [];
    PlayMode playMode = PlayMode.values[0];

    if (preference.getString(_PREF_KEY_PLAYING) != null) {
      current = Music.fromMap(json.decode(preference.get(_PREF_KEY_PLAYING)));
      var _url = await _getSongUrl(current.id);
      var _comment = await _getSongComment(current.id);
      current.songUrl = _url;
      current.commentCount = _comment;
    }

    if (preference.get(_PREF_KEY_PLAYLIST) != null) {
      playingList = (json.decode(preference.get(_PREF_KEY_PLAYLIST)) as List)
          .cast<Map>()
          .map(Music.fromMap)
          .toList();

      playingList.asMap().forEach((int index, Music music) async {
        var _url = await _getSongUrl(music.id);
        var _comment = await _getSongComment(music.id);

        playingList[index].songUrl = _url;
        playingList[index].commentCount = _comment;
      });
    }

    if (preference.get(_PREF_KEY_PLAY_MODE) != null) {
      playMode = PlayMode.values[preference.getInt(_PREF_KEY_PLAY_MODE) ?? 0];
    }

    setState(() {
      player = (PlayerControllerState(
          audioPlayer: AudioPlayer(),
          current: current,
          playMode: playMode,
          playingList: playingList));
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
