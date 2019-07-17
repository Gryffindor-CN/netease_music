import 'package:flutter/material.dart';
import 'dart:math';
import '../model/music.dart';
import 'dart:ui';
import '../components/bottom_player_bar.dart';
import '../components/inherited_demo.dart';
import 'lyric.dart';
import 'dart:async';
import './position_event.dart';
import './lyricNotifierData.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:event_bus/event_bus.dart';

class AlbumCover extends StatefulWidget {
  final Music music;

  const AlbumCover({Key key, this.music}) : super(key: key);

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
  StreamSubscription stream;
  PositionNotifierData vd = PositionNotifierData(Duration());
  AudioPlayer audioPlayer;
  double volumn = 0.5; // 音量控制
  bool showVolumnController = false;
  Duration position;
  Duration duration;
  double time = 0.0;
  StreamSubscription _positionSubscription;
  StreamSubscription _durationSubscription;
  StreamSubscription _playerErrorSubscription;

  initAudioPlayer() {
    audioPlayer = AudioPlayer();
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
      // vd.value =
      // print(p);
      // print(Duration().inMilliseconds);
      // _stream = Player.handleMusicPosFire(p);
      vd.value = p;
    });

    // 获取歌曲播放时间
    _durationSubscription = audioPlayer.onDurationChanged.listen((d) async {
      setState(() {
        duration = d;
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
  void initState() {
    super.initState();
    initAudioPlayer();

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
    vd.dispose();
    audioPlayer.dispose();

    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _playerErrorSubscription.cancel();
    controller_record.dispose();
    controller_needle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    final _music = store.player.current;

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
                        setState(() {
                          position = Duration(
                              milliseconds:
                                  (value * duration.inMilliseconds).round());
                          time = value;
                        });
                      },
                      complete: () {
                        setState(() {
                          duration = Duration(seconds: 0);
                          position = Duration(seconds: 0);
                          time = 0.0;
                        });
                      },
                      toggle: (String playmode) {
                        setState(() {
                          duration = Duration();
                          position = Duration();
                          time = 0.0;
                        });
                        switch (playmode) {
                          case 'prev':
                            store.playPrev();
                            Player.idEventBus.fire(store.player.current.id);
                            break;
                          case 'next':
                            store.playNext();
                            Player.idEventBus.fire(store.player.current.id);
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
          height: 250.0,
          width: 250.0,
          child: RotationTransition(
              turns: animation,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/play_disc.png'),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40.0,
                    top: 40.0,
                    // right: 0.0,
                    child: Container(
                      width: 170,
                      height: 170,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                        music.albumCoverImg,
                      )),
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
  SongidNotifierData songidNotifierData = SongidNotifierData(-1);

  GlobalKey _containerKey = GlobalKey();
  Size _containerSize = Size(0, 0);
  Offset _containerPosition = Offset(0, 0);
  StreamSubscription stream;

  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    print(
        'Size: width = ${containerSize.width} - height = ${containerSize.height}');
  }

  _getContainerPosition() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);
    print(
        'Position: x = ${containerPosition.dx} - y = ${containerPosition.dy}');
  }

  @override
  void initState() {
    widget.vd.addListener(() {
      lyricNotifierData.value = widget.vd.value;
    });
    stream = Player.idEventBus.on<int>().listen((int res) {
      songidNotifierData.value = res;
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
    stream.cancel();
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
                padding: EdgeInsets.only(top: 30.0),
                key: bottomChildKey,
                child: bottomChild,
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 30.0),
                key: topChildKey,
                child: topChild,
              ),
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
                      id: songidNotifierData,
                      songId: widget.music.id,
                      position: lyricNotifierData,
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
  final VoidCallback complete;
  const _ControllerBar({
    Key key,
    this.controllerRecord,
    this.controllerNeedle,
    this.position,
    this.duration,
    this.time,
    this.handleSlider,
    this.toggle,
    this.complete,
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
        play: () {
          controllerRecord.forward();
          controllerNeedle.forward();
        },
        pause: () {
          controllerRecord.stop(canceled: false);
          controllerNeedle.reverse();
        },
        complete: complete,
        toggle: (String playmode) {
          toggle(playmode);
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
            audioPlayer.release();
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
