import 'package:flutter/material.dart';
import '../router/Routes.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class SearchResult extends StatefulWidget {
  final String keyword;
  SearchResult(this.keyword);

  @override
  SearchResultState createState() => SearchResultState();
}

class Music {
  final String name;
  final int id;

  Music({@required this.name, this.id});
}

class Video {
  final String name;
  final int id;

  Video({@required this.name, this.id});
}

class SearchResultState extends State<SearchResult>
    with TickerProviderStateMixin {
  List<Music> songs = [];
  List<Video> videos = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 8);
    // _doSearchSingAlbum(widget.keyword);
    // _doSearchVideo(widget.keyword);
  }

  void _doSearchSingAlbum(String keyword) async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/search/keywords=$keyword&limit=5");
      var songs = json.decode(response.toString())['result']['songs'];
    } catch (e) {
      print(e);
    }
  }

  void _doSearchVideo(String keyword) async {
    try {
      Response response = await Dio().get(
          "http://192.168.206.133:3000/search/keywords=$keyword&type=1014&limit=5");
      var videos = json.decode(response.toString())['result']['videos'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Routes.router.navigateTo(context,
                Uri.encodeFull('/home/searchpage?keyword=${widget.keyword}'));
          },
          splashColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 20.0,
            height: 36.0,
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: Colors.white24,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 2.0),
                        child: Text(widget.keyword),
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.cancel, color: Colors.black26),
                      onPressed: () {})
                ]),
          ),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: <Widget>[
            Text('综合'),
            Text('单曲'),
            Text('视频'),
            Text('歌手'),
            Text('专辑'),
            Text('歌单'),
            Text('主播电台'),
            Text('用户')
          ],
        ),
      ),
    );
  }
}
