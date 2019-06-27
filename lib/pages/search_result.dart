import 'package:flutter/material.dart';
import 'package:netease_music/components/tab_navigator.dart';
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
  final String aritstName;
  final int aritstId;
  final String albumName;
  final int albumId;
  Music(
      {@required this.name,
      this.id,
      this.aritstName,
      this.aritstId,
      this.albumName,
      this.albumId});
}

class PlayList {
  final String name;
  final int id;
  final String coverImgUrl;
  final int playCount;
  final int trackCount;
  final String creatorName;
  PlayList(
      {@required this.name,
      this.id,
      this.coverImgUrl,
      this.playCount,
      this.trackCount,
      this.creatorName});
}

class SearchResultState extends State<SearchResult>
    with TickerProviderStateMixin {
  List<Music> songs = [];
  List<PlayList> playlist = [];
  TabController _tabController;
  List<Widget> _viewWidget = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 8);
    _doSearchSingAlbum(widget.keyword);
    _doSearchPlaylist(widget.keyword);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _doSearchSingAlbum(String keyword) async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/search?keywords=$keyword&limit=5");
      var songRes = json.decode(response.toString())['result']['songs'];
      setState(() {
        songRes.asMap().forEach((int index, item) {
          songs.add(Music(
              name: item['name'],
              id: item['id'],
              aritstName: item['artists'][0]['name'],
              aritstId: item['artists'][0]['id'],
              albumName: item['album']['name'],
              albumId: item['album']['id']));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void _doSearchPlaylist(String keyword) async {
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
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _viewWidget = [
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 350.0,
              child: Album(
                songs,
                tabController: _tabController,
              ),
            ),
            Container(
              height: 500.0,
              child: Playlist(
                playlist,
                tabController: _tabController,
              ),
            )
          ],
        ),
      ),
      Text('单曲'),
      Text('视频'),
      Text('歌手'),
      Text('专辑'),
      Text('歌单'),
      Text('主播电台'),
      Text('用户'),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
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
                        child: Text(
                          widget.keyword,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.black26,
                        size: 16.0,
                      ),
                      onPressed: () {})
                ]),
          ),
        ),
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 1.0,
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
      body: TabBarView(
        controller: _tabController,
        children: _viewWidget,
      ),
    );
  }
}

class Album extends StatelessWidget {
  final List<Music> songList;
  final TabController tabController;
  Album(this.songList, {this.tabController});

  List<Widget> _buildWidget() {
    List<Widget> widgetList = [];
    songList.asMap().forEach((int index, Music item) {
      widgetList.add(InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 1.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            item.name,
                            style: TextStyle(
                                fontSize: 14.0, color: Color(0xff0c73c2)),
                          ),
                        ),
                        DefaultTextStyle(
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                item.aritstName,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text('-'),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                item.albumName,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ));
    });
    widgetList.add(Row(
      children: <Widget>[
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0))),
            child: InkResponse(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: tabController != null
                    ? () {
                        tabController.animateTo(1);
                      }
                    : null,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0)),
                        child: Text(
                          '播放全部',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: () {
                          print('play all');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '单曲',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(
          width: 15.0,
        )
      ],
    ));
    return widgetList.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(),
    );
  }
}

class Playlist extends StatelessWidget {
  final List<PlayList> playList;
  final TabController tabController;
  Playlist(this.playList, {this.tabController});

  List<Widget> _buildWidget() {
    print(playList);
    List<Widget> widgetList = [];
    playList.asMap().forEach((int index, PlayList item) {
      widgetList.add(InkWell(
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
                    width: 60.0,
                    height: 60.0,
                    margin: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        child: Image.network(
                          item.coverImgUrl,
                        )),
                  ),
                  Container(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 260.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 4.0),
                                child: Text(
                                  item.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 10.0, color: Color(0xFFBDBDBD)),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '${item.trackCount}首音乐',
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text('by ${item.creatorName}'),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Text('播放${item.playCount}次'),
                                  ],
                                ),
                              )
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
      ));
    });
    widgetList.add(Row(
      children: <Widget>[
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1.0))),
            child: InkResponse(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: tabController != null
                    ? () {
                        tabController.animateTo(5);
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '歌单',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    )
                  ],
                )),
          ),
        ),
        SizedBox(
          width: 15.0,
        )
      ],
    ));
    return widgetList.reversed.toList();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(),
    );
  }
}
