import 'package:flutter/material.dart';
import '../model/music.dart';
import '../components/player.dart';
import '../components/inherited_demo.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class BottomPlayerBar extends StatefulWidget {
  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback finish;
  BottomPlayerBar({this.play, this.pause, this.finish});

  @override
  _BottomPlayerBarState createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  AudioPlayer audioPlayer;
  bool _playingState = false;
  Duration position;
  Duration duration;
  double time = 0.0;
  bool loaded = false;
  StreamSubscription _positionSubscription;
  StreamSubscription _durationSubscription;
  StreamSubscription _audioPlayerStateSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  AudioPlayerState _audioPlayerState;
  AudioPlayerState playerState = AudioPlayerState.STOPPED;

  get isPlaying => playerState == AudioPlayerState.PLAYING;
  get isPaused => playerState == AudioPlayerState.PAUSED;

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  void initAudioPlayer() async {
    audioPlayer = new AudioPlayer();

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
    });

    _durationSubscription = audioPlayer.onDurationChanged.listen((d) {
      print('d===$d');
      if (loaded == false) {
        audioPlayer.resume();
        widget.play();
        loaded = true;
        setState(() {
          duration = d;
          _playingState = true;
        });
      }
    });

    // 播放完成
    _playerCompleteSubscription =
        audioPlayer.onPlayerCompletion.listen((event) {
      print('finished');

      _audioPlayerState = AudioPlayerState.COMPLETED;
      // widget.finish();
      // widget.pause();
      // setState(() {
      //   _playingState = !_playingState;
      //   duration = Duration(seconds: 0);
      //   position = Duration(seconds: 0);
      //   time = 0.0;
      // });
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
            icon: Icon(Icons.play_circle_outline, size: 30.0),
            onPressed: () async {
              print(loaded);
              if (loaded == true) {
                audioPlayer.resume();
                setState(() {
                  widget.play();
                  _playingState = true;
                });
              } else {
                await audioPlayer.setUrl(store.player.current.songUrl);
              }

              // int result = await audioPlayer.play(
              //     // 'http://m10.music.126.net/20190711172551/5ab2e85c63866c56fdbc8d615415a654/ymusic/603f/2799/ea87/0ac26d0e219c049b2c5a12fd6be2826f.mp3',
              //     store.player.current.songUrl);
              // if (result == 1) {
              //   if (duration != null && duration.inMilliseconds > 0) {
              //     widget.play();
              //     setState(() {
              //       _playingState = true;
              //     });
              //   }
              // }
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

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);

    return Material(
      color: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.white,
                )),
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            decoration: BoxDecoration(color: Colors.transparent),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Slider(
                      activeColor: Colors.white,
                      inactiveColor: Color(0x64ffffff),
                      value: (position != null &&
                              duration != null &&
                              position.inMilliseconds > 0 &&
                              position.inMilliseconds < duration.inMilliseconds)
                          ? time
                          : 0.0,
                      onChanged: (position != null &&
                              duration != null &&
                              position.inMilliseconds > 0 &&
                              position.inMilliseconds < duration.inMilliseconds)
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
                Container(
                  width: 40.0,
                  height: 40.0,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    value: (position != null &&
                            duration != null &&
                            position.inMilliseconds > 0 &&
                            position.inMilliseconds < duration.inMilliseconds)
                        ? position.inMilliseconds / duration.inMilliseconds
                        : 0.0,
                    valueColor: new AlwaysStoppedAnimation(Colors.red),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 30.0),
                      onPressed: () {
                        audioPlayer.release();
                        widget.pause();
                        setState(() {
                          _playingState = false;
                          duration = Duration(seconds: 0);
                          position = Duration(seconds: 0);
                          time = 0.0;
                        });
                        store.playPrev();
                      },
                    ),
                    _buildPlayButton(_playingState, store),
                    IconButton(
                      icon: Icon(Icons.arrow_forward, size: 30.0),
                      onPressed: () async {
                        loaded = false;
                        // audioPlayer.resume();
                        audioPlayer.stop();
                        widget.pause();
                        setState(() {
                          duration = Duration(seconds: 0);
                          position = Duration(seconds: 0);
                          time = 0.0;
                          _playingState = false;
                        });
                        store.playNext();

                        // audioPlayer.stop();
                        // await audioPlayer.play(
                        //     'http://m10.music.126.net/20190711163224/a31f1c150e5ec198611050aba33cc1af/ymusic/603f/2799/ea87/0ac26d0e219c049b2c5a12fd6be2826f.mp3');
                        // setState(() {
                        //   _playingState = false;
                        //   duration = Duration(seconds: 0);
                        //   position = Duration(seconds: 0);
                        //   time = 0.0;
                        // });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shuffle, size: 30.0),
                      onPressed: () {
                        store.switchPlayMode();
                      },
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
