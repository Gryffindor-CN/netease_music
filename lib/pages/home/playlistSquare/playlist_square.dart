import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../model/music.dart';
import '../../../components/musicplayer/inherited_demo.dart';
import '../../../utils/utils.dart';
import '../../../repository/netease.dart';
import '../../playlist/playlist.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PlaylistSquare extends StatefulWidget {
  PlaylistSquare({this.pageContext});
  final BuildContext pageContext;
  _PlaylistSquareState createState() => _PlaylistSquareState();
}

class _PlaylistSquareState extends State<PlaylistSquare>
    with TickerProviderStateMixin {
  List<PlayList> playlist = []; // 歌单
  List<Widget> _viewWidget = [];
  bool _isLoading = true;
  TabController _tabController;
  int _tabIndex = 0;

  void _getTopPlaylist() async {
    setState(() {
      _isLoading = true;
    });
    var _playlist = await NeteaseRepository.getTopPlaylist();
    _playlist.forEach((item) {
      setState(() {
        playlist.add(PlayList(
          name: item['name'],
          id: item['id'],
          coverImgUrl: item['coverImgUrl'],
          playCount: item['playCount'],
          trackCount: item['trackCount'],
          creatorName: item['creator']['nickname'],
        ));
      });
      if (playlist.length == _playlist.length) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 6)
      ..addListener(tabListener);
    _getTopPlaylist();
  }

  tabListener() {
    setState(() {
      _tabIndex = _tabController.index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(tabListener);
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    _viewWidget = [
      _isLoading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Axis.vertical,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 240,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                offset: Offset(0.0, -30.0),
                                blurRadius: 20,
                              )
                            ]),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        child: Image.network(
                                      playlist[index].coverImgUrl,
                                      fit: BoxFit.fill,
                                    )),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2.0, horizontal: 10.0),
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(4.0))),
                                      child: Text(
                                        playlist[index].name,
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                        itemCount: playlist.length,
                        itemWidth: 180.0,
                        layout: SwiperLayout.STACK,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    fit: FlexFit.loose,
                    child: GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 0,
                      ),
                      children: List.generate(playlist.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          child: Image.network(
                                            playlist[index].coverImgUrl,
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
                                          color: Theme.of(context)
                                              .primaryIconTheme
                                              .color,
                                          size: 12),
                                      SizedBox(
                                        width: 1.0,
                                      ),
                                      Text(
                                          getFormattedNumber(
                                              playlist[index].playCount),
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
                  )
                ],
              ),
            ),
      Container(),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单广场'),
        elevation: 0.0,
        centerTitle: true,
        actions: (store.player != null && store.player.playingList.length > 0)
            ? <Widget>[
                IconButton(
                  icon: Icon(Icons.equalizer),
                  onPressed: () {},
                )
              ]
            : [],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 1.0,
          isScrollable: true,
          tabs: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '推荐',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '官方',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '精品',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '华语',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '流行',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                '摇滚',
                style: TextStyle(fontSize: 14.0),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
        decoration: BoxDecoration(color: Colors.white),
        child: _viewWidget[_tabIndex],
      ),
    );
  }
}
