import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:netease_music/pages/playlist/selection_list.dart';
import 'dart:ui';
import '../../model/model.dart';
import '../../model/playlist_detail.dart';
import '../../pages/playlist/music_list.dart';
import '../../utils/utils.dart';
import './flexible_app_bar.dart';
import './music_list.dart';
import '../../repository/netease.dart';
import './selection_checkbox.dart';
import './selection_bottom.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './playlist_internal_search.dart';

/// 歌单详情信息 header 高度
const double HEIGHT_HEADER = 280 + 56.0;

class Playlists extends StatefulWidget {
  Playlists(this.playlistId, this.type, {this.playlist, this.pageContext});
  final int playlistId;
  final PlaylistDetail playlist;
  final BuildContext pageContext;
  final String type;

  @override
  _PlaylistPageState createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<Playlists> {
  PlaylistDetail _result;
  List<Music> songs = [];

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case 'ranking':
        _getTopListDetail();
        break;
      case 'playlist':
        _getPlaylistDetail();
        break;
    }
  }

  _getTopListDetail() async {
    var playlist = await NeteaseRepository.getTopList(widget.playlistId);
    playlist['tracks'].asMap().forEach((int index, item) {
      songs.add(Music(
          name: item['name'],
          id: item['id'],
          aritstName: item['ar'][0]['name'],
          aritstId: item['ar'][0]['id'],
          albumName: item['al']['name'],
          albumId: item['al']['id'],
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
          ]));
    });

    setState(() {
      _result = PlaylistDetail(
        name: playlist['name'],
        coverUrl: playlist['coverImgUrl'],
        id: playlist['id'],
        trackCount: playlist['trackCount'],
        description: playlist['description'],
        subscribed: playlist['subscribed'],
        subscribedCount: playlist['subscribedCount'],
        commentCount: playlist['commentCount'],
        shareCount: playlist['shareCount'],
        playCount: playlist['playCount'],
        creator: playlist['creator'],
        musics: songs,
      );
    });
  }

  _getPlaylistDetail() async {
    var playlist = await NeteaseRepository.getPlaylistDetail(widget.playlistId);
    playlist['tracks'].asMap().forEach((int index, item) {
      songs.add(Music(
          name: item['name'],
          id: item['id'],
          aritstName: item['ar'][0]['name'],
          aritstId: item['ar'][0]['id'],
          albumName: item['al']['name'],
          albumId: item['al']['id'],
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
          ]));
    });
    if (this.mounted) {
      setState(() {
        _result = PlaylistDetail(
          name: playlist['name'],
          coverUrl: playlist['coverImgUrl'],
          id: playlist['id'],
          trackCount: playlist['trackCount'],
          description: playlist['description'],
          subscribed: playlist['subscribed'],
          subscribedCount: playlist['subscribedCount'],
          commentCount: playlist['commentCount'],
          shareCount: playlist['shareCount'],
          playCount: playlist['playCount'],
          creator: playlist['creator'],
          musics: songs,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _PlayList(
      playlistDetail: _result,
      pageContext: widget.pageContext,
    );
  }
}

class _PlayList extends StatefulWidget {
  const _PlayList({Key key, this.playlistDetail, this.pageContext})
      : super(key: key);
  final BuildContext pageContext;
  final PlaylistDetail playlistDetail;

  List<Music> get musiclist => playlistDetail.musics;

  @override
  State<StatefulWidget> createState() {
    return _PlayListState();
  }
}

class _PlayListState extends State<_PlayList> {
  bool _selection = false;
  bool _selectedAll = false;
  Color bottomIconColor = Color(0xffd4d4d4);
  final List<Music> _selectedList = [];
  ScrollController _scrollController;

  Future<bool> _doSubscribeChanged(bool subscribe) async {
    int succeed;
    succeed = await NeteaseRepository.playlistSubscribe(
        !subscribe, widget.playlistDetail.id);
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
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
                          trackCount: widget.playlistDetail == null
                              ? 0
                              : widget.playlistDetail.trackCount,
                          subscribed: widget.playlistDetail == null
                              ? false
                              : widget.playlistDetail.subscribed,
                          subscribedCount: widget.playlistDetail == null
                              ? 0
                              : widget.playlistDetail.subscribedCount,
                          doSubscribeChanged: _doSubscribeChanged,
                        )
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
                    playlistDetail: widget.playlistDetail,
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
                            return widget.playlistDetail == null
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
                          childCount: widget.playlistDetail == null
                              ? 1
                              : widget.musiclist.length,
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
                                : () {
                                    // 下一首播放
                                    _selectedList
                                        .asMap()
                                        .forEach((int index, Music music) {
                                      print(music.name);
                                    });
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

    ;
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
  final PlaylistDetail playlistDetail;
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
                child: Container(color: Colors.black.withOpacity(0.1)),
              )
            ]
          : <Widget>[
              Image.network(
                playlistDetail.coverUrl,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                child: Container(color: Colors.black.withOpacity(0.1)),
              )
            ],
    );
  }
}

class _PlaylistDetailHeader extends StatelessWidget {
  _PlaylistDetailHeader({this.playlistDetail, this.onSelect});
  final PlaylistDetail playlistDetail;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
        background: _BlurBackground(
          playlistDetail: playlistDetail,
        ),
        content: _buildContent(context),
        builder: (context, t) {
          return AppBar(
            title: Text(t > 0.5 ? playlistDetail.name : '歌单'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  tooltip: "歌单内搜索",
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: PlaylistInternalSearchDelegate(
                            playlistDetail, Theme.of(context)));
                  }),
              IconButton(
                  icon: Icon(Icons.more_vert),
                  tooltip: "更多选项",
                  onPressed: () {})
            ],
          );
        });
  }

  Widget _buildContent(
    BuildContext context,
  ) {
    Map<String, Object> creator =
        playlistDetail == null ? {} : playlistDetail.creator;

    return DetailHeader(
      commentCount: playlistDetail == null ? 0 : playlistDetail.commentCount,
      shareCount: playlistDetail == null ? 0 : playlistDetail.shareCount,
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
                borderRadius: BorderRadius.all(Radius.circular(3)),
                child: Stack(
                  children: <Widget>[
                    Hero(
                      tag: playlistDetail == null ? '' : playlistDetail.heroTag,
                      child: playlistDetail == null
                          ? CircularProgressIndicator()
                          : Image.network(
                              playlistDetail.coverUrl,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Colors.black54,
                            Colors.black26,
                            Colors.transparent,
                            Colors.transparent,
                          ])),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.headset,
                                color: Theme.of(context).primaryIconTheme.color,
                                size: 12),
                            Text(
                                getFormattedNumber(playlistDetail == null
                                    ? 0
                                    : playlistDetail.playCount),
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .body1
                                    .copyWith(fontSize: 11))
                          ],
                        ),
                      ),
                    )
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
                    playlistDetail == null ? '' : playlistDetail.name,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .title
                        .copyWith(fontSize: 17),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () => {},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: playlistDetail == null
                                ? CircularProgressIndicator()
                                : ClipOval(
                                    child: Image.network(
                                      creator["avatarUrl"],
                                    ),
                                  ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 4)),
                          Text(
                            playlistDetail == null ? '' : creator["nickname"],
                            style: Theme.of(context).primaryTextTheme.body1,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Theme.of(context).primaryIconTheme.color,
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
  _SelectionHeader({Key key, this.allSelected, this.onTap, this.onFinish})
      : super(key: key);

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
      this.doSubscribeChanged})
      : super(key: key);

  final bool subscribed;
  final int trackCount;
  final int subscribedCount;
  final Future<bool> Function(bool currentState) doSubscribeChanged;
  final Widget tail;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: () {},
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
                  "播放全部",
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
