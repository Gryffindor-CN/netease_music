import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:netease_music/model/music.dart';
import './inherited_demo.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import './playing_list_sheet.dart';

class BottomPlayerBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final double time;
  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback complete;
  final VoidCallback setMode;
  final ValueChanged<BuildContext> clear;
  final ValueChanged<String> toggle;
  final ValueChanged<double> handleSlider;
  final ValueChanged<double> seek;
  final ValueChanged<Music> playCertain;
  final ValueChanged<Music> deleteCertain;
  final AudioPlayer audioPlayer;
  BottomPlayerBar(
      {this.play,
      this.pause,
      this.complete,
      this.toggle,
      this.position,
      this.duration,
      this.time,
      this.handleSlider,
      this.setMode,
      this.seek,
      this.playCertain,
      this.deleteCertain,
      this.clear,
      @required this.audioPlayer});

  @override
  _BottomPlayerBarState createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar>
    with TickerProviderStateMixin {
  AudioPlayer audioPlayer;
  bool _playingState = false; // 播放器播放icon切换
  bool loaded = false; // 记录是否已经加载过音乐
  int mode;
  AnimationController _animationController;
  AudioPlayerState playerState = AudioPlayerState.STOPPED;
  get _durationText => widget.duration?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
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
                      InkResponse(
                        onTap: widget.setMode,
                        child: Icon(icon),
                      ),
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
                      IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          // 弹出播放列表
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return PlayingListSheet(play: (Music music) {
                                  widget.playCertain(music);
                                }, delete: (Music music) {
                                  widget.deleteCertain(music);
                                }, clear: (BuildContext ctx) {
                                  widget.clear(ctx);
                                });
                              });
                        },
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
