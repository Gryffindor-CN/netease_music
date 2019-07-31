import 'package:flutter/material.dart';

class FlexibleDetailBar extends StatelessWidget {
  final Widget background;
  final Widget content;
  final Widget Function(BuildContext context, double t) builder;

  FlexibleDetailBar({Key key, this.background, this.content, this.builder})
      : super(key: key);

  static double percentage(BuildContext context) {
    _FlexibleDetail value =
        context.inheritFromWidgetOfExactType(_FlexibleDetail);
    assert(value != null, 'ooh , can not find');
    return value.t;
  }

  Widget build(BuildContext context) {
    List<Widget> _widgetList = [];
    final FlexibleSpaceBarSettings settings =
        context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);
    final double deltaExtent = settings.maxExtent - settings.minExtent;
    final double t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);
    double bottomPadding = 0;
    SliverAppBar sliverBar = context.ancestorWidgetOfExactType(SliverAppBar);
    if (sliverBar != null && sliverBar.bottom != null) {
      bottomPadding = sliverBar.bottom.preferredSize.height;
    }

    _widgetList.add(Positioned(
        top: -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t),
        left: 0,
        right: 0,
        height: settings.maxExtent,
        child: background));

    _widgetList.add(Positioned(
      top: settings.currentExtent - settings.maxExtent,
      left: 0,
      right: 0,
      height: settings.maxExtent,
      child: Opacity(
        opacity: 1 - t,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: content,
        ),
      ),
    ));

    _widgetList.add(Column(
      children: <Widget>[builder(context, t)],
    ));

    return _FlexibleDetail(
      t,
      child: ClipRect(
        child: Stack(
          children: _widgetList,
          fit: StackFit.expand,
        ),
      ),
    );
  }
}

class _FlexibleDetail extends InheritedWidget {
  final double t;

  _FlexibleDetail(this.t, {Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(_FlexibleDetail oldWidget) {
    return t != oldWidget.t;
  }
}
