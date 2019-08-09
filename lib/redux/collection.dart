import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/music.dart';

const String _RECENT_PLAY_COUNT = 'recent_play_count';

class Collection {
  int myCollection;
  int myRadio;
  int myLocal;
  int recentPlay;

  Collection({int myCollection, int myRadio, int myLocal, int recentPlay}) {
    this.myCollection = myCollection;
    this.myRadio = myRadio;
    this.myLocal = myLocal;
    this.recentPlay = recentPlay;
  }
  static Future<Collection> initial() async {
    List<Music> _playingList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    if (prefs.get(_RECENT_PLAY_COUNT) != null) {
      _playingList = (json.decode(prefs.get(_RECENT_PLAY_COUNT)) as List)
          .cast<Map>()
          .map(Music.fromMap)
          .toList();
    }
    return Collection(
        myCollection: 0,
        myRadio: 0,
        myLocal: 0,
        recentPlay: _playingList.length);
  }
}
