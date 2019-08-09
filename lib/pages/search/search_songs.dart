import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../components/selection/select_all.dart';
import '../../model/music.dart';
import '../../components/music/music_item.dart';
import '../../components/music/music_item_list.dart';
import '../../components/song_detail_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../components/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import '../../repository/netease.dart';
import '../../components/musicplayer/inherited_demo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../router/Routes.dart';
import '../../components/musicplayer/player.dart';
import '../artist/artist_page.dart';
import '../album/album_cover.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../redux/app.dart';

class SearchSongTab extends StatefulWidget {
  final String keyword;
  final BuildContext pageContext;
  SearchSongTab({@required this.keyword, this.pageContext});
  @override
  SearchSongTabState createState() => SearchSongTabState();
}

class SearchSongTabState extends State<SearchSongTab>
    with AutomaticKeepAliveClientMixin {
  bool _isLoading = true;
  bool _selection = false;
  List<Music> songs = []; // 单曲
  ScrollController _scrollController;
  int offset = 0;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    if (this.mounted) {
      _getSongs(offset);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2.0) {
      if (_isLoading == true) return;
      offset = offset + 1;
      _getSongs(offset);
    }
  }

  // 获取歌曲论数量
  getSongComment(int id) async {
    var result = await NeteaseRepository.getSongComment(id);
    return result;
  }

  // 获取单曲详情
  _getSongDetail(int id) async {
    Map<String, dynamic> songDetail = {};
    var result = await NeteaseRepository.getSongDetail(id);
    var comment = await getSongComment(id);
    songDetail.addAll(
        {'detail': result['songs'][0], 'commentCount': comment['total']});
    return songDetail;
  }

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  // 获取单曲
  void _getSongs(int offset) async {
    setState(() {
      _isLoading = true;
    });
    var _len = songs.length;
    var songRes =
        await NeteaseRepository.getSongs(widget.keyword, offset: offset);
    await songRes.asMap().forEach((int index, item) async {
      var res = await _getSongDetail(item['id']);
      if (this.mounted) {
        Future.delayed(Duration(milliseconds: 20), () {
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
                  commentCount: res['commentCount'],
                  mvId: item['mvid'],
                  album: Album(
                      id: item['album']['id'],
                      name: item['album']['name'],
                      coverImageUrl: res['detail']['al']['picUrl']),
                  artists: [
                    Artist(
                        id: item['artists'][0]['id'],
                        name: item['artists'][0]['name'],
                        imageUrl: '')
                  ]),
            );
          });
          if (songs.length == _len + songRes.length) {
            setState(() {
              _isLoading = false;
            });
          }
        });
      }
    });
  }

  List<MusicItem> _buildList(
      BuildContext context, StateContainerState store, VoidCallback cb) {
    List<MusicItem> _widgetlist = [];
    if (songs.length > 0) {
      songs.asMap().forEach((int index, item) {
        _widgetlist.add(MusicItem(
          item,
          keyword: widget.keyword,
          sortIndex: index + 1,
          sort: false,
          tailsList: item.mvId == 0
              ? [
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
                                    'leadingIcon':
                                        AntDesign.getIconData('playcircleo'),
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
                                    'leadingIcon':
                                        AntDesign.getIconData('plussquareo'),
                                    'title': '收藏到歌单',
                                    'callback': () {
                                      cb();
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('download'),
                                    'title': '下载',
                                    'callback': () {}
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('message1'),
                                    'title': '评论($commentCount)',
                                    'callback': () {}
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('sharealt'),
                                    'title': '分享',
                                    'callback': () {
                                      Navigator.of(context).pop();
                                      BottomShare.showBottomShare(context, [
                                        {
                                          'shareLogo':
                                              'assets/icons/friend_circle_32.png',
                                          'shareText': '微��朋友圈',
                                          'shareEvent': () {
                                            var model =
                                                fluwx.WeChatShareMusicModel(
                                              scene: fluwx.WeChatScene.TIMELINE,
                                              thumbnail: detail['al']['picUrl'],
                                              title:
                                                  '${detail['name']}（${detail['al']['name']}）',
                                              description:
                                                  '${detail['ar'][0]['name']}',
                                              transaction: "music",
                                              musicUrl: detail['songUrl'],
                                            );

                                            fluwx.share(model);
                                          }
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/wechat_32.png',
                                          'shareText': '微信好友',
                                          'shareEvent': () {
                                            var model =
                                                fluwx.WeChatShareMusicModel(
                                              thumbnail: detail['picUrl'],
                                              scene: fluwx.WeChatScene.SESSION,
                                              title:
                                                  '${detail['name']}（${detail['al']['name']}）',
                                              description:
                                                  '${detail['ar'][0]['name']}',
                                              transaction: "music",
                                              musicUrl: detail['songUrl'],
                                            );

                                            fluwx.share(model);
                                          }
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/qq_zone_32.png',
                                          'shareText': 'QQ空间',
                                          'shareEvent': () {}
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/qq_friend_32.png',
                                          'shareText': 'QQ好友',
                                          'shareEvent': () {}
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/weibo_32.png',
                                          'shareText': '微薄',
                                          'shareEvent': () {}
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/qq_friend_32.png',
                                          'shareText': '大神圈子',
                                          'shareEvent': () {}
                                        }
                                      ]);
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('adduser'),
                                    'title': '歌手：${detail['ar'][0]['name']}',
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return ArtistPage(item.artists[0].id);
                                      }));
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('adduser'),
                                    'title': '专辑：${detail['al']['name']}',
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return AlbumCover(item.album.id);
                                      }));
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('youtube'),
                                    'title': '查看视频',
                                    'callback': () {}
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('barchart'),
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
                ]
              : [
                  {'iconData': Icons.play_circle_outline, 'iconPress': () {}},
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
                                        AntDesign.getIconData('playcircleo'),
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
                                    'leadingIcon':
                                        AntDesign.getIconData('plussquareo'),
                                    'title': '收藏到歌单',
                                    'callback': () {
                                      cb();
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('download'),
                                    'title': '下载',
                                    'callback': () {}
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('message1'),
                                    'title': '评论($commentCount)',
                                    'callback': () {}
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('sharealt'),
                                    'title': '分享',
                                    'callback': () {
                                      Navigator.of(context).pop();
                                      BottomShare.showBottomShare(context, [
                                        {
                                          'shareLogo':
                                              'assets/icons/friend_circle_32.png',
                                          'shareText': '微信朋友圈',
                                          'shareEvent': () {
                                            var model =
                                                fluwx.WeChatShareMusicModel(
                                              scene: fluwx.WeChatScene.TIMELINE,
                                              thumbnail: detail['al']['picUrl'],
                                              title:
                                                  '${detail['name']}（${detail['al']['name']}）',
                                              description:
                                                  '${detail['ar'][0]['name']}',
                                              transaction: "music",
                                              musicUrl: detail['songUrl'],
                                            );

                                            fluwx.share(model);
                                          }
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/wechat_32.png',
                                          'shareText': '微信好友',
                                          'shareEvent': () {
                                            var model =
                                                fluwx.WeChatShareMusicModel(
                                              thumbnail: detail['picUrl'],
                                              scene: fluwx.WeChatScene.SESSION,
                                              title:
                                                  '${detail['name']}（${detail['al']['name']}）',
                                              description:
                                                  '${detail['ar'][0]['name']}',
                                              transaction: "music",
                                              musicUrl: detail['songUrl'],
                                            );

                                            fluwx.share(model);
                                          }
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/qq_zone_32.png',
                                          'shareText': 'QQ空间',
                                          'shareEvent': () {}
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/qq_friend_32.png',
                                          'shareText': 'QQ好友',
                                          'shareEvent': () {}
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/weibo_32.png',
                                          'shareText': '微薄',
                                          'shareEvent': () {}
                                        },
                                        {
                                          'shareLogo':
                                              'assets/icons/qq_friend_32.png',
                                          'shareText': '大神圈子',
                                          'shareEvent': () {}
                                        }
                                      ]);
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('adduser'),
                                    'title': '歌手：${detail['ar'][0]['name']}',
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return ArtistPage(item.artists[0].id);
                                      }));
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('adduser'),
                                    'title': '专辑：${detail['al']['name']}',
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return AlbumCover(item.album.id);
                                      }));
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('youtube'),
                                    'title': '查看视频',
                                    'callback': () {}
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('barchart'),
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
          pageContext: widget.pageContext,
        ));
      });
    }
    return _widgetlist;
  }

  Widget _buildTail() {
    return Theme(
      data: ThemeData(
        iconTheme: IconThemeData(color: Color(0xffd4d4d4)),
      ),
      child: GestureDetector(
        onTap: () {
          // todo 清除播放记录
          _clearPlayRecords(context, () {
            setState(() {
              songs.clear();
            });
          });
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.transparent))),
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.delete_outline),
              Text(
                '清除播放记录',
                style: TextStyle(
                    color: Theme.of(context).textTheme.subtitle.color,
                    fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSongsWidget(StateContainerState store, VoidCallback cb) {
    return (_isLoading == true && offset == 0)
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ))
        : songs.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '暂无播放记录',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle.color),
                  ),
                ))
            : (_isLoading == true && offset > 0)
                ? ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return StickyHeader(
                        header: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFE0E0E0), width: 0.5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await store.playMultis(this.songs);
                                      if (store.player.isPlaying == true) {
                                        var res = await MyPlayer.player.stop();
                                        if (res == 1) {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(builder:
                                          //         (BuildContext context) {
                                          //   return AlbumCover(
                                          //     isNew: true,
                                          //   );
                                          // }));
                                          Routes.router.navigateTo(
                                              widget.pageContext,
                                              '/albumcoverpage?isNew=true');
                                        }
                                      } else {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext context) {
                                        //   return AlbumCover(
                                        //     isNew: true,
                                        //   );
                                        // }));
                                        Routes.router.navigateTo(
                                            widget.pageContext,
                                            '/albumcoverpage?isNew=true');
                                      }
                                    },
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.play_circle_outline),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              '播放全部',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .title
                                                    .fontSize,
                                              ),
                                            ),
                                          ),
                                          Text('（共${songs.length}首）',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .color))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selection = !_selection;
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.list),
                                        Text(
                                          '多选',
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        content: Column(
                          children: <Widget>[
                            MusicItemList(
                              keyword: widget.keyword,
                              list: _buildList(context, store, cb),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              child: Text('单曲加载中...',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: 1,
                  )
                : ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return StickyHeader(
                        header: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFE0E0E0), width: 0.5))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    onTap: () async {
                                      await store.playMultis(this.songs);
                                      if (store.player.isPlaying == true) {
                                        var res = await MyPlayer.player.stop();
                                        if (res == 1) {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(builder:
                                          //         (BuildContext context) {
                                          //   return AlbumCover(
                                          //     isNew: true,
                                          //   );
                                          // }));
                                          Routes.router.navigateTo(
                                              widget.pageContext,
                                              '/albumcoverpage?isNew=true');
                                        }
                                      } else {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext context) {
                                        //   return AlbumCover(
                                        //     isNew: true,
                                        //   );
                                        // }));
                                        Routes.router.navigateTo(
                                            widget.pageContext,
                                            '/albumcoverpage?isNew=true');
                                      }
                                    },
                                    child: Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.play_circle_outline),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 12.0),
                                            child: Text(
                                              '播放全部',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Theme.of(context)
                                                    .textTheme
                                                    .title
                                                    .fontSize,
                                              ),
                                            ),
                                          ),
                                          Text('（共${songs.length}首）',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .subtitle
                                                      .color))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selection = !_selection;
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.list),
                                        Text(
                                          '多选',
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        content: MusicItemList(
                          keyword: widget.keyword,
                          list: _buildList(context, store, cb),
                          tailWidget: _buildTail(),
                        ),
                      );
                    },
                    itemCount: 1,
                  );
  }

  void _onSongsDelete(val) {
    setState(() {
      val.forEach((item) {
        var _index = songs.indexOf(item);
        songs.removeAt(_index);
      });
      _selection = !_selection;
    });
  }

  // 下一首播放
  Future<int> _onSongsPlayNext(
      List<Music> selectedSongs, StateContainerState store) async {
    await store.playInsertMultiNext(selectedSongs);
    Fluttertoast.showToast(msg: '已添加到播放列表');
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return !_selection
        ? StoreConnector<NeteaseState, VoidCallback>(
            builder: (BuildContext context, cb) {
              return buildSongsWidget(store, cb);
            },
            converter: (Store<NeteaseState> appstore) {
              return () {
                appstore.dispatch(Actions.AddToCollection);
              };
            },
          )
        : SelectAll(
            songs: songs,
            handleSongsDel: (val) => _onSongsDelete(val),
            handleSongsPlayNext: (List<Music> selectedSongs) =>
                _onSongsPlayNext(selectedSongs, store),
            handleFinish: (List<Music> selectedSongs) {
              setState(() {
                _selection = false;
              });
            });
  }
}

void _clearPlayRecords(BuildContext ctx, VoidCallback callback) {
  showCupertinoModalPopup(
    context: ctx,
    builder: (BuildContext context) => CupertinoActionSheet(
        message: const Text('确定清除播放记录？'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              '清除',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              callback();
              Navigator.pop(context, '清除');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('取消'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, '取消');
          },
        )),
  );
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
