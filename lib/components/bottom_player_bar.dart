import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './inherited_demo.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import './position_event.dart';

class BottomPlayerBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final double time;
  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback complete;
  final VoidCallback setMode;
  final ValueChanged<String> toggle;
  final ValueChanged<String> finish;
  final ValueChanged<double> handleSlider;
  final ValueChanged<double> seek;
  final AudioPlayer audioPlayer;
  BottomPlayerBar(
      {this.play,
      this.pause,
      this.finish,
      this.complete,
      this.toggle,
      this.position,
      this.duration,
      this.time,
      this.handleSlider,
      this.setMode,
      this.seek,
      @required this.audioPlayer});

  @override
  _BottomPlayerBarState createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  bool _isMusicLoading = false;
  AudioPlayer audioPlayer;
  bool _playingState = false; // 播放器播放icon切换
  bool loaded = false; // 记录是否已经加载过音乐
  int mode;

  // StreamSubscription _audioPlayerStateSubscription;

  AudioPlayerState playerState = AudioPlayerState.STOPPED;
  get _durationText => widget.duration?.toString()?.split('.')?.first ?? '';
  // get _positionText => widget.position?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    // _audioPlayerStateSubscription.cancel();
    // _playerCompleteSubscription.cancel();

    super.dispose();
  }

  Future<int> _play(String source) async {
    var result;
    try {
      result = await widget.audioPlayer.play(source);
      return result;
    } catch (e) {
      print(e);
    }
  }

  void initAudioPlayer() async {
    // final store = StateContainer.of(context);
    // audioPlayer = widget.audioPlayer;
    // var preference = await SharedPreferences.getInstance();
    // var _mode = preference.getInt('player_play_mode');
    // mode = _mode;
    // if (mode == 0) {
    //   audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    // } else {
    //   audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
    // }

    // 播放完成
    // _playerCompleteSubscription =
    //     audioPlayer.onPlayerCompletion.listen((event) async {
    //   final store = StateContainer.of(context);
    //   // _audioPlayerState = AudioPlayerState.COMPLETED;

    //   if (store.player.playMode.toString() == 'PlayMode.single') {
    //     // 循环播放
    //     audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    //     audioPlayer.resume();
    //     return;
    //   }
    //   audioPlayer.setReleaseMode(ReleaseMode.RELEASE);

    //   var res = await audioPlayer.stop();
    //   if (res == 1) {
    //     widget.complete();
    //     setState(() {
    //       _playingState = false;
    //     });
    //     loaded = false;
    //     if (store.player.playMode.toString() == 'PlayMode.sequence') {
    //       // 顺序播放
    //       widget.finish('sequence');
    //     } else if (store.player.playMode.toString() == 'PlayMode.shuffle') {
    //       // 随机播放
    //       widget.finish('shuffle');
    //     }
    //     setState(() {
    //       _isMusicLoading = true;
    //     });
    //     var res = await _play(store.player.current.songUrl);
    //     if (res == 1) {
    //       setState(() {
    //         _isMusicLoading = false;
    //       });
    //       widget.play();
    //       loaded = true;
    //       setState(() {
    //         _playingState = true;
    //       });
    //     }
    //   }
    // });

    // 播放状态
    // _audioPlayerStateSubscription =
    //     audioPlayer.onPlayerStateChanged.listen((state) {
    //   setState(() {
    //     // _audioPlayerState = state;
    //   });
    // });

    // if (store.player.isPlaying == true) {
    //   widget.play();
    //   loaded = true;
    //   setState(() {
    //     _playingState = true;
    //   });
    //   return;
    // }
    // var res = await _play(store.player.current.songUrl);
    // if (res == 1) {
    //   widget.play();
    //   loaded = true;
    //   setState(() {
    //     _playingState = true;
    //   });
    // }
  }

  IconButton _buildPlayButton(
      bool state, StateContainerState store, BuildContext ctx) {
    return state == false
        ? IconButton(
            icon: Icon(Icons.play_circle_outline, size: 30.0),
            onPressed: widget.play,
          )
        : IconButton(
            icon: Icon(Icons.pause_circle_outline, size: 30.0),
            onPressed: widget.pause,
          );
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    final playmode = store.player.playMode.toString();
    String _positionText = '';
    setState(() {
      _playingState = store.player.isPlaying;
      if (store.player.position != null) {
        _positionText =
            store.player.position?.toString()?.split('.')?.first ?? '';
      }
    });
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
                      Text(_positionText,
                          style: TextStyle(color: Colors.white)),
                      Expanded(
                        child: Slider(
                            activeColor: Colors.white,
                            inactiveColor: Color(0x64ffffff),
                            value: (widget.position != null &&
                                    widget.duration != null &&
                                    widget.position.inMilliseconds > 0 &&
                                    widget.position.inMilliseconds <
                                        widget.duration.inMilliseconds)
                                ? widget.time
                                : 0.0,
                            onChanged: (widget.position != null &&
                                    widget.duration != null &&
                                    widget.position.inMilliseconds > 0 &&
                                    widget.position.inMilliseconds <
                                        widget.duration.inMilliseconds)
                                ? (double value) {
                                    widget.seek(value);
                                  }
                                : (double value) {
                                    widget.handleSlider(value);
                                  },
                            min: 0.0,
                            max: 1.0),
                      ),
                      Text(
                        widget.duration != null ? '$_durationText' : '',
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
                          widget.toggle('prev');
                        },
                      ),
                      _buildPlayButton(_playingState, store, context),
                      IconButton(
                        icon: Icon(Icons.skip_next, size: 30.0),
                        onPressed: () {
                          widget.toggle('next');
                        },
                      ),
                      InkResponse(
                        onTap: widget.setMode,
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
