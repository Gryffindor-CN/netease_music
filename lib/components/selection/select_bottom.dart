import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class SelectBottomTabs extends AnimatedWidget {
  SelectBottomTabs({Key key, Animation<double> animation, this.child})
      : super(key: key, listenable: animation);
  static final _posAnimation = new Tween<double>(begin: -1000, end: 0.0);

  final Widget child;
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Positioned(
      width: MediaQuery.of(context).size.width,
      height: 70.0,
      left: 0,
      bottom: _posAnimation.evaluate(animation),
      child: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xffd4d4d4))),
            color: Color(0xfffafafa)),
        child: child,
      ),
    );
  }
}

class SelectBottom extends StatefulWidget {
  SelectBottom({@required this.child});
  final Widget child;
  @override
  SelectBottomState createState() => SelectBottomState();
}

class SelectBottomState extends State<SelectBottom>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
  }

  Widget build(BuildContext context) {
    return SelectBottomTabs(animation: animation, child: widget.child);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
