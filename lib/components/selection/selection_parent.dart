import 'package:flutter/material.dart';

class SelectionShareDataWidget extends InheritedWidget {
  SelectionShareDataWidget({@required this.isSelectAll, Widget child})
      : super(child: child);
  final bool isSelectAll;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static SelectionShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(SelectionShareDataWidget);
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(SelectionShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.isSelectAll != isSelectAll;
  }
}
