import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:netease_music/pages/playlist/selection_list.dart';
import 'dart:ui';
import '../../model/music.dart';
import '../../model/album_detail.dart';
import '../../utils/utils.dart';
import './flexible_app_bar.dart';
import './music_list.dart';
import '../../repository/netease.dart';
import './selection_checkbox.dart';
import './selection_bottom.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../artist/artist_page.dart';
import '../album_cover/album_cover.dart';
import '../../components/musicplayer/inherited_demo.dart';
import '../../components/musicplayer/player.dart';
import '../../router/Routes.dart';

/// 专辑详情信息 header 高度
const double HEIGHT_HEADER = 280 + 56.0;

class AlbumCover extends StatefulWidget {
  AlbumCover(this.albumId, {this.pageContext});
  final int albumId;
  final BuildContext pageContext;

  @override
  _AlbumCoverState createState() => _AlbumCoverState();
}

class _AlbumCoverState extends State<AlbumCover> {
  AlbumDetail _result;
  List<Music> songs = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _getAlbumDetail();
  }

  // 获取专辑详情
  _getAlbumDetail() async {
    setState(() {
      loading = true;
    });
    var result = await NeteaseRepository.getAlbumDetail(widget.albumId);
    result['songs'].asMap().forEach((int index, item) async {
      songs.add(Music(
          name: item['name'],
          id: item['id'],
          aritstName: item['ar'][0]['name'],
          aritstId: item['ar'][0]['id'],
          albumName: item['al']['name'],
          albumId: item['al']['id'],
          albumCoverImg: item['al']['picUrl'],
          album: Album(
              id: item['al']['id'],
              name: item['al']['name'],
              coverImageUrl: item['al']['picUrl']),
          artists: [
            Artist(
              id: item['ar'][0]['id'],
              name: item['ar'][0]['name'],
              imageUrl: '',
            )
          ],
          mvId: item['mv']));
    });

    setState(() {
      _result = AlbumDetail(
        name: result['album']['name'],
        coverUrl: result['album']['picUrl'],
        id: result['album']['id'],
        description: result['album']['description'],
        commentCount: result['album']['info']['commentCount'],
        shareCount: result['album']['info']['shareCount'],
        publishTime: result['album']['publishTime'],
        subType: result['album']['subType'],
        company: result['album']['company'],
        artist: Artist(
          id: result['album']['artist']['id'],
          name: result['album']['artist']['name'],
        ),
        trackCount: songs.length,
        subscribed: false,
        subscribedCount: 0,
        musics: songs,
      );
    });
    if (songs.length == result['songs'].length) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AlbumCover(
        albumDetail: _result,
        pageContext: widget.pageContext,
        loading: loading);
  }
}

class _AlbumCover extends StatefulWidget {
  const _AlbumCover({Key key, this.albumDetail, this.pageContext, this.loading})
      : super(key: key);
  final BuildContext pageContext;
  final AlbumDetail albumDetail;
  final bool loading;

  List<Music> get musiclist => albumDetail.musics;

  @override
  State<StatefulWidget> createState() {
    return __AlbumCoverState();
  }
}

class __AlbumCoverState extends State<_AlbumCover> {
  bool _selection = false;
  bool _selectedAll = false;
  Color bottomIconColor = Color(0xffd4d4d4);
  final List<Music> _selectedList = [];
  ScrollController _scrollController;

  Future<bool> _doSubscribeChanged(bool subscribe) async {
    int succeed;
    succeed = await NeteaseRepository.playlistSubscribe(
        !subscribe, widget.albumDetail.id);
    String action = !subscribe ? "收藏" : "取消收藏";
    if (succeed == 200) {
      Fluttertoast.showToast(
        msg: "$action成功",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
      );
      return !subscribe;
    } else {
      Fluttertoast.showToast(
        msg: "$action失败",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
      );
      return subscribe;
    }
  }

  // 多选下一首播放
  Future<int> _onSongsPlayNext(
      List<Music> selectedSongs, StateContainerState store) async {
    await store.playInsertMultiNext(selectedSongs);
    Fluttertoast.showToast(msg: '已添加到播放列表');
    return 1;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return NotificationListener<SelectionNotification>(
      onNotification: (notification) {
        setState(() {
          _selectedAll = notification.selectedAll;
        });
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  expandedHeight: HEIGHT_HEADER,
                  bottom: _selection == false
                      ? MusicListHeader(
                          trackCount: widget.albumDetail == null
                              ? 0
                              : widget.albumDetail.trackCount,
                          subscribed: widget.albumDetail == null
                              ? false
                              : widget.albumDetail.subscribed,
                          subscribedCount: widget.albumDetail == null
                              ? 0
                              : widget.albumDetail.subscribedCount,
                          doSubscribeChanged: _doSubscribeChanged,
                          musiclist: widget.albumDetail == null
                              ? []
                              : widget.albumDetail.musics)
                      : _SelectionHeader(
                          allSelected: _selectedAll,
                          onTap: (BuildContext ctx) {
                            //全选
                            SelectionNotification(!_selectedAll).dispatch(ctx);
                            if (_selectedAll) {
                              setState(() {
                                _selectedList.addAll(widget.musiclist);
                                bottomIconColor =
                                    Theme.of(context).iconTheme.color;
                              });
                            } else {
                              setState(() {
                                _selectedList.clear();
                                bottomIconColor = Color(0xffd4d4d4);
                              });
                            }
                          },
                          onFinish: (BuildContext ctx) {
                            // 完成
                            SelectionNotification(false).dispatch(ctx);
                            setState(() {
                              _selectedList.clear();
                              _selection = false;
                              bottomIconColor = Color(0xffd4d4d4);
                            });
                          }),
                  flexibleSpace: _PlaylistDetailHeader(
                    albumDetail: widget.albumDetail,
                    onSelect: () {
                      setState(() {
                        _selection = !_selection;
                      });
                      _scrollController.animateTo(231.0,
                          duration: Duration(milliseconds: 100),
                          curve: Curves.ease);
                    },
                  ),
                ),
                _selection == false
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return widget.loading == true
                                ? Center(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : MusicTitle(
                                    widget.musiclist,
                                    pageContext: widget.pageContext,
                                  );
                          },
                          childCount: 1,
                        ),
                      )
                    : SliverSelection(
                        musiclist: widget.musiclist,
                        selectedALL: _selectedAll,
                        selectedList: _selectedList,
                        onTap: (value) {
                          setState(() {
                            if (!_selectedList.remove(value['item'])) {
                              // true 代表是未选择
                              _selectedList.add(value['item']);
                              bottomIconColor =
                                  Theme.of(context).iconTheme.color;
                            }
                            if (_selectedList.length ==
                                widget.musiclist.length) {
                              SelectionNotification(true)
                                  .dispatch(value['ctx']);
                              bottomIconColor =
                                  Theme.of(context).iconTheme.color;
                            } else {
                              SelectionNotification(false)
                                  .dispatch(value['ctx']);
                            }
                            if (_selectedList.length == 0) {
                              bottomIconColor = Color(0xffd4d4d4);
                            }
                          });
                        }),
              ],
            ),
            _selection == false
                ? Center()
                : SelectBottom(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                      // height: 6.0,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: _selectedList.length == 0
                                ? null
                                : () async {
                                    List<Music> lists = [];
                                    _selectedList.forEach((Music music) {
                                      lists.add(music);
                                    });
                                    // 下一首播放
                                    var res =
                                        await _onSongsPlayNext(lists, store);

                                    if (res == 1) {
                                      setState(() {
                                        _selectedList.clear();
                                        _selectedAll = false;
                                      });
                                    }
                                  },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.play_circle_outline,
                                    color: bottomIconColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      '下一首播放',
                                      style: TextStyle(
                                          color: Color(0xff3f3b3c),
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _selectedList.length == 0
                                ? null
                                : () {
                                    // 收藏到歌单
                                  },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: bottomIconColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      '收藏到歌单',
                                      style: TextStyle(
                                          color: Color(0xff3f3b3c),
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _selectedList.length == 0
                                ? null
                                : () {
                                    // 删除
                                  },
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.delete_outline,
                                    color: bottomIconColor,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      '删除',
                                      style: TextStyle(
                                          color: Color(0xff3f3b3c),
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class SliverSelection extends StatefulWidget {
  SliverSelection(
      {Key key,
      this.musiclist,
      this.selectedALL,
      this.selectedList,
      this.onTap})
      : super(key: key);
  final List<Music> musiclist;
  final List<Music> selectedList;

  final bool selectedALL;
  final ValueChanged<Map<String, dynamic>> onTap;

  @override
  _SliverSelectionState createState() => _SliverSelectionState();
}

class _SliverSelectionState extends State<SliverSelection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var _item = widget.musiclist[index];
          return SongList(
              handleTap: () {
                widget.onTap({'ctx': context, 'item': _item});
              },
              item: _item,
              selectStatus: widget.selectedALL == true
                  ? true
                  : widget.selectedList.contains(_item));
        },
        childCount: widget.musiclist.length,
      ),
    );
  }
}

class _BlurBackground extends StatelessWidget {
  final AlbumDetail playlistDetail;
  const _BlurBackground({Key key, @required this.playlistDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: playlistDetail == null
            ? <Widget>[
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Container(color: Colors.black.withOpacity(0.4)),
                )
              ]
            : <Widget>[
                Image.network(
                  playlistDetail.coverUrl,
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                  child: Container(color: Colors.black.withOpacity(0.4)),
                ),
              ]);
  }
}

class _PlaylistDetailHeader extends StatelessWidget {
  _PlaylistDetailHeader({this.albumDetail, this.onSelect});
  final AlbumDetail albumDetail;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
        background: _BlurBackground(
          playlistDetail: albumDetail,
        ),
        content: _buildContent(context),
        builder: (context, t) {
          return AppBar(
            title: Text(t > 0.5 ? albumDetail.name : '专辑'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.more_vert),
                  tooltip: "更多选项",
                  onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.equalizer),
                  tooltip: "播放器",
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return AlbumCoverPage();
                    }));
                  })
            ],
          );
        });
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    return DetailHeader(
      commentCount: albumDetail == null ? 0 : albumDetail.commentCount,
      shareCount: albumDetail == null ? 0 : albumDetail.shareCount,
      onCommentTap: () {},
      onShareTap: () {},
      onSelectionTap: onSelect,
      content: Container(
        height: 146.0,
        padding: EdgeInsets.only(top: 20.0),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16.0,
            ),
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: albumDetail == null ? '' : albumDetail.heroTag,
                      child: albumDetail == null
                          ? Container()
                          : Image.network(
                              albumDetail.coverUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    albumDetail == null ? '' : albumDetail.name,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .title
                        .copyWith(fontSize: 17),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  InkWell(
                    onTap: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ArtistPage(albumDetail.artist.id);
                          }))
                        },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 24,
                            width: 40,
                            child: albumDetail == null
                                ? Container()
                                : Text('歌手：',
                                    style: TextStyle(
                                        fontFamily: Theme.of(context)
                                            .primaryTextTheme
                                            .body1
                                            .fontFamily,
                                        fontSize: 13.0,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .body1
                                            .color
                                            .withOpacity(0.6))),
                          ),
                          Padding(padding: EdgeInsets.only(left: 4)),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                albumDetail == null
                                    ? ''
                                    : albumDetail.artist.name,
                                style: TextStyle(
                                    fontFamily: Theme.of(context)
                                        .primaryTextTheme
                                        .body1
                                        .fontFamily,
                                    fontSize: 13.0,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .body1
                                        .color),
                              ),
                              albumDetail == null
                                  ? Text('')
                                  : Icon(
                                      Icons.chevron_right,
                                      color: Theme.of(context)
                                          .primaryIconTheme
                                          .color
                                          .withOpacity(0.6),
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Expanded(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontFamily: Theme.of(context)
                              .primaryTextTheme
                              .body1
                              .fontFamily,
                          fontSize: 12.0,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .body1
                              .color
                              .withOpacity(0.6)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          albumDetail == null
                              ? Text('')
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      '发行时间：${getFormattedTime(albumDetail.publishTime)}'),
                                ),
                          SizedBox(height: 4),
                          albumDetail == null
                              ? Text('')
                              : Container(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    albumDetail.description == null
                                        ? ''
                                        : albumDetail.description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailHeader extends StatelessWidget {
  final Widget content;
  final int commentCount;
  final int shareCount;
  final GestureTapCallback onCommentTap;
  final GestureTapCallback onShareTap;
  final GestureTapCallback onSelectionTap;

  const DetailHeader(
      {Key key,
      this.content,
      this.commentCount,
      this.shareCount,
      this.onCommentTap,
      this.onShareTap,
      this.onSelectionTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight),
      child: Column(
        children: <Widget>[
          content,
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _HeaderAction(
                iconData: Icons.comment,
                headerContent: commentCount.toString(),
                onTap: onCommentTap,
              ),
              _HeaderAction(
                iconData: Icons.share,
                headerContent: shareCount.toString(),
                onTap: onShareTap,
              ),
              _HeaderAction(
                iconData: Icons.file_download,
                headerContent: '下载',
                onTap: null,
              ),
              _HeaderAction(
                iconData: Icons.check_box,
                headerContent: '多选',
                onTap: onSelectionTap,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  final IconData iconData;
  final String headerContent;
  final GestureTapCallback onTap;
  _HeaderAction({Key key, this.iconData, this.headerContent, this.onTap})
      : super(key: key);

  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).primaryTextTheme;
    return InkResponse(
      onTap: onTap,
      splashColor: textTheme.body1.color,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1,
        child: Column(children: [
          Icon(
            iconData,
            color: textTheme.body1.color,
          ),
          Text(
            headerContent,
            style: textTheme.caption.copyWith(fontSize: 13),
          )
        ]),
      ),
    );
  }
}

class _SelectionHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool allSelected;
  final ValueChanged<BuildContext> onTap;
  final ValueChanged<BuildContext> onFinish;
  _SelectionHeader({
    Key key,
    this.allSelected,
    this.onTap,
    this.onFinish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: () {
            this.onTap(context);
          },
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 20.0,
                ),
                SongCheckbox(
                  checked: allSelected,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    '全选',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    this.onFinish(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      '完成',
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  const MusicListHeader(
      {Key key,
      this.trackCount,
      this.subscribed,
      this.subscribedCount,
      this.tail,
      this.musiclist,
      this.doSubscribeChanged})
      : super(key: key);

  final bool subscribed;
  final int trackCount;
  final int subscribedCount;
  final Future<bool> Function(bool currentState) doSubscribeChanged;
  final Widget tail;
  final List<Music> musiclist;

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: () async {
            // 播放全部
            await store.playMultis(this.musiclist);
            if (store.player.isPlaying == true) {
              var res = await MyPlayer.player.stop();
              if (res == 1) {
                Routes.router.navigateTo(context, '/albumcoverpage?isNew=true');
              }
            } else {
              Routes.router.navigateTo(context, '/albumcoverpage?isNew=true');
            }
          },
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16)),
                Icon(
                  Icons.play_circle_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                Padding(padding: EdgeInsets.only(left: 4)),
                Text(
                  "��放全部",
                  style: Theme.of(context).textTheme.body1,
                ),
                Padding(padding: EdgeInsets.only(left: 2)),
                Text(
                  "(共$trackCount首)",
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                _SubscribeButton(this.subscribed, this.subscribedCount,
                    this.doSubscribeChanged),
                SizedBox(
                  width: 5.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class SelectionNotification extends Notification {
  SelectionNotification(this.selectedAll);
  final bool selectedAll;
}

class _SubscribeButton extends StatefulWidget {
  final bool subscribed;

  final int subscribedCount;

  final Future<bool> Function(bool currentState) doSubscribeChanged;

  const _SubscribeButton(
      this.subscribed, this.subscribedCount, this.doSubscribeChanged,
      {Key key})
      : super(key: key);

  @override
  _SubscribeButtonState createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<_SubscribeButton> {
  bool subscribed = false;

  @override
  void initState() {
    super.initState();
    subscribed = widget.subscribed;
  }

  @override
  Widget build(BuildContext context) {
    if (!subscribed) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: 36,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor.withOpacity(0.5),
            Theme.of(context).primaryColor
          ])),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                final result = await widget.doSubscribeChanged(subscribed);

                setState(() {
                  subscribed = result;
                });
              },
              child: Row(
                children: <Widget>[
                  SizedBox(width: 10),
                  Icon(Icons.add,
                      size: 18.0,
                      color: Theme.of(context).primaryIconTheme.color),
                  SizedBox(width: 2),
                  Text(
                    "收藏(${getFormattedNumber(widget.subscribedCount)})",
                    style: TextStyle(
                        fontSize: 12.0,
                        color:
                            Theme.of(context).primaryTextTheme.subtitle.color),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
          child: Container(
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(width: 16),
                Icon(Icons.folder_special,
                    size: 20, color: Theme.of(context).disabledColor),
                SizedBox(width: 4),
                Text(getFormattedNumber(widget.subscribedCount),
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 14)),
                SizedBox(width: 16),
              ],
            ),
          ),
          onTap: () async {
            final result = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("确定不再收藏此歌单吗?"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("取消")),
                      FlatButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text("不再收藏"))
                    ],
                  );
                });
            if (result != null && result) {
              final result = await widget.doSubscribeChanged(subscribed);
              setState(() {
                subscribed = result;
              });
            }
          });
    }
  }
}