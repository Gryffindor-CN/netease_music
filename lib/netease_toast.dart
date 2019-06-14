import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter/widgets.dart';

class ToastContainer extends AnimatedWidget {
  ToastContainer({Key key, Animation<double> animation, @required this.child})
      : super(key: key, listenable: animation);

  final Widget child;

  static final _showTween = new Tween<double>(begin: -80.0, end: 2.0);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Stack(
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
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: Colors.black87,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          child: Text('已为你推荐新的个性化内容')),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NeteaseToast extends StatefulWidget {
  NeteaseToast({@required this.child, @required this.showToast});
  final Widget child;
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
        AnimationController(duration: Duration(milliseconds: 360), vsync: this);

    animation = new CurvedAnimation(parent: controller, curve: Curves.linear);

    controller.forward();

    // Future.delayed(
    //   Duration(milliseconds: 2000),
    //   () {
    //     controller.reverse();
    //     // entry.dismiss();
    //   },
    // );
  }

  Widget build(BuildContext context) {
    if (widget.showToast == true) {
      controller.forward();
      Future.delayed(
        Duration(milliseconds: 2000),
        () {
          controller.reverse();
          // entry.dismiss();
        },
      );
    }
    return ToastContainer(
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

class NeteaseOverlay {
  NeteaseOverlay(this.context);
  final BuildContext context;
  static NotificationEntry entry;

  showToast() {
    entry = showOverlay(context, (_, t) {
      return Theme(
        data: Theme.of(context),
        child: Opacity(
          opacity: t,
          child: NeteaseToast(),
        ),
      );
    }, duration: Duration.zero);
  }
}
