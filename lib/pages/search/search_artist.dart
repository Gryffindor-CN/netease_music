import 'package:flutter/material.dart';
import '../../repository/netease.dart';
import '../../model/music.dart';
import '../artist/artist_page.dart';

class SearchArtistTab extends StatefulWidget {
  SearchArtistTab(this.keyword, {this.id});
  final String keyword;
  final int id;

  @override
  SearchArtistTabState createState() => SearchArtistTabState();
}

class SearchArtistTabState extends State<SearchArtistTab>
    with AutomaticKeepAliveClientMixin {
  int artistCount = 1;
  List<Artist> artists = [];
  bool _isLoading = true;
  int offset = 0;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getArtists();
  }

  Future<void> _getArtists() async {
    setState(() {
      _isLoading = true;
    });
    var _len = artists.length;
    var result =
        await NeteaseRepository.getArtists(widget.keyword, offset: offset);
    if (this.mounted) {
      setState(() {
        artistCount = result['artistCount'];
        result['artists'].asMap().forEach((int index, artist) {
          artists.add(Artist(
              id: artist['id'],
              name: artist['name'],
              alias: artist['alias'],
              imageUrl: artist['img1v1Url']));
        });
        if (artists.length == _len + result['artists'].length) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> _widgetlist = [];
    artists
      ..asMap().forEach((int index, item) {
        _widgetlist.add(InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ArtistPage(item.id);
            }));
          },
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(backgroundImage: NetworkImage(item.imageUrl)),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        item.name,
                        style: TextStyle(color: Color(0xff0c73c2)),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      item.alias.length > 0
                          ? Text('（${item.alias[0]}）')
                          : Text('')
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      });

    return _widgetlist;
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
        : artists.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '暂无歌手记录',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle.color),
                  ),
                ))
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: _buildContent(context),
                    ),
                  ),
                ),
              );
  }
}
