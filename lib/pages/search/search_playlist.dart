import 'package:flutter/material.dart';
import '../../model/music.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:math';

class SearchPlaylistTab extends StatefulWidget {
  final String keyword;
  SearchPlaylistTab({@required this.keyword});
  @override
  SearchPlaylistTabState createState() => SearchPlaylistTabState();
}

class SearchPlaylistTabState extends State<SearchPlaylistTab> {
  bool _isLoading = true;
  List<PlayList> playlist = [];
  @override
  void initState() {
    super.initState();
    _getPlaylist(widget.keyword);
  }

  void _getPlaylist(String keyword) async {
    try {
      Response response = await Dio().get(
          "http://192.168.206.133:3000/search?keywords=$keyword&type=1000&limit=5");
      var plays = json.decode(response.toString())['result']['playlists'];
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
    } catch (e) {
      print(e);
    }
  }

  Widget _buildWidget(PlayList item) {
    String _keyword = widget.keyword;
    Widget _nameWidget;

    if (item.name.contains(_keyword)) {
      var startIndex = item.name.indexOf(_keyword);
      var itemNameLen = item.name.length;
      var keywordLen = _keyword.length;
      _nameWidget = DefaultTextStyle(
        style: TextStyle(
          fontSize: 15.0,
          color: Colors.black,
        ),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          text: TextSpan(
            text: item.name.substring(0, startIndex),
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(
                  text: _keyword, style: TextStyle(color: Color(0xff0c73c2))),
              TextSpan(
                  text:
                      item.name.substring(startIndex + keywordLen, itemNameLen),
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
      );
    } else {
      _nameWidget = DefaultTextStyle(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        child: Text(
          item.name,
        ),
      );
    }

    return InkWell(
      onTap: () {},
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 45.0,
                  height: 45.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: Image.network(
                        item.coverImgUrl,
                      )),
                ),
                Container(
                  width: 250.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _nameWidget,
                      DefaultTextStyle(
                        style:
                            TextStyle(fontSize: 10.0, color: Color(0xFFBDBDBD)),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${item.trackCount}首音乐',
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text('by ${item.creatorName}'),
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                                '播放${((item.playCount / 10000) * (pow(10, 1))).round() / (pow(10, 1))}万次'),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
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
            : ListView.builder(
                itemCount: playlist.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildWidget(playlist[index]);
                },
              );
  }
}