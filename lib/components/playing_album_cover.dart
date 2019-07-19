import 'package:flutter/material.dart';
import 'dart:math';
import '../model/music.dart';
import 'dart:ui';
import './bottom_player_bar.dart';
import './inherited_demo.dart';
import 'lyric.dart';
import 'dart:async';

import './lyricNotifierData.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlbumCover extends StatefulWidget {
  final Music music;
  final bool isNew;

  const AlbumCover({
    Key key,
    this.music,
    this.isNew,
  }) : super(key: key);

  @override
  State createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> with TickerProviderStateMixin {
  final _commonTween = new Tween<double>(begin: 0.0, end: 1);
  final _rotateTween = new Tween<double>(begin: -0.15, end: -0.04);
  AnimationController controller_record;
  Animation<double> animation_record;
  AnimationController controller_needle;
  Animation<double> animation_neddle;

  PositionNotifierData vd = PositionNotifierData(Duration());
  AudioPlayer audioPlayer;
  double volumn = 0.5; // 音量控制
  bool showVolumnController = false;
  Duration position;
  Duration duration;
  double time = 0.0;
  int mode;
  bool loaded = false;
  StreamSubscription _positionSubscription;
  StreamSubscription _durationSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerCompleteSubscription;

  initAudioPlayer(StateContainerState store, AudioPlayer audioPlayer,
      BuildContext ctx) async {
    // 播放进度改变
    _positionSubscription = audioPlayer.onAudioPositionChanged.listen((p) {
      if (position != null &&
          position != null &&
          position.inMilliseconds > 0 &&
          position.inMilliseconds < duration.inMilliseconds) {
        time = position.inMilliseconds / duration.inMilliseconds;
      }

      if (duration != null) {
        store.setPlayingState(p, duration, time);
      }
      position = p;
      vd.value = p;
    });

    // 获取歌曲播放时间
    _durationSubscription = audioPlayer.onDurationChanged.listen((d) async {
      duration = d;
      store.setPlayingState(position, d, time);
    });

    // 播放出错
    _playerErrorSubscription = audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      final store = StateContainer.of(context);
      store.switchPlayingState(false);
      setState(() {
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
    });

    // 播放完成
    _playerCompleteSubscription =
        audioPlayer.onPlayerCompletion.listen((event) async {
      final store = StateContainer.of(ctx);

      if (store.player.playMode.toString() == 'PlayMode.single') {
        // 循环播放
        audioPlayer.setReleaseMode(ReleaseMode.LOOP);
        audioPlayer.resume();
        return;
      }
      audioPlayer.setReleaseMode(ReleaseMode.RELEASE);

      var res = await audioPlayer.stop();
      if (res == 1) {
        store.setPlayingState(Duration.zero, Duration.zero, 0.0);
        store.switchPlayingState(false);

        if (store.player.playMode.toString() == 'PlayMode.sequence') {
          // 顺序播放

          await store.playNext();
        } else if (store.player.playMode.toString() == 'PlayMode.shuffle') {
          // 随机播放
          await store.playShuffle();
        }

        var res = await audioPlayer.play(store.player.current.songUrl);
        if (res == 1) {
          store.switchPlayingState(true);
          controller_record.forward();
          controller_needle.forward();
        }
      }
    });

    var preference = await SharedPreferences.getInstance();
    var _mode = preference.getInt('player_play_mode');
    mode = _mode;
    if (mode == 0) {
      audioPlayer.setReleaseMode(ReleaseMode.LOOP);
    } else {
      audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
    }
    var res = await audioPlayer.play(store.player.current.songUrl);
    if (res == 1) {
      store.switchPlayingState(true);
      store.setPlayingState(Duration.zero, Duration.zero, 0.0);
      controller_record.forward();
      controller_needle.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    animation_neddle =
        new CurvedAnimation(parent: controller_needle, curve: Curves.linear);

    animation_record.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller_record.repeat();
      } else if (status == AnimationStatus.dismissed) {
        controller_record.forward();
      }
    });
  }

  @override
  void dispose() {
    controller_record.dispose();
    controller_needle.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    final _music = store.player.current;
    final _duration = store.player.duration;
    final _position = store.player.position;
    final _time = store.player.time;

    if (store.player.audioPlayer == null && loaded == false) {
      store.setPlayer(AudioPlayer());
      audioPlayer = AudioPlayer();
    } else {
      audioPlayer = store.player.audioPlayer;
    }

    // 从歌曲搜索页面跳转过来
    if (widget.isNew != null && loaded == false) {
      if (store.player.isPlaying) {
        audioPlayer.stop();
      }
      initAudioPlayer(store, audioPlayer, context);
      loaded = true;
    }

    if (store.player.isPlaying == true) {
      controller_record.forward();
      controller_needle.forward();
      loaded = true;
      vd.value = _position;
    }
    if (store.player.isPlaying == false &&
        loaded == false &&
        _position.inMilliseconds == 0) {
      initAudioPlayer(store, audioPlayer, context);
      loaded = true;
    }

    setState(() {
      position = _position;
      duration = _duration;
      time = _time;
    });
    return NotificationListener<ShowVolumnControllerNotification>(
        onNotification: (notification) {
          setState(() {
            showVolumnController = notification.isShow;
          });
        },
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _BlurBackground(
                music: store.player.current,
              ),
              Material(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
                    _PlayingTitle(audioPlayer: audioPlayer, music: _music),
                    showVolumnController == true
                        ? Container(
                            padding: EdgeInsets.only(left: 15.0),
                            width: MediaQuery.of(context).size.width,
                            height: 28.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  volumn == 0.0
                                      ? Icons.volume_off
                                      : Icons.volume_up,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                Expanded(
                                    child: Slider(
                                  activeColor: Colors.white,
                                  inactiveColor: Color(0x64ffffff),
                                  value: volumn,
                                  max: 1.0,
                                  onChanged: (double value) {
                                    setState(() {
                                      volumn = value;
                                      audioPlayer.setVolume(value);
                                    });
                                  },
                                ))
                              ],
                            ),
                          )
                        : Container(),
                    Expanded(
                      child: _CenterSection(
                        audioPlayer: audioPlayer,
                        vd: vd,
                        position: position,
                        music: _music,
                        commonTween: _commonTween,
                        rotateTween: _rotateTween,
                        controllerRecord: controller_record,
                        controllerNeedle: controller_needle,
                      ),
                    ),
                    _OperationBar(
                      music: _music,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                    _ControllerBar(
                      audioPlayer: audioPlayer,
                      position: position,
                      duration: duration,
                      handleSlider: (double value) {
                        store.setPlayingState(
                            Duration(
                                milliseconds:
                                    (value * duration.inMilliseconds).round()),
                            duration,
                            value);
                      },
                      seek: (double value) {
                        audioPlayer.seek(Duration(
                            milliseconds:
                                (value * _duration.inMilliseconds).round()));
                      },
                      setMode: () async {
                        await store.switchPlayMode();
                        if (store.player.playMode == PlayMode.single) {
                          await audioPlayer.setReleaseMode(ReleaseMode.LOOP);
                        } else {
                          await audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
                        }
                      },
                      pause: () async {
                        var res = await audioPlayer.pause();
                        if (res == 1) {
                          store.switchPlayingState(false);
                          controller_record.stop(canceled: false);
                          controller_needle.reverse();
                        }
                      },
                      complete: () async {
                        await store.setPlayingState(
                            Duration.zero, Duration.zero, 0.0);
                        await store.switchPlayingState(false);
                      },
                      play: () async {
                        var res = await audioPlayer
                            .play(store.player.current.songUrl);
                        if (res == 1) {
                          store.switchPlayingState(true);
                          controller_record.forward();
                          controller_needle.forward();
                        }
                      },
                      toggle: (String playmode) async {
                        switch (playmode) {
                          case 'prev':
                            final result = await audioPlayer.stop();
                            if (result == 1) {
                              await store.setPlayingState(
                                  Duration.zero, Duration.zero, 0.0);

                              await store.switchPlayingState(false);

                              controller_record.stop(canceled: false);
                              controller_needle.reverse();
                              await store.playPrev();
                              final res = await audioPlayer
                                  .play(store.player.current.songUrl);
                              if (res == 1) {
                                store.switchPlayingState(true);
                                controller_record.forward();
                                controller_needle.forward();
                                // Player.idEventBus.fire(store.player.current.id);
                              }
                            }

                            break;
                          case 'next':
                            final result = await audioPlayer.stop();
                            if (result == 1) {
                              await store.setPlayingState(
                                  Duration.zero, Duration.zero, 0.0);

                              await store.switchPlayingState(false);

                              controller_record.stop(canceled: false);
                              controller_needle.reverse();
                              await store.playNext();
                              final res = await audioPlayer
                                  .play(store.player.current.songUrl);
                              if (res == 1) {
                                store.switchPlayingState(true);
                                controller_record.forward();
                                controller_needle.forward();
                                // Player.idEventBus.fire(store.player.current.id);
                              }
                            }
                            break;
                        }
                      },
                      time: time,
                      store: store,
                      controllerNeedle: controller_needle,
                      controllerRecord: controller_record,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class RotateRecord extends AnimatedWidget {
  RotateRecord({
    Key key,
    Animation<double> animation,
    @required this.music,
  }) : super(key: key, listenable: animation);

  final Music music;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          // decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(20.0))),
          height: 250.0,
          width: 250.0,
          child: RotationTransition(
              turns: animation,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/play_disc.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 170.0,
                    height: 170.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(music.albumCoverImg),
                          fit: BoxFit.fill),
                    ),
                  )
                ],
              )),
        ),
      ],
    );
  }
}

class PivotTransition extends AnimatedWidget {
  PivotTransition(
      {Key key,
      this.alignment: FractionalOffset.topCenter,
      @required Animation<double> turns,
      this.child})
      : super(key: key, listenable: turns);

  Animation<double> get turns => listenable;

  /// The pivot point to rotate around.
  final FractionalOffset alignment;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double turnsValue = turns.value;
    final Matrix4 transform = Matrix4.rotationZ(turnsValue * pi * 2.0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

class _BlurBackground extends StatelessWidget {
  final Music music;
  const _BlurBackground({Key key, @required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            music.albumCoverImg,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black54,
                Colors.black26,
                Colors.black45,
                Colors.black87,
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class _CenterSection extends StatefulWidget {
  final Duration position;
  final Music music;
  final Tween<double> rotateTween;
  final Tween<double> commonTween;
  final AnimationController controllerRecord;
  final AnimationController controllerNeedle;
  final PositionNotifierData vd;
  final AudioPlayer audioPlayer;
  const _CenterSection({
    Key key,
    this.rotateTween,
    this.commonTween,
    this.controllerRecord,
    this.controllerNeedle,
    this.position,
    this.vd,
    this.audioPlayer,
    @required this.music,
  }) : super(key: key);

  @override
  __CenterSectionState createState() => __CenterSectionState();
}

class __CenterSectionState extends State<_CenterSection> {
  bool _first = true;
  LyricNotifierData lyricNotifierData = LyricNotifierData(Duration());

  GlobalKey _containerKey = GlobalKey();
  Size _containerSize = Size(0, 0);
  Offset _containerPosition = Offset(0, 0);

  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
  }

  _getContainerPosition() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);
  }

  @override
  void initState() {
    widget.vd.addListener(() {
      lyricNotifierData.value = widget.vd.value;
    });

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
  }

  _onBuildCompleted(_) {
    _getContainerSize();
    _getContainerPosition();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _containerKey,
      width: MediaQuery.of(context).size.width,
      child: AnimatedCrossFade(
        crossFadeState:
            _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
            Key bottomChildKey) {
          return Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 10.0),
                key: bottomChildKey,
                child: bottomChild,
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 10.0),
                key: topChildKey,
                child: topChild,
              )
            ],
          );
        },
        duration: Duration(milliseconds: 300),
        firstChild: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                ShowVolumnControllerNotification(isShow: true)
                    .dispatch(context);
                setState(() {
                  _first = false;
                });
              },
              child: Container(
                margin: EdgeInsets.only(top: 60.0),
                child: RotateRecord(
                    music: widget.music,
                    animation:
                        widget.commonTween.animate(widget.controllerRecord)),
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              child: Container(
                  padding: EdgeInsets.only(left: 80.0),
                  child: PivotTransition(
                    turns: widget.rotateTween.animate(widget.controllerNeedle),
                    alignment: FractionalOffset.topLeft,
                    child: Container(
                      width: 100.0,
                      child: Image.asset("assets/play_needle.png"),
                    ),
                  )),
            ),
          ],
        ),
        secondChild: Center(
          child: GestureDetector(
              onTap: () {
                ShowVolumnControllerNotification(isShow: false)
                    .dispatch(context);
                setState(() {
                  _first = true;
                });
              },
              child: (widget.vd.value != null &&
                      widget.vd.value.inMilliseconds > 0)
                  ? Lyric(
                      songId: widget.music.id,
                      position: lyricNotifierData,
                      isShow: !_first,
                    )
                  : Text('')),
        ),
      ),
    );
  }
}

class _ControllerBar extends StatelessWidget {
  final AnimationController controllerRecord;
  final AnimationController controllerNeedle;
  final StateContainerState store;
  final AudioPlayer audioPlayer;
  final Duration position;
  final Duration duration;
  final double time;
  final ValueChanged<double> handleSlider;
  final ValueChanged<String> toggle;
  final ValueChanged<double> seek;
  final VoidCallback complete;
  final VoidCallback play;
  final VoidCallback pause;
  final VoidCallback setMode;
  const _ControllerBar({
    Key key,
    this.controllerRecord,
    this.controllerNeedle,
    this.position,
    this.duration,
    this.time,
    this.handleSlider,
    this.play,
    this.toggle,
    this.complete,
    this.pause,
    this.setMode,
    this.seek,
    @required this.store,
    @required this.audioPlayer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomPlayerBar(
        audioPlayer: audioPlayer,
        handleSlider: handleSlider,
        position: position,
        duration: duration,
        time: time,
        play: play,
        pause: pause,
        complete: complete,
        setMode: setMode,
        toggle: (String playmode) {
          toggle(playmode);
        },
        seek: (double value) {
          seek(value);
        },
        finish: (String playmode) {
          switch (playmode) {
            case 'sequence':
              store.playNext();
              break;
            case 'shuffle':
              store.playShuffle();
              break;
          }
        });
  }
}

class _OperationBar extends StatelessWidget {
  final Music music;
  const _OperationBar({Key key, @required this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).primaryIconTheme.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.favorite,
              color: iconColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.file_download,
              color: iconColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.comment,
              color: iconColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.share,
              color: iconColor,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: iconColor,
            ),
            onPressed: () {}),
      ],
    );
  }
}

class _PlayingTitle extends StatelessWidget {
  final Music music;
  final AudioPlayer audioPlayer;
  const _PlayingTitle({Key key, this.audioPlayer, @required this.music})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          tooltip: '返回上一层',
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryIconTheme.color,
          ),
          onPressed: () {
            // audioPlayer.dispose();

            Navigator.pop(context);
          }),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            music.name,
            style: TextStyle(fontSize: 17),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Text(
                    music.aritstName,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .body1
                        .copyWith(fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.chevron_right, size: 17),
              ],
            ),
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text("下载"),
              ),
            ];
          },
          icon: Icon(
            Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        )
      ],
    );
  }
}

class PositionNotifierData extends ValueNotifier<Duration> {
  PositionNotifierData(value) : super(value);
}

class ShowVolumnControllerNotification extends Notification {
  ShowVolumnControllerNotification({
    @required this.isShow,
  });
  final bool isShow;
}

enum PlayMode {
  ///aways play single song
  single,

  ///play current list sequence
  sequence,

  ///random to play next song
  shuffle
}
