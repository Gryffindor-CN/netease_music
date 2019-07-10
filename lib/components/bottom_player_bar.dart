import 'package:flutter/material.dart';
import '../model/music.dart';
import '../components/player.dart';
import '../components/inherited_demo.dart';
import 'package:audioplayers/audioplayers.dart';

class BottomPlayerBar extends StatefulWidget {
  final VoidCallback play;
  BottomPlayerBar({this.play});
  @override
  _BottomPlayerBarState createState() => _BottomPlayerBarState();
}

class _BottomPlayerBarState extends State<BottomPlayerBar> {
  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);

    return Material(
      color: Colors.transparent,
      child: Theme(
        data: Theme.of(context).copyWith(
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: Colors.white,
                )),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          decoration: BoxDecoration(color: Colors.transparent),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back, size: 30.0),
                onPressed: () {
                  store.playPrev();
                },
              ),
              IconButton(
                icon: Icon(Icons.play_circle_outline, size: 30.0),
                onPressed: () async {
                  print(store.player.current.songUrl);
                  int result =
                      await audioPlayer.play(store.player.current.songUrl);
                  widget.play();
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward, size: 30.0),
                onPressed: () {
                  store.playNext();
                },
              ),
              IconButton(
                icon: Icon(Icons.shuffle, size: 30.0),
                onPressed: () {
                  store.switchPlayMode();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
