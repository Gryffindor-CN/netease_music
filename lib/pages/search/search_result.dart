import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../../router/Routes.dart';
import '../../components/musicplayer/inherited_demo.dart';
import './search_songs.dart';
import './search_album.dart';
import '../../model/music.dart';
import './search_playlist.dart';
import '../../repository/netease.dart';
import './playlist_section.dart';
import './song_section.dart';
import './search_artist.dart';
import './search_video.dart';

class SearchResult extends StatefulWidget {
  final String keyword;
  final BuildContext pageContext;
  SearchResult({this.keyword, this.pageContext});

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
              commentCount: res['commentCount'],
              mvId: item['mvid']),
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
                    child: SongSection(widget.keyword, songs,
                        tabController: _tabController,
                        store: store,
                        pageContext: widget.pageContext),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    child: PlaylistSection(
                      widget.keyword,
                      playlist,
                      tabController: _tabController,
                      showTitle: true,
                    ),
                  )
                ],
              ),
      ),
      SearchSongTab(
        keyword: widget.keyword,
        pageContext: widget.pageContext,
      ),
      SearchVideoTab(
        keyword: widget.keyword,
      ),
      SearchArtistTab(
        widget.keyword,
      ),
      SearchAlbumTab(
        keyword: widget.keyword,
      ),
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '综合',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '单曲',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '视频',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '歌手',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '专辑',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '歌单',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '主播电台',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '用户',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
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

// 歌单

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
