import 'package:flutter/material.dart';
import '../components/player.dart';
import '../model/music.dart';

class ValueNotifierData extends ValueNotifier<PlayerControllerState> {
  ValueNotifierData(value) : super(value);
}

class PlayerControllerState {
  PlayerControllerState({this.current, this.playMode, this.playingList});
  final Music current;
  final List<Music> playingList;
  final PlayMode playMode;
}

enum PlayMode {
  ///aways play single song
  single,

  ///play current list sequence
  sequence,

  ///random to play next song
  shuffle
}
