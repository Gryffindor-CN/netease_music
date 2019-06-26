import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AnimatedLogo extends AnimatedWidget {
  AnimatedLogo({Key key, Animation<double> animation, this.iconData})
      : super(key: key, listenable: animation);

  // finalAnimation<double> icon_animation;
  // finalAnimation<double> wrap_animation;
  static final _wrapTween = new Tween<double>(begin: 23.0, end: 24.0);
  // static final _iconTween = new Tween<double>(begin: 18.0, end: 18.0);

  final IconData iconData;

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: Theme.of(context).iconTheme.copyWith(
                color: Color(0xffffffff),
              )),
      child: Stack(
        children: <Widget>[
          Container(
            width: 24.0,
            height: 24.0,
            decoration: BoxDecoration(
                color: Colors.transparent, shape: BoxShape.circle),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              alignment: Alignment.center,
              width: _wrapTween.evaluate(animation),
              height: _wrapTween.evaluate(animation),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle),
              child: Icon(
                iconData,
                size: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  LogoApp(this.iconData);
  final IconData iconData;
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  AnimationController controller;
  // Animation<double> icon_animation;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 40), vsync: this);
    // wrap_animation = new Tween(begin: 0.0, end: 26.0).animate(controller);
    // icon_animation = new Tween(begin: 0.0, end: 18.0).animate(controller);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new AnimatedLogo(animation: animation, iconData: widget.iconData);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
