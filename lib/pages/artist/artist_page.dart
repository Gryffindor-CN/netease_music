import 'package:flutter/material.dart';
import '../../model/model.dart';
import '../../repository/netease.dart';
import './flexible_app_bar.dart';
import 'dart:ui';
import './music_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './album_list.dart';

/// 歌手详情信息 header 高度
const double HEIGHT_HEADER = 260 + 56.0;

class ArtistPage extends StatefulWidget {
  ArtistPage(this.id, {this.pageContext});
  final int id;
  final BuildContext pageContext;
  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage>
    with SingleTickerProviderStateMixin {
  List<Music> _hotSongs = [];
  Artist _artist;
  TabController _tabController;
  int _tabIndex = 0;
  List<Widget> _widgetContent = [];

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 0, vsync: this, length: 4);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
    getArtistInfos();
  }

  Future<bool> _doSubscribeChanged(bool subscribe) async {
    int succeed;
    succeed = await NeteaseRepository.subcribeAritst(!subscribe, _artist.id);
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

  void getArtistInfos() async {
    var result = await NeteaseRepository.getAritst(widget.id);

    setState(() {
      result['hotSongs'].asMap().forEach((int index, item) {
        _hotSongs.add(Music(
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
      _artist = Artist(
          id: result['artist']['id'],
          name: result['artist']['name'],
          imageUrl: result['artist']['picUrl'],
          alias: result['artist']['alias'],
          albumSize: result['artist']['albumSize'],
          mvSize: result['artist']['mvSize'],
          briefDesc: result['artist']['briefDesc'],
          followed: result['artist']['followed']);
    });
    _widgetContent = [
      SongsWrapper(hotSongs: _hotSongs),
      AlbumWrapper(id: _artist.id, size: _artist.albumSize)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            pinned: true,
            expandedHeight: HEIGHT_HEADER,
            flexibleSpace: _ArtistDetailHeader(
              _artist,
              doSubscribeChanged: _doSubscribeChanged,
            ),
            bottom: _ArtistsHeader(
              albumSize: _artist != null ? _artist.albumSize : 0,
              mvSize: _artist != null ? _artist.mvSize : 0,
              briefDesc: _artist != null ? _artist.briefDesc : '',
              controller: _tabController,
              tabIndex: _tabIndex,
            ),
          ),
          _artist == null
              ? SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20.0),
                      child: CircularProgressIndicator(),
                    );
                  }, childCount: 1),
                )
              : _widgetContent[_tabIndex]
        ],
      ),
    );
  }
}

class _ArtistListHeader extends StatelessWidget {
  _ArtistListHeader({Key key, this.len}) : super(key: key);
  final int len;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.add_box),
                SizedBox(
                  width: 4.0,
                ),
                Text(
                  '收藏热门',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                ),
                Text(
                  '$len',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                )
              ],
            ),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: <Widget>[
                  Text(
                    '管理',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
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

class _ArtistDetailHeader extends StatelessWidget {
  _ArtistDetailHeader(this.artist, {this.doSubscribeChanged});

  final Artist artist;
  final Future<bool> Function(bool currentState) doSubscribeChanged;

  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
      background:
          _BlurBackground(imageUrl: artist == null ? null : artist.imageUrl),
      content: artist == null ? Center() : _buildContent(context),
      builder: (context, t) => AppBar(
            title: Text(
              t > 0.9 ? '${artist.name}（${artist.alias[0]}）' : '',
              style: TextStyle(fontSize: 18.0),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.share), tooltip: "分享", onPressed: () {}),
              IconButton(
                  icon: Icon(Icons.equalizer), tooltip: "播放", onPressed: () {})
            ],
          ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.white, fontSize: 20.0),
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                artist != null
                    ? Text('${artist.name}（${artist.alias[0]}）')
                    : Text(''),
                _SubscribeButton(artist.followed, this.doSubscribeChanged)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _SubscribeButton extends StatefulWidget {
  final bool followed;

  final Future<bool> Function(bool currentState) doFollowChanged;

  const _SubscribeButton(this.followed, this.doFollowChanged, {Key key})
      : super(key: key);

  @override
  _SubscribeButtonState createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<_SubscribeButton> {
  bool followed = false;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    followed = widget.followed;
  }

  @override
  Widget build(BuildContext context) {
    if (!followed) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: Container(
          height: 28,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor.withOpacity(0.5),
            Theme.of(context).primaryColor
          ])),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final result = await widget.doFollowChanged(followed);

                setState(() {
                  followed = result;
                  loading = false;
                });
              },
              child: Row(
                children: <Widget>[
                  SizedBox(width: 14),
                  loading == true
                      ? Container(
                          width: 12.0,
                          height: 12.0,
                          margin: EdgeInsets.only(right: 4.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white.withOpacity(0.4)),
                          ),
                        )
                      : Icon(
                          Icons.add,
                          color: Theme.of(context).primaryIconTheme.color,
                          size: 20.0,
                        ),
                  SizedBox(width: 4),
                  Text(
                    "收藏",
                    style: TextStyle(
                        fontSize: 12.0,
                        color: Theme.of(context).primaryTextTheme.body1.color),
                  ),
                  SizedBox(width: 13),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(
                    color: Colors.white.withOpacity(0.4), width: 1.0)),
            child: Row(
              children: <Widget>[
                SizedBox(width: 12),
                loading == true
                    ? Container(
                        margin: EdgeInsets.only(right: 4.0),
                        width: 12.0,
                        height: 12.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.4)),
                        ),
                      )
                    : Icon(Icons.check,
                        size: 14, color: Colors.white.withOpacity(0.4)),
                SizedBox(width: 4),
                Text("已收藏",
                    style: TextStyle(
                        fontSize: 12.0, color: Colors.white.withOpacity(0.4))),
                SizedBox(width: 12),
              ],
            ),
          ),
          onTap: () async {
            setState(() {
              loading = true;
            });
            final result = await widget.doFollowChanged(followed);

            setState(() {
              followed = result;
              loading = false;
            });
          });
    }
  }
}

class _ArtistsHeader extends StatelessWidget implements PreferredSizeWidget {
  const _ArtistsHeader(
      {Key key,
      this.albumSize = 0,
      this.mvSize = 0,
      this.briefDesc = '',
      this.controller,
      this.tabIndex})
      : super(key: key);
  final int albumSize;
  final int mvSize;
  final String briefDesc;
  final TabController controller;
  final int tabIndex;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shadowColor: Colors.transparent,
        child: SizedBox.fromSize(
          size: preferredSize,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
            child: _ArtistsTab(
              albumSize: albumSize,
              mvSize: mvSize,
              controller: controller,
              tabIndex: tabIndex,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}

class _ArtistsTab extends StatefulWidget {
  const _ArtistsTab(
      {Key key, this.albumSize, this.mvSize, this.controller, this.tabIndex})
      : super(key: key);
  final int albumSize;
  final int mvSize;
  final TabController controller;
  final int tabIndex;

  @override
  _ArtistsTabState createState() => _ArtistsTabState();
}

class _ArtistsTabState extends State<_ArtistsTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext contexty) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: TabBar(
        indicatorColor: Theme.of(context).primaryColor,
        labelColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
        controller: widget.controller,
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Theme.of(context).textTheme.body1.color,
        onTap: (int index) {
          print(index);
        },
        tabs: <Widget>[
          Text(
            '热门单曲',
          ),
          RichText(
            text: TextSpan(
              text: '专辑',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.tabIndex == 1
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.body1.color),
              children: <TextSpan>[
                TextSpan(
                  text: '${widget.albumSize}',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: widget.tabIndex == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: '视频',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: widget.tabIndex == 2
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.body1.color),
              children: <TextSpan>[
                TextSpan(
                    text: '${widget.mvSize}',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: widget.tabIndex == 2
                            ? Theme.of(context).primaryColor
                            : Colors.grey)),
              ],
            ),
          ),
          Text(
            '艺人信息',
          ),
        ],
      ),
    );
  }
}

class _BlurBackground extends StatelessWidget {
  final String imageUrl;
  const _BlurBackground({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: imageUrl == null
          ? <Widget>[
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(color: Colors.black.withOpacity(0.4)),
              )
            ]
          : <Widget>[
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(color: Colors.black.withOpacity(0.4)),
              )
            ],
    );
  }
}

class SongsWrapper extends StatelessWidget {
  SongsWrapper({
    Key key,
    this.hotSongs,
  }) : super(key: key);
  final List<Music> hotSongs;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: <Widget>[
            _ArtistListHeader(len: hotSongs.length),
            MusicTitle(
              hotSongs,
              // pageContext: widget.pageContext,
            )
          ],
        );
      }, childCount: hotSongs.length),
    );
  }
}

class AlbumWrapper extends StatefulWidget {
  AlbumWrapper({Key key, this.id, this.size}) : super(key: key);
  final int id;
  final int size;

  @override
  _AlbumWrapperState createState() => _AlbumWrapperState();
}

class _AlbumWrapperState extends State<AlbumWrapper>
    with AutomaticKeepAliveClientMixin {
  List<Album> _hotAlbums = [];

  @override
  void initState() {
    super.initState();
    getAlbumsInfos();
  }

  void getAlbumsInfos() async {
    var result = await NeteaseRepository.getAritstAlbums(10, widget.id);

    setState(() {
      result.asMap().forEach((int index, item) {
        _hotAlbums.add(Album(
            name: item['name'],
            id: item['id'],
            coverImageUrl: item['picUrl'],
            publishTime: item['publishTime'],
            size: item['size']));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _hotAlbums.length <= 0
        ? SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20.0),
                child: CircularProgressIndicator(),
              );
            }, childCount: 1),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20.0),
                child: AlbumTitle(_hotAlbums),
              );
            }, childCount: widget.size),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
