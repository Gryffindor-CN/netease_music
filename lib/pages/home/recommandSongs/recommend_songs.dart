import 'package:flutter/material.dart';
import '../../../model/music.dart';
import '../../../repository/netease.dart';
import '../../../components/musicplayer/inherited_demo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/musicplayer/player.dart';
import '../../../router/Routes.dart';
import './flexible_app_bar.dart';
import 'dart:ui';
import './selection_bottom.dart';
import './music_list.dart';
import './selection_list.dart';
import './selection_checkbox.dart';
import '../../album_cover/album_cover.dart';

/// 每日推荐歌曲信息 header 高度
const double HEIGHT_HEADER = 160 + 56.0;

class RecommendSongs extends StatefulWidget {
  RecommendSongs({this.pageContext});
  final BuildContext pageContext;

  @override
  _RecommendSongsState createState() => _RecommendSongsState();
}

class _RecommendSongsState extends State<RecommendSongs> {
  List<Music> songs = [];
  final List<Music> _selectedList = [];
  bool loading = false;
  bool _selection = false;
  bool _selectedAll = false;
  Color bottomIconColor = Color(0xffd4d4d4);

  @override
  void initState() {
    super.initState();
    _getRecommandSongs();
  }

  // 获取歌曲论数量
  getSongComment(int id) async {
    var result = await NeteaseRepository.getSongComment(id);
    return result;
  }

  // 多选下一首播放
  Future<int> _onSongsPlayNext(
      List<Music> selectedSongs, StateContainerState store) async {
    await store.playInsertMultiNext(selectedSongs);
    Fluttertoast.showToast(msg: '已添加到播放列表');
    return 1;
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

  // 获取每日推荐歌曲
  Future<void> _getRecommandSongs() async {
    setState(() {
      loading = true;
    });
    var recommend = await NeteaseRepository.getRecommedSongs();
    var _len = songs.length;
    recommend.asMap().forEach((int index, item) async {
      var res = await _getSongDetail(item['id']);
      if (this.mounted) {
        setState(() {
          songs.add(Music(
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
              ]));
        });
        if (songs.length == _len + recommend.length) {
          setState(() {
            loading = false;
          });
        }
      }
    });
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
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  expandedHeight: HEIGHT_HEADER,
                  bottom: _selection == false
                      ? MusicListHeader(
                          musiclist: songs.length <= 0 ? [] : songs,
                          onSelect: () {
                            setState(() {
                              _selection = !_selection;
                            });
                          })
                      : _SelectionHeader(
                          allSelected: _selectedAll,
                          onTap: (BuildContext ctx) {
                            //全选
                            SelectionNotification(!_selectedAll).dispatch(ctx);
                            if (_selectedAll) {
                              setState(() {
                                _selectedList.addAll(songs);
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
                  flexibleSpace: _RecommendDetailHeader(
                    onSelect: () {
                      setState(() {
                        _selection = !_selection;
                      });
                    },
                  ),
                ),
                _selection == false
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return songs.length <= 0
                                ? Center(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  )
                                : MusicTitle(
                                    songs,
                                    pageContext: widget.pageContext,
                                  );
                          },
                          childCount: 1,
                        ),
                      )
                    : SliverSelection(
                        musiclist: songs,
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
                            if (_selectedList.length == songs.length) {
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
                                    print(_selectedList.length);
                                    // 下一首播放
                                    List<Music> lists = [];
                                    _selectedList.forEach((Music music) {
                                      lists.add(music);
                                    });
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
  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: <Widget>[
      Image.network(
        'http://p2.music.126.net/LGSZ3rGT8Ux1pYxcwxnR-g==/2225411534621328.jpg',
        fit: BoxFit.cover,
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(color: Colors.black.withOpacity(0.4)),
      ),
    ]);
  }
}

class _RecommendDetailHeader extends StatelessWidget {
  _RecommendDetailHeader({this.onSelect});
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return FlexibleDetailBar(
        background: _BlurBackground(),
        content: _buildContent(context),
        builder: (context, t) {
          return AppBar(
            title: Text(t > 0.5 ? '每日推荐' : ''),
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            actions: store.player.playingList.length <= 0
                ? []
                : <Widget>[
                    IconButton(
                        icon: Icon(Icons.equalizer),
                        tooltip: "播放器",
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return AlbumCoverPage();
                          }));
                        })
                  ],
          );
        });
  }

  Widget _buildContent(BuildContext context) {
    var _day = DateTime.now().day;
    var _month = DateTime.now().month;

    return DefaultTextStyle(
      style: TextStyle(
          fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Row(
              children: <Widget>[
                Text(
                  _day < 10 ? '0$_day' : _day,
                  style: TextStyle(fontSize: 32.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('/'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(_month < 10 ? '0$_month' : _month),
                ),
              ],
            )),
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
  const MusicListHeader({Key key, this.tail, this.musiclist, this.onSelect})
      : super(key: key);
  final Widget tail;
  final List<Music> musiclist;
  final VoidCallback onSelect;

  Widget _buildSmallWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      height: 20.0,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 62.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 22.0,
                height: 22.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                                width: 2.0)),
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      child: Container(
                        width: 4.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 22.0,
                height: 22.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.4),
                                width: 2.0)),
                      ),
                    ),
                    Positioned(
                      right: 10.0,
                      child: Container(
                        width: 4.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0))),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        ClipRRect(
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
                      Routes.router
                          .navigateTo(context, '/albumcoverpage?isNew=true');
                    }
                  } else {
                    Routes.router
                        .navigateTo(context, '/albumcoverpage?isNew=true');
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
                      Text("播放全部",
                          style: TextStyle(
                              color: Theme.of(context).textTheme.body1.color,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600)),
                      Padding(padding: EdgeInsets.only(left: 2)),
                      Spacer(),
                      InkWell(
                        onTap: this.onSelect == null ? null : this.onSelect,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.list),
                            Text(
                              '多选',
                              style: TextStyle(fontSize: 13.0),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      )
                    ],
                  ),
                )),
          ),
        ),
        Positioned(
          // left: 120.0,
          left: 0.0,
          top: -6.0,
          child: _buildSmallWidget(context),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class SelectionNotification extends Notification {
  SelectionNotification(this.selectedAll);
  final bool selectedAll;
}
