import 'package:flutter/material.dart';
import 'dart:math';
import '../model/music.dart';
import 'dart:ui';
import '../components/bottom_player_bar.dart';
import '../components/inherited_demo.dart';

class AlbumCover extends StatefulWidget {
  final Music music;

  const AlbumCover({Key key, this.music}) : super(key: key);

  @override
  State createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> with TickerProviderStateMixin {
  final _commonTween = new Tween<double>(begin: 0.0, end: 1.0);
  final _rotateTween = new Tween<double>(begin: -0.15, end: 0.0);
  AnimationController controller_record;
  Animation<double> animation_record;
  AnimationController controller_needle;
  Animation<double> animation_neddle;

  @override
  void initState() {
    super.initState();
    controller_record = new AnimationController(
        duration: const Duration(milliseconds: 15000), vsync: this);
    animation_record =
        new CurvedAnimation(parent: controller_record, curve: Curves.linear);

    controller_needle = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

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
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);

    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  // widget.music.albumCoverImg,
                  store.player.current.albumCoverImg),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black54,
                BlendMode.overlay,
              ),
            ),
          ),
        ),
        Container(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
          child: Opacity(
            opacity: 0.6,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
          ),
        )),
        Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  child: PivotTransition(
                    turns: _rotateTween.animate(controller_needle),
                    alignment: FractionalOffset.topLeft,
                    child: Container(
                      width: 100.0,
                      child: Image.asset("assets/play_needle.png"),
                    ),
                  ),
                ),
                RotateRecord(
                    music: store.player.current,
                    animation: _commonTween.animate(controller_record)),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: BottomPlayerBar(
            play: () {
              controller_record.forward();
              controller_needle.forward();
            },
          ),
        )
      ],
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
          height: 300.0,
          width: 300.0,
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
                    left: 50.0,
                    top: 50.0,
                    // right: 0.0,
                    child: Container(
                      width: 200,
                      height: 200,
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
