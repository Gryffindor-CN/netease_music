import 'package:flutter/material.dart';
import '../../model/music.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

import '../../repository/netease.dart';

const String _PREF_KEY_PLAYING = "player_playing";

///key which save playing music list to local preference
const String _PREF_KEY_PLAYLIST = "player_playlist";

///key which save playing mode to local preference
const String _PREF_KEY_PLAY_MODE = "player_play_mode";

class PlayerControllerState {
  PlayerControllerState(
      {this.current,
      this.playMode,
      this.playingList,
      this.isPlaying = false,
      this.position = Duration.zero,
      this.duration,
      this.time = 0.0});
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

  // 播放一首
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

  // 全部播放
  Future<void> playMultis(List<Music> musics) async {
    var _playingList = player.playingList;
    if (_playingList.length <= 0) {
      var _currentSongUrl = await _getSongUrl(musics[0].id);
      musics[0].songUrl = _currentSongUrl;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(
          _PREF_KEY_PLAYING,
          json.encode(musics[0], toEncodable: (e) => e.toMap()),
        );
        prefs.setString(_PREF_KEY_PLAYLIST,
            json.encode(musics, toEncodable: (e) => e.toMap()));

        setState(() {
          player = (PlayerControllerState(
              current: musics[0],
              playMode: player.playMode,
              playingList: musics,
              isPlaying: player.isPlaying,
              position: player.position,
              duration: player.duration,
              time: player.time));
        });
      });
    } else {
      var _musics = musics;
      _musics.reversed.forEach((Music music) {
        var _flag = false;
        // _playingList.add(music);

        for (Music musics in _playingList) {
          if (music.id == musics.id) {
            _flag = true;
          }
        }
        if (_flag == false) {
          _playingList.add(music);
        }
      });
      var _currentSongUrl = await _getSongUrl(musics[0].id);
      _playingList = _playingList.reversed.toList();
      _playingList[0].songUrl = _currentSongUrl;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(
          _PREF_KEY_PLAYING,
          json.encode(_playingList[0], toEncodable: (e) => e.toMap()),
        );
        prefs.setString(_PREF_KEY_PLAYLIST,
            json.encode(_playingList, toEncodable: (e) => e.toMap()));
        setState(() {
          player = (PlayerControllerState(
              current: _playingList[0],
              playMode: player.playMode,
              playingList: _playingList,
              isPlaying: player.isPlaying,
              position: player.position,
              duration: player.duration,
              time: player.time));
        });
      });
    }
  }

  // 随机播放
  Future<String> playShuffle() async {
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

    player.playingList[_currentIndex].songUrl =
        await _getSongUrl(player.playingList[ran].id);
    setState(() {
      player = (PlayerControllerState(
          current: player.playingList[ran ?? 0],
          playMode: player.playMode,
          playingList: player.playingList,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
    return player.playingList[_currentIndex].songUrl;
  }

  // 播放播放列表中一首歌曲
  Future<String> playCertain(Music music) async {
    Music _current = music;
    _current.songUrl = await _getSongUrl(music.id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _PREF_KEY_PLAYING,
      json.encode(music, toEncodable: (e) => e.toMap()),
    );
    setState(() {
      player = (PlayerControllerState(
          current: _current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
    return _current.songUrl;
  }

  // 删除播放列表中一首歌曲
  Future<dynamic> deleteCertain(Music music) async {
    int _flagIndex = -1;
    int _nextIndex = -1;
    List<Music> _playingList = [];

    bool isCurrent = false;
    if (music.id == player.current.id) isCurrent = true;
    _playingList = player.playingList;
    player.playingList.asMap().forEach((int index, Music item) {
      if (item.id == music.id) {
        _flagIndex = index;
      }
    });

    if (_flagIndex + 1 >= player.playingList.length) {
      _nextIndex = 0;
    } else {
      _nextIndex = _flagIndex + 1;
    }

    _playingList.removeAt(_flagIndex);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_playingList.length <= 0) {
      prefs.remove(_PREF_KEY_PLAYING);
      prefs.remove(_PREF_KEY_PLAYLIST);
      var __curent = player.current;
      __curent.id = -1;
      setState(() {
        player = PlayerControllerState(
            current: __curent,
            playMode: player.playMode,
            playingList: [],
            isPlaying: false,
            position: Duration.zero,
            duration: Duration.zero,
            time: 0.0);
      });
      return 0;
    } else if (isCurrent == false) {
      prefs.setString(_PREF_KEY_PLAYLIST,
          json.encode(_playingList, toEncodable: (e) => e.toMap()));

      setState(() {
        player = PlayerControllerState(
            current: player.current,
            playMode: player.playMode,
            playingList: _playingList,
            isPlaying: player.isPlaying,
            position: player.position,
            duration: player.duration,
            time: player.time);
      });
      return 1;
    } else {
      // 删除当前正在播放的歌曲

      Music _current = _playingList[_nextIndex <= 0 ? 0 : _nextIndex - 1];
      playCertain(_current);
      var _url = await _getSongUrl(_current.id);
      return _url;
    }
  }

  // 播放下一首
  Future<String> playNext() async {
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

    Music _current = player.playingList[_currentIndex];

    _current.songUrl = await _getSongUrl(_current.id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _PREF_KEY_PLAYING,
      json.encode(_current, toEncodable: (e) => e.toMap()),
    );
    setState(() {
      player = (PlayerControllerState(
          current: _current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });

    return _current.songUrl;
  }

  // 播放上一首
  Future<String> playPrev() async {
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
    Music _current = player.playingList[_currentIndex];
    _current.songUrl = await _getSongUrl(_current.id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      _PREF_KEY_PLAYING,
      json.encode(_current, toEncodable: (e) => e.toMap()),
    );
    setState(() {
      player = (PlayerControllerState(
          current: _current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
    return _current.songUrl;
  }

  // 下一首播放
  Future<void> playInsertNext(Music music) async {
    int _idIndex = -1;
    int _currentIndex = -1;
    List<Music> _playingList;
    var _url = await _getSongUrl(music.id);
    music.songUrl = _url;
    player.playingList.asMap().forEach((int index, Music item) {
      if (item.id == music.id) {
        _idIndex = index;
      }
    });
    player.playingList.asMap().forEach((int index, Music item) {
      if (item.id == player.current.id) {
        _currentIndex = index;
      }
    });

    if (_idIndex == -1) {
      // 下一首播放的歌曲不存在列表中
      player.playingList
          .insert(_currentIndex == -1 ? 0 : _currentIndex + 1, music);
      _playingList = player.playingList;
    } else {
      if (player.current.id != music.id) {
        // 不是当前正在播放的歌曲

      }
      _playingList = player.playingList;
      _playingList.removeAt(_idIndex);
      if (_playingList.length == 0) {
        player.playingList.insert(0, music);
      } else {
        player.playingList.insert(_currentIndex + 1, music);
      }

      _playingList = player.playingList;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_currentIndex == -1) {
      // 列表为空
      prefs.setString(
        _PREF_KEY_PLAYING,
        json.encode(_playingList[0], toEncodable: (e) => e.toMap()),
      );
    }

    prefs.setString(_PREF_KEY_PLAYLIST,
        json.encode(_playingList, toEncodable: (e) => e.toMap()));

    setState(() {
      player = (PlayerControllerState(
          current: _currentIndex == -1 ? _playingList[0] : player.current,
          playMode: player.playMode,
          playingList: _playingList,
          isPlaying: player.isPlaying,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  // 多选播放下一首
  Future<void> playInsertMultiNext(List<Music> musics) async {
    int _currentIndex = -1;
    var _playingList = player.playingList;
    if (_playingList.length <= 0) {
      var _currentSongUrl = await _getSongUrl(musics[0].id);
      musics[0].songUrl = _currentSongUrl;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(
        _PREF_KEY_PLAYING,
        json.encode(musics[0], toEncodable: (e) => e.toMap()),
      );
      prefs.setString(_PREF_KEY_PLAYLIST,
          json.encode(musics, toEncodable: (e) => e.toMap()));

      setState(() {
        player = (PlayerControllerState(
            current: musics[0],
            playMode: player.playMode,
            playingList: musics,
            isPlaying: player.isPlaying,
            position: player.position,
            duration: player.duration,
            time: player.time));
      });
    } else {
      var _musics = musics;
      player.playingList.asMap().forEach((int index, Music item) {
        if (item.id == player.current.id) {
          _currentIndex = index;
        }
      });

      _musics.forEach((Music music) {
        var _flag = false;
        for (Music musics in _playingList) {
          if (music.id == musics.id) {
            _flag = true;
          }
        }
        if (_flag == false) {
          player.playingList.insert(_currentIndex + 1, music);
          _playingList = player.playingList;
        }
      });

      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(_PREF_KEY_PLAYLIST,
            json.encode(_playingList, toEncodable: (e) => e.toMap()));
        setState(() {
          player = (PlayerControllerState(
              current: player.current,
              playMode: player.playMode,
              playingList: _playingList,
              isPlaying: player.isPlaying,
              position: player.position,
              duration: player.duration,
              time: player.time));
        });
      });
    }
  }

  void pause(Music music) {}

  // 切换播放模式
  Future<void> switchPlayMode() {
    switch (player.playMode) {
      case PlayMode.single:
        SharedPreferences.getInstance().then((prefs) {
          prefs.setInt(_PREF_KEY_PLAY_MODE, 1);
          setState(() {
            player = (PlayerControllerState(
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

  // 是否正在播放
  Future<void> switchPlayingState(bool state) {
    setState(() {
      player = (PlayerControllerState(
          current: player.current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: state,
          position: player.position,
          duration: player.duration,
          time: player.time));
    });
  }

  // 播放器状态
  Future<void> setPlayingState(Duration pos, Duration dur, double time) {
    setState(() {
      player = (PlayerControllerState(
          current: player.current,
          playMode: player.playMode,
          playingList: player.playingList,
          isPlaying: player.isPlaying,
          position: pos,
          duration: dur,
          time: time));
    });
  }

  // 清空播放列表
  Future<String> clearPlayingList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_PREF_KEY_PLAYING);
    prefs.remove(_PREF_KEY_PLAYLIST);
    var __curent = player.current;
    __curent.id = -1;
    setState(() {
      player = PlayerControllerState(
          current: __curent,
          playMode: player.playMode,
          playingList: [],
          isPlaying: false,
          position: Duration.zero,
          duration: Duration.zero,
          time: 0.0);
    });
    return '';
  }

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  // 获取歌曲评论数
  _getSongComment(int id) async {
    var result = await NeteaseRepository.getSongComment(id);
    return result['total'];
  }

  @override
  void initState() {
    super.initState();
    _getSavedInfo();
  }

  void _getSavedInfo() async {
    var preference = await SharedPreferences.getInstance();
    // preference.clear();
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
