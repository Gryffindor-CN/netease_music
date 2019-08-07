import 'package:flutter/material.dart';
import '../../model/music.dart';
import '../../repository/netease.dart';
import '../../components/musicplayer/inherited_demo.dart';
import '../../router/Routes.dart';
import '../../pages/playlist/playlist.dart';

const List<int> top_list = [3, 0, 1, 2, 991319590]; // [飙升榜、新歌榜、热歌榜、原创歌曲榜、说唱榜]
const List<int> recommend_list = [21, 20, 18, 13, 14, 15];

class RankingListPage extends StatefulWidget {
  final BuildContext pageContext;
  RankingListPage({Key key, this.pageContext}) : super(key: key);

  @override
  _RankingListPageState createState() => _RankingListPageState();
}

class _RankingListPageState extends State<RankingListPage> {
  List<RankingState> _rankinglist = [];
  List<RankingState> _rapRankinglist = [];
  List<RankingState> _recommendRankinglist = [];
  List<dynamic> _list = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTopListAll();
  }

  // 所有榜单
  _getTopListAll() async {
    setState(() {
      isLoading = true;
    });
    var result = await NeteaseRepository.getTopListAll();
    result.forEach((item) {
      _list.add(item);
    });
    if (_list.length == result.length) {
      top_list.forEach((value) {
        if (value == top_list[top_list.length - 1]) {
          _getRapRanklistDetail(value);
        } else {
          _getTopListDetail(value);
        }
      });
      recommend_list.forEach((value) {
        _getRecommendListDetail(value);
      });
    }
  }

  // 获取说唱榜详情
  _getRapRanklistDetail(int id) async {
    String _updateFrequency = '';
    List<Music> _musiclist = [];
    var _playlist = await NeteaseRepository.getPlaylistDetail(id);
    var _tracks = _playlist['tracks'];
    if (_tracks.length > 3) {
      _tracks = _playlist['tracks'].sublist(0, 3);
    }
    _list.forEach((item) {
      if (item['id'] == _playlist['id']) {
        _updateFrequency = item['updateFrequency'];
      }
    });
    _tracks.forEach((item) {
      _musiclist.add(Music(name: item['name']));
    });
    setState(() {
      _rapRankinglist.add(RankingState(
          id: _playlist['id'],
          name: _playlist['name'],
          coverImageUrl: _playlist['coverImgUrl'],
          updateFrequency: _updateFrequency,
          musiclist: _musiclist));
    });
    if (_rankinglist.length +
            _rapRankinglist.length +
            _recommendRankinglist.length ==
        top_list.length + recommend_list.length) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 官方榜单详情
  _getTopListDetail(int idx) async {
    String _updateFrequency = '';
    List<Music> _musiclist = [];
    var _playlist = await NeteaseRepository.getTopList(idx);
    var _tracks = _playlist['tracks'];
    if (_tracks.length > 3) {
      _tracks = _playlist['tracks'].sublist(0, 3);
    }
    _list.forEach((item) {
      if (item['id'] == _playlist['id']) {
        _updateFrequency = item['updateFrequency'];
      }
    });
    _tracks.forEach((item) {
      _musiclist.add(Music(name: item['name']));
    });

    setState(() {
      _rankinglist.add(RankingState(
          idx: idx,
          id: _playlist['id'],
          name: _playlist['name'],
          coverImageUrl: _playlist['coverImgUrl'],
          updateFrequency: _updateFrequency,
          musiclist: _musiclist));
    });
    if (_rankinglist.length +
            _rapRankinglist.length +
            _recommendRankinglist.length ==
        top_list.length + recommend_list.length) {
      setState(() {
        isLoading = false;
      });
    }
  }

  // 推荐榜详情
  _getRecommendListDetail(int idx) async {
    String _updateFrequency = '';
    List<Music> _musiclist = [];
    var _playlist = await NeteaseRepository.getTopList(idx);
    var _tracks = _playlist['tracks'];
    if (_tracks.length > 3) {
      _tracks = _playlist['tracks'].sublist(0, 3);
    }
    _list.forEach((item) {
      if (item['id'] == _playlist['id']) {
        _updateFrequency = item['updateFrequency'];
      }
    });
    _tracks.forEach((item) {
      _musiclist.add(Music(name: item['name']));
    });

    setState(() {
      _recommendRankinglist.add(RankingState(
          idx: idx,
          id: _playlist['id'],
          name: _playlist['name'],
          coverImageUrl: _playlist['coverImgUrl'],
          updateFrequency: _updateFrequency,
          musiclist: _musiclist));
    });
    if (_rankinglist.length +
            _rapRankinglist.length +
            _recommendRankinglist.length ==
        top_list.length + recommend_list.length) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('排行榜'),
        actions: (store.player != null && store.player.playingList.length > 0)
            ? <Widget>[
                IconButton(
                  onPressed: () {
                    Routes.router
                        .navigateTo(widget.pageContext, '/albumcoverpage');
                  },
                  icon: Icon(Icons.equalizer),
                )
              ]
            : [],
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[
                    RankingListContainer(
                      title: '江小白YOLO云音乐说唱榜',
                      rankinglist: _rapRankinglist,
                      type: 'vertical',
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RankingListContainer(
                      title: '官方榜',
                      rankinglist: _rankinglist,
                      type: 'vertical',
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RankingListContainer(
                      title: '推荐榜',
                      rankinglist: _recommendRankinglist,
                      type: 'horizontal',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class RankingListContainer extends StatelessWidget {
  RankingListContainer(
      {Key key, this.title, this.rankinglist, @required this.type})
      : super(key: key);
  final List<RankingState> rankinglist;
  final String title;
  final String type;

  Widget _buildContent(BuildContext context) {
    Widget _content;
    switch (type) {
      case 'vertical':
        List<Widget> _widgetlist = [];
        _widgetlist.add(Container(
          margin: EdgeInsets.only(top: 6.0),
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ));
        rankinglist.forEach((RankingState ranking) {
          _widgetlist.add(RankingListItem(
            ranking: ranking,
          ));
        });
        _content = Column(
          children: _widgetlist,
        );
        break;
      case 'horizontal':
        List<Widget> _widgetlist = [];
        _widgetlist.add(Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 15.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
          ),
        ));
        _widgetlist.add(
          Container(
              height: 340.0,
              margin: EdgeInsets.only(top: 6.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  childAspectRatio: 0.82,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                children: List.generate(rankinglist.length, (index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return rankinglist[index].idx != null
                            ? Playlists(rankinglist[index].idx, 'ranking')
                            : Playlists(rankinglist[index].id, 'playlist');
                      }));
                    },
                    child: Container(
                      height: 180,
                      child: Column(children: [
                        Container(
                          width: 110.0,
                          height: 110.0,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              child: Image.network(
                                rankinglist[index].coverImageUrl,
                              )),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Container(
                          width: 110.0,
                          child: Text(
                            rankinglist[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        )
                      ]),
                    ),
                  );
                }),
              )),
        );
        _content = Container(
          child: Column(
            children: _widgetlist,
          ),
        );
        break;
    }
    return _content;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }
}

class RankingListItem extends StatelessWidget {
  RankingListItem({Key key, this.ranking}) : super(key: key);
  final RankingState ranking;

  List<Widget> _buildMusiclist(BuildContext context) {
    List<Widget> _widgetlist = [];
    this.ranking.musiclist.asMap().forEach((int index, Music music) {
      _widgetlist.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          '${index + 1}. ${music.name}',
          style: TextStyle(
              fontSize: 13.0, color: Theme.of(context).textTheme.title.color),
        ),
      ));
    });
    return _widgetlist;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ranking.idx != null
              ? Playlists(ranking.idx, 'ranking')
              : Playlists(ranking.id, 'playlist');
        }));
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        child: Row(children: [
          Stack(
            children: <Widget>[
              Container(
                width: 110.0,
                height: 110.0,
                margin: EdgeInsets.only(right: 15.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    child: Image.network(
                      ranking.coverImageUrl,
                    )),
              ),
              Positioned(
                left: 4.0,
                bottom: 4.0,
                child: Text(
                  ranking.updateFrequency,
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
              )
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildMusiclist(context),
            ),
          )
        ]),
      ),
    );
  }
}

class RankingState {
  RankingState(
      {this.idx,
      this.id,
      this.name,
      this.coverImageUrl,
      this.updateFrequency,
      this.musiclist});
  final int idx;
  final int id;
  final String name;
  final String coverImageUrl;
  final String updateFrequency;
  final List<Music> musiclist;
}
