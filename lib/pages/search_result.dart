import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
import '../router/Routes.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import '../components/song_detail_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../components/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

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
  final Map<String, dynamic> detail;
  final int commentCount;
  final String songUrl;
  Music(
      {@required this.name,
      this.id,
      this.aritstName,
      this.aritstId,
      this.albumName,
      this.albumId,
      this.detail,
      this.commentCount,
      this.songUrl});
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
  List<Music> songs = []; // 单曲
  List<PlayList> playlist = []; // 歌单
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

  // 获取单曲
  void _doSearchSingAlbum(String keyword) async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/search?keywords=$keyword&limit=5");
      var songRes = json.decode(response.toString())['result']['songs'];

      songRes.asMap().forEach((int index, item) async {
        var res = await getSongDetail(item['id']);
        setState(() {
          songs.add(
            Music(
                name: item['name'],
                id: item['id'],
                aritstName: item['artists'][0]['name'],
                aritstId: item['artists'][0]['id'],
                albumName: item['album']['name'],
                albumId: item['album']['id'],
                detail: res['detail'],
                commentCount: res['commentCount']),
          );
        });
      });
    } catch (e) {
      print(e);
    }
  }

  // 获取歌单
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

// 获取单曲详情
  getSongDetail(int id) async {
    Map<String, dynamic> songDetail = {};
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/song/detail?ids=$id");
      var result = json.decode(response.toString());
      await getSongComment(id).then((data) {
        songDetail.addAll(
            {'detail': result['songs'][0], 'commentCount': data['total']});
      });
      return songDetail;
    } catch (e) {
      print(e);
    }
  }

  // 获取歌曲论数量
  getSongComment(int id) async {
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/comment/music?id=$id");
      var result = json.decode(response.toString());
      return result;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _viewWidget = [
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: (this.songs.length == 0 || this.playlist.length == 0)
            ? Center(
                child: Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Album(
                      widget.keyword,
                      songs,
                      tabController: _tabController,
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    child: Playlist(
                      widget.keyword,
                      playlist,
                      tabController: _tabController,
                    ),
                  )
                ],
              ),
      ),
      Center(child: Text('单曲')),
      Center(child: Text('视频')),
      Center(child: Text('歌手')),
      Center(child: Text('专辑')),
      Center(child: Text('歌单')),
      Center(child: Text('主播电台')),
      Center(child: Text('用户')),
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
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.white24,
                          ),
                          Container(
                            width: 200.0,
                            padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 2.0),
                            child: Text(
                              widget.keyword,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14.0),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Flexible(
                      child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.black26,
                            size: 16.0,
                          ),
                          onPressed: () {
                            Routes.router
                                .navigateTo(context, '/home/searchpage');
                          }))
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
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: TabBarView(
          controller: _tabController,
          children: _viewWidget,
        ),
      ),
    );
  }
}

// 单曲
class Album extends StatelessWidget {
  final String keyword;
  final List<Music> songList;
  final TabController tabController;

  Album(
    this.keyword,
    this.songList, {
    this.tabController,
  });
  static Widget _nameWidget;
  static Widget _albumnameWidget;

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/song/url?id=$id");
      var data = json.decode(response.toString())['data'][0];
      return data['url'];
    } catch (e) {}
  }

  List<Widget> _buildWidget(BuildContext context) {
    List<Widget> widgetList = [];
    songList.asMap().forEach((int index, Music item) {
      if (item.name.contains(keyword)) {
        var _startIndex = item.name.indexOf(keyword);
        var _itemNameLen = item.name.length;
        var _keywordLen = keyword.length;
        _nameWidget = DefaultTextStyle(
          style: TextStyle(fontSize: 14.0, color: Colors.black),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              text: item.name.substring(0, _startIndex),
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: keyword, style: TextStyle(color: Color(0xff0c73c2))),
                TextSpan(
                    text: item.name
                        .substring(_startIndex + _keywordLen, _itemNameLen),
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        );
      } else {
        _nameWidget = DefaultTextStyle(
          style: TextStyle(fontSize: 14.0, color: Colors.black),
          child: Text(
            item.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      }

      if (item.albumName.contains(keyword)) {
        var _startIndex = item.albumName.indexOf(keyword);
        var _itemNameLen = item.albumName.length;
        var _keywordLen = keyword.length;

        _albumnameWidget = RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            text: item.name.substring(0, _startIndex),
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: keyword, style: TextStyle(color: Color(0xff0c73c2))),
              TextSpan(
                  text: item.albumName
                      .substring(_startIndex + _keywordLen, _itemNameLen)),
            ],
          ),
        );
      } else {
        _albumnameWidget =
            Text(item.albumName, maxLines: 1, overflow: TextOverflow.ellipsis);
      }
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 7,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.0),
                              child: _nameWidget,
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
                                  Flexible(
                                    child: _albumnameWidget,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: ListTail(
                        tails: [
                          {
                            'iconData': Icons.play_circle_outline,
                            'iconPress': () {}
                          },
                          {
                            'iconData': Icons.more_vert,
                            'iconPress': () async {
                              var detail = item.detail;
                              var commentCount = item.commentCount;
                              var res = await _getSongUrl(detail['id']);
                              detail['songUrl'] = res;
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SongDetailDialog(
                                        detail['name'],
                                        detail['al']['name'],
                                        detail['ar'][0]['name'],
                                        detail['al']['picUrl'],
                                        detail['alia'].length == 0
                                            ? ''
                                            : '（${detail['alia'][0]}）',
                                        [
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'playcircleo'),
                                            'title': '下一首播放',
                                            'callback': null
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'plussquareo'),
                                            'title': '收藏到歌单',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'download'),
                                            'title': '下载',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'message1'),
                                            'title': '评论($commentCount)',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'sharealt'),
                                            'title': '分享',
                                            'callback': () {
                                              // Navigator.of(context).pop();
                                              // // BottomShare.showBottomShare(
                                              // //     context);
                                              // BottomShare.showBottomShare(
                                              //     context);
                                              var model =
                                                  fluwx.WeChatShareMusicModel(
                                                title:
                                                    '${detail['name']}（${detail['al']['name']}）}',
                                                description:
                                                    '${detail['ar'][0]['name']}',
                                                transaction: "music",
                                                musicUrl: detail['songUrl'],
                                              );

                                              fluwx.share(model);
                                            }
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'adduser'),
                                            'title':
                                                '歌手：${detail['ar'][0]['name']}',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'adduser'),
                                            'title':
                                                '专辑：${detail['al']['name']}',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'youtube'),
                                            'title': '查看视频',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData(
                                                    'barchart'),
                                            'title': '人气榜应援',
                                            'callback': () {}
                                          },
                                          {
                                            'leadingIcon':
                                                AntDesign.getIconData('delete'),
                                            'title': '删除',
                                            'callback': () {}
                                          }
                                        ]);
                                  });
                            }
                          }
                        ],
                      ),
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
    widgetList.insert(
        0,
        Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 1.0))),
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
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
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
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(context),
    );
  }
}

// 歌单
class Playlist extends StatelessWidget {
  final String keyword;
  final List<PlayList> playList;
  final TabController tabController;
  Playlist(this.keyword, this.playList, {this.tabController});
  static Widget _nameWidget;

  List<Widget> _buildWidget() {
    List<Widget> widgetList = [];
    playList.asMap().forEach((int index, PlayList item) {
      if (item.name.contains(keyword)) {
        var startIndex = item.name.indexOf(keyword);
        var itemNameLen = item.name.length;
        var keywordLen = keyword.length;
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
                    text: keyword, style: TextStyle(color: Color(0xff0c73c2))),
                TextSpan(
                    text: item.name
                        .substring(startIndex + keywordLen, itemNameLen),
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
                    width: 250.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _nameWidget,
                        DefaultTextStyle(
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFFBDBDBD)),
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
      ));
    });
    widgetList.insert(
        0,
        Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
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
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
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
    return widgetList;
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(),
    );
  }
}

class ListTail extends StatelessWidget {
  final List<Map<String, dynamic>> tails;
  ListTail({this.tails});

  List<Padding> _buildTail() {
    List<Padding> _widgetlist = [];

    tails.asMap().forEach((int index, dynamic item) {
      _widgetlist.add(Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: InkResponse(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(
            item['iconData'],
            color: Color(0xFFD6D6D6),
          ),
          onTap: item['iconPress'],
        ),
      ));
    });
    return _widgetlist;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildTail(),
    );
  }
}
