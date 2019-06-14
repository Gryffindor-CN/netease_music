import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 类似于 [FlexibleSpaceBar]
class FlexibleDetailBar extends StatelessWidget {
  final Widget content;

  final Widget background;

  final Widget Function(BuildContext context, double t) builder;

  const FlexibleDetailBar({
    Key key, 
    @required this.content,
    @required this.background, 
    this.builder, 
    }) : assert(content != null),
        assert(background != null),
        super(key: key);

  static double percentage(BuildContext context) {
    _FlexibleDetail value = context.inheritFromWidgetOfExactType(_FlexibleDetail);
    assert(value != null, 'ooh, can not find');
    return value.t;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    /// 查找 [FlexibleSpaceBarSettings] 类型
    // final FlexibleSpaceBarSettings settings = context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);
    // final double deltaExtent = settings.maxExtent - settings.minExtent;
    // final double t = (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent).clamp(0.0, 1.0);
    final double deltaExtent = 230;
    final double t = 0.0;

    // 背景添加视差滚动效果
    children.add(Positioned(
      top: -Tween<double>(
        begin: 0.0, 
        end: deltaExtent / 4.0,
      ).transform(t),
      left: 0,
      right: 0,
      height: 360.0,
      child: background,
    ));

    double bottomPadding = 0;
    SliverAppBar sliverBar = context.ancestorWidgetOfExactType(SliverAppBar);
    if (sliverBar != null && sliverBar.bottom != null) {
      bottomPadding = sliverBar.bottom.preferredSize.height;
    }
    
    children.add(Positioned(
      top: 360.0 - 0.0,
      left: 0,
      right: 0,
      height: 360.0,
      child: Opacity(
        opacity: 1 - t,
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding),
          child: content,
        ),
      ),
    ));

    if (builder != null) {
      children.add(
        Column(
          children: <Widget>[builder(context, t)],
        ),
      );
    }

    // 矩形裁剪 Widget
    return _FlexibleDetail(
      t,
      child: ClipRect(
        child: Stack(
          children: children,
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
    return t != oldWidget;
  }
}