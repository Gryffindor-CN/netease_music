import 'package:flutter/material.dart';
import '../../model/playlist_detail.dart';
import '../../model/music.dart';
import './music_list.dart';
import '../../components/music/music_item.dart';

class PlaylistInternalSearchDelegate extends SearchDelegate {
  PlaylistInternalSearchDelegate(this.playlist, this.theme);

  final PlaylistDetail playlist;
  final ThemeData theme;
  List<Music> get list => playlist.musics;

  @override
  ThemeData appBarTheme(BuildContext context) {
    var theme = this.theme ?? Theme.of(context);
    return theme.copyWith(
        textTheme:
            theme.textTheme.copyWith(title: theme.primaryTextTheme.title),
        primaryColorBrightness: Brightness.dark);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Theme(data: theme, child: buildSection(context));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  Widget buildSection(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    var result = list
        ?.where((m) => m.name.contains(query) || m.subTitle.contains(query))
        ?.toList();
    if (result == null || result.isEmpty) {
      return _EmptyResultSection(query);
    }
    return _InternalResultSection(musics: result);
  }
}

class _EmptyResultSection extends StatelessWidget {
  const _EmptyResultSection(this.query);

  final String query;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      child: Center(
        child: Text('未找到与"$query"相关的内容'),
      ),
    );
  }
}

class _InternalResultSection extends StatelessWidget {
  const _InternalResultSection({Key key, this.musics}) : super(key: key);

  ///result song list, can not be null and empty
  final List<Music> musics;

  @override
  Widget build(BuildContext context) {
    return MusicTitle(
      musics,
    );
  }
}
