import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToastContainer extends AnimatedWidget {
  ToastContainer(
      {Key key,
      Animation<double> animation,
      @required this.child,
      @required this.toastText})
      : super(key: key, listenable: animation);

  final Widget child;
  final String toastText;

  static final _showTween = new Tween<double>(begin: -80.0, end: 2.0);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        children: <Widget>[
          child,
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: _showTween.evaluate(animation),
            child: SafeArea(
              child: DefaultTextStyle(
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 14,
                            ),
                            child: Text(toastText)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NeteaseToast extends StatefulWidget {
  NeteaseToast(
      {@required this.child,
      @required this.showToast,
      @required this.toastText});
  final Widget child;
  final String toastText;
  final bool showToast;

  @override
  _NeteaseToastState createState() => new _NeteaseToastState();
}

class _NeteaseToastState extends State<NeteaseToast>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);

    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);
  }

  Widget build(BuildContext context) {
    if (widget.showToast == true) {
      controller.forward();
      Future.delayed(
        Duration(milliseconds: 1600),
        () {
          controller.reverse();
        },
      );
    }
    return ToastContainer(
      toastText: widget.toastText,
      child: widget.child,
      animation: animation,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
