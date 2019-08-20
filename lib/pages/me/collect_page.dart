import 'package:flutter/material.dart';
import 'package:netease_music/components/album/album_item.dart';
import 'package:netease_music/components/musicplayer/inherited_demo.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/pages/album/album_cover.dart';
import 'package:netease_music/repository/netease.dart';
import 'package:netease_music/router/Routes.dart';

import 'collect_artist_page.dart';
import 'collect_video_page.dart';

class CollectPage extends StatefulWidget {
  @override
  CollectPageState createState() => CollectPageState();
}

class CollectPageState extends State<CollectPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _isLoading = true;
  List<Album> albumList = [];
  int tabBarLength = 5;
  Map count = {
    "albumCount": 0,
    "artistCount": 0,
    "videoCount": 0,
    "specialCount": 0,
    "mlogCount": 0,
  };

  @override
  void initState() {
    super.initState();

    _tabController =
        new TabController(initialIndex: 0, length: tabBarLength, vsync: this);

    if (this.mounted) {
      _getAlbums();
      _getCount();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _getCount() async {
    var albums = await NeteaseRepository.getAlbumSubList();
    count['albumCount'] = albums['data'].asMap().length;

    var artists = await NeteaseRepository.getArtistSublist();
    count['artistCount'] = artists['count'];

    var videos = await NeteaseRepository.getVideoSublist();
    count['videoCount'] = videos['count'];
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return new Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("我的收藏"),
        bottom: TabBar(
          indicatorColor: Colors.white,
          indicatorWeight: 1.0,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Row(
                children: <Widget>[
                  Text("专辑"),
                  SizedBox(
                    width: 2.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                    child: Text(
                      this.count['albumCount'] == 0
                          ? ''
                          : '${count['albumCount']}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            Tab(
              child: Row(
                children: <Widget>[
                  Text("歌手"),
                  SizedBox(
                    width: 2.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                    child: Text(
                      this.count['artistCount'] == 0
                          ? ''
                          : '${count['artistCount']}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            Tab(
              child: Row(
                children: <Widget>[
                  Text("视频"),
                  SizedBox(
                    width: 2.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                    child: Text(
                      this.count['videoCount'] == 0
                          ? ''
                          : '${count['videoCount']}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            Tab(
              child: Row(
                children: <Widget>[
                  Text("专栏"),
                  SizedBox(
                    width: 2.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                    child: Text(
                      this.count['specialCount'] == 0
                          ? ''
                          : '${count['specialCount']}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
            Tab(
              child: Row(
                children: <Widget>[
                  Text("Mlog"),
                  SizedBox(
                    width: 2.0,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                    child: Text(
                      this.count['mlogCount'] == 0
                          ? ''
                          : '${count['mlogCount']}',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
              ),
            ),
          ],
        ),
        actions: (store.player != null && store.player.playingList.length > 0)
            ? <Widget>[
                IconButton(
                  onPressed: () {
                    Routes.router.navigateTo(context, '/albumcoverpage');
                  },
                  icon: Icon(Icons.equalizer),
                )
              ]
            : [],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildAlbum(),
          CollectArtistPage(),
          CollectVideoPage(),
          _buildSpecial(),
          _buildMlog(),
        ],
      ),
    );
  }

  _buildAlbum() {
    return _isLoading == true
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ))
        : albumList.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '暂无歌单信息',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle.color),
                  ),
                ))
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: _buildContent(albumList),
                  ),
                ),
              );
  }

  void _getAlbums() async {
    var albums = await NeteaseRepository.getAlbumSubList();
    if (this.mounted) {
      setState(() {
        albums['data'].asMap().forEach((int index, item) {
          albumList.add(Album(
            name: item['name'],
            id: item['id'],
            coverImageUrl: item['picUrl'],
            size: item['size'],
            artist: item['artists'][0]['name'],
          ));
        });
      });
      if (albumList.length == albums['data'].asMap().length) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<Widget> _buildContent(List<Album> albums) {
    List<Widget> _widgetList = [];
    _widgetList.add(Container(
      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 0, 0),
      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "收藏的专辑",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          Text(
            "(3)",
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    ));
    albums.asMap().forEach((int index, album) {
      _widgetList.add(AlbumItem(
        album,
        context,
        onTap: () {
          print(0);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AlbumCover(album.id);
          }));
        },
        showPublishTime: false,
        showArtist: true,
      ));
    });
    return _widgetList;
  }

  _buildSpecial() {
    return Center(
      child: Text("暂无收藏"),
    );
  }

  _buildMlog() {
    return Center(
      child: Text("暂无收藏"),
    );
  }
}
