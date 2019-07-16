import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/inherited_demo.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './position_event.dart';

class BottomPlayerBar extends StatefulWidget {
  final VoidCallback play;
  final VoidCallback pause;
  final ValueChanged<String> finish;
  BottomPlayerBar({this.play, this.pause, this.finish});

  @override
  _BottomPlayerBarState createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  bool _isMusicLoading = false;
  AudioPlayer audioPlayer;
  bool _playingState = false; // 播放器播放icon切换
  Duration position;
  Duration duration;
  double time = 0.0;
  bool loaded = false; // 记录是否已经加载过音乐
  double volumn; // 音量控制
  int mode;
  StreamSubscription _positionSubscription;
  StreamSubscription _durationSubscription;
  StreamSubscription _audioPlayerStateSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  AudioPlayerState _audioPlayerState;
  AudioPlayerState playerState = AudioPlayerState.STOPPED;
  get _durationText => duration?.toString()?.split('.')?.first ?? '';
  get _positionText => position?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  Future<int> _play(String source) async {
    var result;
    try {
      result = await audioPlayer.play(source);
      return result;
    } catch (e) {
      print(e);
    }
  }

  void initAudioPlayer() async {
    audioPlayer = new AudioPlayer();
    var preference = await SharedPreferences.getInstance();
    var _mode = preference.getInt('player_play_mode');
    mode = _mode;
    if (mode == 0) {
      audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    } else {
      audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
    }
    // 播放进度改变
    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) {
      if (position != null &&
          duration != null &&
          position.inMilliseconds > 0 &&
          position.inMilliseconds < duration.inMilliseconds) {
        setState(() {
          time = position.inMilliseconds / duration.inMilliseconds;
        });
      }
      setState(() {
        position = p;
      });
      // print(Duration().inMilliseconds);
      Player.handleMusicPosFire(p);
    });

    _durationSubscription = audioPlayer.onDurationChanged.listen((d) async {
      setState(() {
        duration = d;
      });
    });

    // 播放完成
    _playerCompleteSubscription =
        audioPlayer.onPlayerCompletion.listen((event) async {
      final store = StateContainer.of(context);
      _audioPlayerState = AudioPlayerState.COMPLETED;

      if (store.player.playMode.toString() == 'PlayMode.single') {
        // 循环播放
        audioPlayer.setReleaseMode(ReleaseMode.LOOP);
        audioPlayer.resume();
        return;
      }
      audioPlayer.setReleaseMode(ReleaseMode.RELEASE);

      var res = await audioPlayer.stop();
      if (res == 1) {
        setState(() {
          duration = Duration(seconds: 0);
          position = Duration(seconds: 0);
          time = 0.0;
          _playingState = false;
        });
        loaded = false;
        if (store.player.playMode.toString() == 'PlayMode.sequence') {
          // 顺序播放
          widget.finish('sequence');
        } else if (store.player.playMode.toString() == 'PlayMode.shuffle') {
          // 随机播放
          widget.finish('shuffle');
        }
        setState(() {
          _isMusicLoading = true;
        });
        var res = await _play(store.player.current.songUrl);
        if (res == 1) {
          Player.handleSongidFire(store.player.current.id);
          setState(() {
            _isMusicLoading = false;
          });
          widget.play();
          loaded = true;
          setState(() {
            _playingState = true;
          });
        }
      }
    });

    // 播放状态
    _audioPlayerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _audioPlayerState = state;
      });
    });

    // 播放出错
    _playerErrorSubscription = audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });

    final store = StateContainer.of(context);
    var res = await _play(store.player.current.songUrl);
    if (res == 1) {
      Player.handleSongidFire(store.player.current.id);
      widget.play();
      loaded = true;
      setState(() {
        _playingState = true;
      });
    }
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _audioPlayerStateSubscription.cancel();
    _durationSubscription.cancel();
    _playerCompleteSubscription.cancel();
    _playerErrorSubscription.cancel();
    audioPlayer.stop();
    super.dispose();
  }

  IconButton _buildPlayButton(bool state, StateContainerState store) {
    return state == false
        ? IconButton(
            icon: _isMusicLoading == true
                ? CircularProgressIndicator()
                : Icon(Icons.play_circle_outline, size: 30.0),
            onPressed: () async {
              if (loaded == true) {
                audioPlayer.resume();
                setState(() {
                  widget.play();
                  _playingState = true;
                });
              } else {
                setState(() {
                  _isMusicLoading = true;
                });
                var result = await _play(store.player.current.songUrl);
                if (result == 1) {
                  setState(() {
                    _isMusicLoading = false;
                  });
                  widget.play();
                  loaded = true;
                  setState(() {
                    _playingState = true;
                  });
                }
              }
            },
          )
        : IconButton(
            icon: Icon(Icons.pause_circle_outline, size: 30.0),
            onPressed: () async {
              await audioPlayer.pause();
              widget.pause();
              setState(() {
                _playingState = false;
              });
            },
          );
  }

  // 切换歌曲
  void switchSong(StateContainerState store, String flag) async {
    setState(() {
      duration = Duration();
      position = Duration();
      time = 0.0;
      _playingState = false;
    });
    loaded = false;
    switch (flag) {
      case 'prev':
        store.playPrev();
        break;
      case 'next':
        store.playNext();
        break;
    }

    var res = await _play(store.player.current.songUrl);
    if (res == 1) {
      Player.handleSongidFire(store.player.current.id);
      widget.play();
      loaded = true;
      setState(() {
        _playingState = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    final playmode = store.player.playMode.toString();

    IconData icon;
    switch (playmode) {
      case 'PlayMode.single':
        icon = Icons.repeat_one;
        break;
      case 'PlayMode.sequence':
        icon = Icons.repeat;
        break;
      case 'PlayMode.shuffle':
        icon = Icons.shuffle;
        break;
    }
    return Material(
      color: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.white,
                )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            height: 130.0,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(position != null ? '${_positionText ?? ''}' : '',
                          style: TextStyle(color: Colors.white)),
                      Expanded(
                        child: Slider(
                            activeColor: Colors.white,
                            inactiveColor: Color(0x64ffffff),
                            value: (position != null &&
                                    duration != null &&
                                    position.inMilliseconds > 0 &&
                                    position.inMilliseconds <
                                        duration.inMilliseconds)
                                ? time
                                : 0.0,
                            onChanged: (position != null &&
                                    duration != null &&
                                    position.inMilliseconds > 0 &&
                                    position.inMilliseconds <
                                        duration.inMilliseconds)
                                ? (double value) {
                                    audioPlayer.seek(Duration(
                                        milliseconds:
                                            (value * duration.inMilliseconds)
                                                .round()));

                                    setState(() {
                                      position = Duration(
                                          milliseconds:
                                              (value * duration.inMilliseconds)
                                                  .round());
                                    });
                                    setState(() {
                                      time = value;
                                    });
                                  }
                                : (double value) {},
                            min: 0.0,
                            max: 1.0),
                      ),
                      Text(
                        duration != null ? '$_durationText' : '',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.skip_previous, size: 30.0),
                        onPressed: () {
                          widget.pause();
                          Future.delayed(Duration(milliseconds: 150), () async {
                            final result = await audioPlayer.stop();
                            if (result == 1) {
                              switchSong(store, 'prev');
                            }
                          });
                        },
                      ),
                      _buildPlayButton(_playingState, store),
                      IconButton(
                        icon: Icon(Icons.skip_next, size: 30.0),
                        onPressed: () {
                          widget.pause();
                          Future.delayed(Duration(milliseconds: 150), () async {
                            final result = await audioPlayer.stop();
                            if (result == 1) {
                              switchSong(store, 'next');
                            }
                          });
                        },
                      ),
                      InkResponse(
                        onTap: () async {
                          store.switchPlayMode();
                          if (store.player.playMode == PlayMode.single) {
                            await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                          } else {
                            await audioPlayer
                                .setReleaseMode(ReleaseMode.RELEASE);
                          }
                        },
                        // child: Text(
                        //   store.player.playMode.toString(),
                        //   style: TextStyle(color: Colors.white),
                        // ),
                        child: Icon(icon),
                      ),
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {},
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
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
