import 'package:flutter/material.dart';
import '../model/music.dart';
import '../components/player.dart';

class MusicItem extends StatelessWidget {
  final ValueNotifierData vd = ValueNotifierData(PlayerControllerState(
      current: Music(name: '1', id: 1),
      playMode: PlayMode.sequence,
      playingList: [
        Music(name: '1', id: 1),
        Music(name: '2', id: 2),
        Music(name: '3', id: 3),
        Music(name: '4', id: 4),
        Music(name: '5', id: 5),
        Music(name: '6', id: 6),
        Music(name: '7', id: 7),
        Music(name: '8', id: 8),
      ]));

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('add'),
      onPressed: () {
        print(vd.value.current.name);
      },
    );
  }
}
