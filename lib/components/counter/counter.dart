import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _PREF_KEY_RECENT_PLAY = "counter_recent_play";

const String _PREF_KEY_RADIO = "counter_radio";

const String _PREF_KEY_COLLECTION = "counter_collection";

class CounterControllerState {
  CounterControllerState({this.mvCount, this.artistCount});

  final int mvCount;
  final int artistCount;
}

class _InheritedStateContainer extends InheritedWidget {
  final CounterContainerState data;
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class CounterContainer extends StatefulWidget {
  final Widget child;
  final CounterControllerState counter;

  CounterContainer({
    @required this.child,
    this.counter,
  });

  static CounterContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  CounterContainerState createState() => new CounterContainerState();
}

class CounterContainerState extends State<CounterContainer> {
  CounterControllerState counter;

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
