import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';
import '../../router/Routes.dart';
import '../../components/musicplayer/inherited_demo.dart';
import '../../components/song_detail_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../components/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import './search_songs.dart';
import '../../model/music.dart';
import './music_item.dart';
import './search_playlist.dart';
import '../../repository/netease.dart';
import '../../components/musicplayer/playing_album_cover.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchResult extends StatefulWidget {
  final String keyword;
  SearchResult(this.keyword);

  @override
  SearchResultState createState() => SearchResultState();
}

class SearchResultState extends State<SearchResult>
    with TickerProviderStateMixin {
  List<Music> songs = []; // 单曲
  List<PlayList> playlist = []; // 歌单
  TabController _tabController;
  List<Widget> _viewWidget = [];
  bool _isLoading = true;

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
    var songRes = await NeteaseRepository.doSearchSingAlbum(keyword);
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
              albumCoverImg: res['detail']['al']['picUrl'],
              detail: res['detail'],
              commentCount: res['commentCount']),
        );
      });
      if (songs.length == songRes.asMap().length) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  // 获取歌单
  void _doSearchPlaylist(String keyword) async {
    var plays = await NeteaseRepository.doSearchPlaylist(keyword);
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
  }

  // 获取单曲详情
  getSongDetail(int id) async {
    Map<String, dynamic> songDetail = {};
    var result = await NeteaseRepository.getSongDetail(id);
    var comment = await getSongComment(id);
    songDetail.addAll(
        {'detail': result['songs'][0], 'commentCount': comment['total']});
    return songDetail;
  }

  // 获取歌曲论数量
  getSongComment(int id) async {
    var result = await NeteaseRepository.getSongComment(id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    _viewWidget = [
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: _isLoading == true
            ? Center(
                child: Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor),
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Album(widget.keyword, songs,
                        tabController: _tabController, store: store),
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
      SearchSongTab(keyword: widget.keyword),
      Center(child: Text('视频')),
      Center(child: Text('歌手')),
      Center(child: Text('专辑')),
      SearchPlaylistTab(
        keyword: widget.keyword,
      ),
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
  final StateContainerState store;
  Album(this.keyword, this.songList, {this.tabController, this.store});
  static Widget _nameWidget;
  static Widget _albumnameWidget;

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  List<Widget> _buildWidget(BuildContext context) {
    List<Widget> widgetList = [];
    songList.asMap().forEach((int index, Music item) {
      widgetList.add(MusicItem(
        item,
        keyword,
        tailsList: [
          {'iconData': Icons.play_circle_outline, 'iconPress': () {}},
          {
            'iconData': Icons.more_vert,
            'iconPress': () async {
              var detail = item.detail;
              var commentCount = item.commentCount;
              var res = await _getSongUrl(detail['id']);

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
                            'leadingIcon': AntDesign.getIconData('playcircleo'),
                            'title': '下一首播放',
                            'callback': res == null
                                ? null
                                : () async {
                                    await store.playInsertNext(item);
                                    Fluttertoast.showToast(
                                      msg: '已添加到播放列表',
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('plussquareo'),
                            'title': '收藏到歌单',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('download'),
                            'title': '下载',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('message1'),
                            'title': '评论($commentCount)',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('sharealt'),
                            'title': '分享',
                            'callback': () {
                              Navigator.of(context).pop();
                              BottomShare.showBottomShare(context, [
                                {
                                  'shareLogo':
                                      'assets/icons/friend_circle_32.png',
                                  'shareText': '微信朋友圈',
                                  'shareEvent': () {
                                    var model = fluwx.WeChatShareMusicModel(
                                      scene: fluwx.WeChatScene.TIMELINE,
                                      thumbnail: detail['al']['picUrl'],
                                      title:
                                          '${detail['name']}（${detail['al']['name']}）',
                                      description: '${detail['ar'][0]['name']}',
                                      transaction: "music",
                                      musicUrl: detail['songUrl'],
                                    );

                                    fluwx.share(model);
                                  }
                                },
                                {
                                  'shareLogo': 'assets/icons/wechat_32.png',
                                  'shareText': '微信好友',
                                  'shareEvent': () {
                                    var model = fluwx.WeChatShareMusicModel(
                                      thumbnail: detail['picUrl'],
                                      scene: fluwx.WeChatScene.SESSION,
                                      title:
                                          '${detail['name']}（${detail['al']['name']}）',
                                      description: '${detail['ar'][0]['name']}',
                                      transaction: "music",
                                      musicUrl: detail['songUrl'],
                                    );

                                    fluwx.share(model);
                                  }
                                },
                                {
                                  'shareLogo': 'assets/icons/qq_zone_32.png',
                                  'shareText': 'QQ空间',
                                  'shareEvent': () {}
                                },
                                {
                                  'shareLogo': 'assets/icons/qq_friend_32.png',
                                  'shareText': 'QQ好友',
                                  'shareEvent': () {}
                                },
                                {
                                  'shareLogo': 'assets/icons/weibo_32.png',
                                  'shareText': '微薄',
                                  'shareEvent': () {}
                                },
                                {
                                  'shareLogo': 'assets/icons/qq_friend_32.png',
                                  'shareText': '大神圈子',
                                  'shareEvent': () {}
                                }
                              ]);
                            }
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('adduser'),
                            'title': '歌手：${detail['ar'][0]['name']}',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('adduser'),
                            'title': '专辑：${detail['al']['name']}',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('youtube'),
                            'title': '查看视频',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('barchart'),
                            'title': '人气榜应援',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('delete'),
                            'title': '删除',
                            'callback': () {}
                          }
                        ]);
                  });
            }
          }
        ],
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
                            BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
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
                            onPressed: () async {
                              await store.playMultis(this.songList);
                              if (store.player.isPlaying == true) {
                                var res = await store.player.audioPlayer.stop();
                                if (res == 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return AlbumCover(
                                      isNew: true,
                                    );
                                  }));
                                }
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return AlbumCover(
                                    isNew: true,
                                  );
                                }));
                              }
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
                  Expanded(
                    child: Container(
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
