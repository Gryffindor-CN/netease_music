import 'package:flutter/material.dart';
import 'package:netease_music/model/music.dart';
import '../../repository/netease.dart';
import '../../components/album_item.dart';

class SearchAlbumTab extends StatefulWidget {
  final String keyword;
  SearchAlbumTab({@required this.keyword});
  @override
  SearchAlbumTabState createState() => SearchAlbumTabState();
}

class SearchAlbumTabState extends State<SearchAlbumTab>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  List<Album> albumlist = [];
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (this.mounted) {
      _getAlbums(widget.keyword);
    }
  }

  void _getAlbums(String keyword) async {
    var albums = await NeteaseRepository.getSearchAlbum(keyword);
    if (this.mounted) {
      setState(() {
        albums.asMap().forEach((int index, item) {
          albumlist.add(Album(
            name: item['name'],
            id: item['id'],
            coverImageUrl: item['picUrl'],
            publishTime: item['publishTime'],
            size: item['size'],
          ));
        });
      });
      if (albumlist.length == albums.asMap().length) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Widget> _buildContent(List<Album> albums) {
    List<Widget> _widgetList = [];
    albums.asMap().forEach((int index, album) {
      _widgetList.add(AlbumItem(album, context, onTap: () {}));
    });
    return _widgetList;
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
        : albumlist.length == 0
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
                  child: Column(
                    children: _buildContent(albumlist),
                  ),
                ),
              );
  }
}
