import 'dart:async';
import 'package:flutter/material.dart';
import 'package:netease_music/components/musicplayer/inherited_demo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../components/netease_toast.dart';
import '../../router/Routes.dart';
import '../../repository/netease.dart';
import '../search/search.dart';
import '../../utils/utils.dart';
import '../playlist/playlist.dart';

class RefreshIndicators extends StatefulWidget {
  RefreshIndicators({this.showToastCb, this.pageContext});
  final BuildContext pageContext;
  final VoidCallback showToastCb;

  @override
  _RefreshIndicatorState createState() => _RefreshIndicatorState();
}

class _RefreshIndicatorState extends State<RefreshIndicators> {
  RefreshController _refreshController;
  ScrollController _scrollController;
  List<PlaylistItem> playlistItem = [];
  List banners = [];
  void _init() async {
    await _doLogin();
    _getRecommendResource();
    _getBanner();
  }

  Future<dynamic> _doLogin() async {
    await NeteaseRepository.doLogin();
  }

  Future<bool> _getRecommendResource() async {
    var recommend = await NeteaseRepository.getRecommendResource();
    if (recommend == null) {
      return false;
    }
    recommend.removeAt(recommend.length - 1);
    setState(() {
      recommend.asMap().forEach((int index, recommendItem) {
        playlistItem.add(PlaylistItem(
            recommendItem['id'],
            recommendItem['name'],
            recommendItem['picUrl'],
            recommendItem['playcount']));
      });
    });
    return true;
  }

  void _getBanner() async {
    var res = await NeteaseRepository.getBanner();
    setState(() {
      banners = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _scrollController = ScrollController(initialScrollOffset: 50.0);
    _init();
  }

  void _onRefresh() async {
    var res = await _getRecommendResource();
    print('res:$res');
    if (res == true) {
      _refreshController.refreshCompleted();
      widget.showToastCb();
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(
//        decoration: BoxDecoration(
//            color: Theme.of(context).primaryColor,
//            border: Border.all(color: Theme.of(context).primaryColor)),
        refreshStyle: RefreshStyle.Follow,
        completeText: '',
        releaseText: '',
        refreshingText: '',
        idleText: '',
        idleIcon: Icon(
          Icons.ac_unit,
          color: Colors.white,
        ),
        releaseIcon: Icon(
          Icons.cached,
          color: Colors.white,
        ),
        failedIcon: Icon(Icons.sms_failed),
        completeIcon: const Icon(Icons.done, color: Colors.white),
        refreshingIcon: SizedBox(
          width: 25.0,
          height: 25.0,
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0x64ffff)),
          ),
        ),
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(bottom: BorderSide(color: Colors.transparent))),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border(
                                top: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: .0))),
                        width: MediaQuery.of(context).size.width,
                        height: 40.0,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            width: MediaQuery.of(context).size.width,
                            height: 138.0,
                            child: banners.length <= 0
                                ? Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0x9bffffff)),
                                    ),
                                  )
                                : Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            12.0, 0.0, 12.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Container(
                                              child: Image.network(
                                            banners[index]['imageUrl'],
                                            fit: BoxFit.fill,
                                          )),
                                        ),
                                      );
                                    },
                                    itemCount: banners.length,
                                    autoplay: true,
                                    pagination: SwiperPagination(),
                                  ),
                          ),
                          DefaultTextStyle(
                            style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color,
                                fontSize: 12.0),
                            child: Container(
                                margin: EdgeInsets.only(top: 20.0),
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFE0E0E0),
                                            width: 0.5))),
                                width: MediaQuery.of(context).size.width,
                                height: 80.0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(builder:
                                        //         (BuildContext context) {
                                        //   return RecommendSongs();
                                        // }));
                                        Routes.router.navigateTo(context,
                                            '/home/recommandSongs/recommandsongspage');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 42.0,
                                            height: 42.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Stack(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.white,
                                                ),
                                                Positioned(
                                                  left: 9.0,
                                                  top: 8.0,
                                                  child: Text(
                                                    '${DateTime.now().day}',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text('每日推荐')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 42.0,
                                            height: 42.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Icon(
                                              Icons.music_video,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text('歌单')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(builder:
                                        //         (BuildContext context) {
                                        //   return RankingListPage();
                                        // }));
                                        Routes.router.navigateTo(
                                            context, '/home/rankinglistpage');
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 42.0,
                                            height: 42.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Icon(
                                              Icons.equalizer,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text('排行榜')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 42.0,
                                            height: 42.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Icon(
                                              Icons.radio,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text('电台')
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 44.0,
                                            height: 44.0,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            child: Icon(
                                              Icons.local_laundry_service,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 6.0,
                                          ),
                                          Text('直播')
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  _PlaylistSquare(
                    playlist: playlistItem,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NeteaseHome extends StatefulWidget {
  @override
  NeteaseHomeState createState() => NeteaseHomeState();
}

class NeteaseHomeState extends State<NeteaseHome>
    with AutomaticKeepAliveClientMixin {
  bool isShow = false;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        RoutePageBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (_, __, ___) => NeteaseHomeContainer(
                  pageContext: context,
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return PageRouteBuilder(
          pageBuilder: builder,
        );
      },
    );
  }
}

class NeteaseHomeContainer extends StatefulWidget {
  final BuildContext pageContext;
  NeteaseHomeContainer({Key key, this.pageContext}) : super(key: key);

  @override
  NeteaseHomeContainerState createState() => NeteaseHomeContainerState();
}

class NeteaseHomeContainerState extends State<NeteaseHomeContainer> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(Icons.mic),
        centerTitle: true,
        title: InkWell(
          onTap: () {
            // Routes.router.navigateTo(context, '/home/searchpage');
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return SearchPage(
                pageContext: widget.pageContext,
              );
            }));
          },
          splashColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: 250.0,
            height: 36.0,
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.white24,
                  size: 22.0,
                )
              ],
            ),
          ),
        ),
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
      body: NeteaseToast(
        toastText: '已为你推荐新的个性化内容!!!',
        showToast: isShow,
        child: RefreshIndicators(
          showToastCb: () {
            setState(() {
              isShow = true;
            });
          },
          pageContext: widget.pageContext,
        ),
      ),
    );
  }
}

class Item extends StatefulWidget {
  final String title;

  Item({this.title});
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Center(
        child: Text(widget.title),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// 歌单广场
class _PlaylistSquare extends StatelessWidget {
  _PlaylistSquare({Key key, @required this.playlist}) : super(key: key);
  final List<PlaylistItem> playlist;

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '推荐歌单',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
        ),
        InkWell(
          onTap: () {
            // 歌单广场
            Routes.router
                .navigateTo(context, '/home/playlistsquare/playlistsquarepage');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                border: Border.all(color: Color(0xFFE0E0E0), width: 1.0)),
            child: Text('歌单广场', style: TextStyle(fontSize: 12.0)),
          ),
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return playlist.length <= 0
        ? Container(
            height: 340.0,
            decoration: BoxDecoration(color: Colors.white),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: 340.0,
            child: GridView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                childAspectRatio: 0.7,
                crossAxisSpacing: 1,
                mainAxisSpacing: 0,
              ),
              children: List.generate(playlist.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Playlists(playlist[index].id, 'playlist');
                    }));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 110.0,
                              height: 110.0,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  child: Image.network(
                                    playlist[index].picUrl,
                                  )),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Container(
                              width: 110.0,
                              child: Text(
                                playlist[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 2.0,
                        right: 16.0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(Icons.play_arrow,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                  size: 12),
                              SizedBox(
                                width: 1.0,
                              ),
                              Text(
                                  getFormattedNumber(playlist[index].playCount),
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
                );
              }),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          _buildTitle(context),
          SizedBox(
            height: 14.0,
          ),
          _buildContent(context)
        ],
      ),
    );
  }
}

class PlaylistItem {
  int id;
  String name;
  String picUrl;
  int playCount;
  PlaylistItem(this.id, this.name, this.picUrl, this.playCount);
}
