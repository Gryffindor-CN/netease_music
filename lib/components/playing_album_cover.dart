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
  Duration _position;
  PositionNotifierData vd = PositionNotifierData(Duration());

  @override
  void initState() {
    super.initState();

    stream = Player.eventBus.on<Duration>().listen((e) {
      vd.value = e;
    });

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

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _BlurBackground(
            music: store.player.current,
          ),
          Material(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                _PlayingTitle(music: _music),
                Expanded(
                  child: _CenterSection(
                    vd: vd,
                    position: _position,
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
                  store: store,
                  controllerNeedle: controller_needle,
                  controllerRecord: controller_record,
                )
              ],
            ),
          ),
        ],
      ),
    );
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
  const _CenterSection({
    Key key,
    this.rotateTween,
    this.commonTween,
    this.controllerRecord,
    this.controllerNeedle,
    this.position,
    this.vd,
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
    print(
        'Size: width = ${containerSize.width} - height = ${containerSize.height}');
  }

  /// New
  _getContainerPosition() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);
    print(
        'Position: x = ${containerPosition.dx} - y = ${containerPosition.dy}');
  }

  initState() {
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
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        key: _containerKey,
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height: 400.0,
        // decoration: BoxDecoration(color: Colors.red),
        child: AnimatedCrossFade(
          crossFadeState:
              _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
              Key bottomChildKey) {
            return Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Center(
                  key: bottomChildKey,
                  child: bottomChild,
                ),
                Center(
                  key: topChildKey,
                  child: topChild,
                ),
              ],
            );
          },
          duration: Duration(milliseconds: 300),
          firstChild: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              GestureDetector(
                onTap: () {
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
                child: Container(
                    padding: EdgeInsets.only(left: 80.0),
                    child: PivotTransition(
                      turns:
                          widget.rotateTween.animate(widget.controllerNeedle),
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
                  setState(() {
                    _first = true;
                  });
                },
                child: (widget.vd.value != null &&
                        widget.vd.value.inMilliseconds > 0)
                    ? Lyric(
                        songId: widget.music.id,
                        data: lyricNotifierData,
                      )
                    : Text('')),
          ),
        ),
      ),
    );
  }
}

class _ControllerBar extends StatelessWidget {
  final AnimationController controllerRecord;
  final AnimationController controllerNeedle;
  final StateContainerState store;
  const _ControllerBar({
    Key key,
    this.controllerRecord,
    this.controllerNeedle,
    @required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomPlayerBar(play: () {
      controllerRecord.forward();
      controllerNeedle.forward();
    }, pause: () {
      controllerRecord.stop(canceled: false);
      controllerNeedle.reverse();
    }, finish: (String playmode) {
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

  const _PlayingTitle({Key key, @required this.music}) : super(key: key);

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
          onPressed: () => Navigator.pop(context)),
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
