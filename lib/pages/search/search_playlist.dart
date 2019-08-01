import 'package:flutter/material.dart';
import 'package:netease_music/repository/netease.dart';
import '../../model/music.dart';
import './playlist_section.dart';

class SearchPlaylistTab extends StatefulWidget {
  final String keyword;
  SearchPlaylistTab({@required this.keyword});
  @override
  SearchPlaylistTabState createState() => SearchPlaylistTabState();
}

class SearchPlaylistTabState extends State<SearchPlaylistTab>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  List<PlayList> playlist = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      _getPlaylist(widget.keyword);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (this.mounted) {
      // _getPlaylist(widget.keyword);
    }
  }

  void _getPlaylist(String keyword) async {
    var plays = await NeteaseRepository.getSearchPlaylist(keyword);
    if (this.mounted) {
      setState(() {
        plays.asMap().forEach((int index, item) {
          playlist.add(PlayList(
            name: item['name'],
            id: item['id'],
            coverImgUrl: item['coverImgUrl'],
            playCount: item['playCount'],
            trackCount: item['trackCount'],
            creatorName: item['creator']['nickname'],
          ));
        });
      });
      if (playlist.length == plays.asMap().length) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ))
        : playlist.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '暂无歌单信息',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle.color),
                  ),
                ))
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: PlaylistSection(widget.keyword, playlist),
                ),
              );
  }
}
