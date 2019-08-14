import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/musicplayer/inherited_demo.dart';
import '../../router/Routes.dart';
import '../../components/main/main_playlist.dart';
import '../../repository/netease.dart';
import '../../model/music.dart';

class MeHomePage extends StatefulWidget {
  @override
  MeHomePageState createState() => MeHomePageState();
}

class MeHomePageState extends State<MeHomePage>
    with AutomaticKeepAliveClientMixin {
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
            builder = (_, __, ___) => MeHomeContainer(
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

class MeHomeContainer extends StatefulWidget {
  final BuildContext pageContext;
  MeHomeContainer({Key key, this.pageContext}) : super(key: key);

  @override
  MeHomeContainerState createState() => MeHomeContainerState();
}

class MeHomeContainerState extends State<MeHomeContainer> {
  List<PlayList> _createdLists = [];
  List<PlayList> _likedLists = [];

  @override
  void initState() {
    _getUserPlaylist(1788319348);
    super.initState();
  }

  void _getUserPlaylist(int userId) async {
    var playlist = await NeteaseRepository.getUserPlaylist(userId);
    if (this.mounted) {
      setState(() {
        playlist.asMap().forEach((int index, item) {
          if (item['creator']['userId'] == 1788319348) {
            _createdLists.add(PlayList(
                name: item['name'],
                id: item['id'],
                playCount: item['playCount'],
                trackCount: item['trackCount'],
                nickName: item['creator']['nickname'],
                coverImgUrl: item['coverImgUrl']));
          } else {
            _likedLists.add(PlayList(
                name: item['name'],
                id: item['id'],
                playCount: item['playCount'],
                trackCount: item['trackCount'],
                nickName: item['creator']['nickname'],
                coverImgUrl: item['coverImgUrl']));
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(Icons.cloud_queue),
        centerTitle: true,
        title: Text('我的音乐'),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TabSection(),
            CollectionSection(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 6.0,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
            ),
            PlaylistSection(
              createdList: _createdLists,
              likedList: _likedLists,
            )
          ],
        ),
      ),
    );
  }
}

class PlaylistSection extends StatelessWidget {
  PlaylistSection({Key key, this.createdList, this.likedList})
      : super(key: key);
  final List<PlayList> createdList;
  final List<PlayList> likedList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: Column(children: <Widget>[
        PlaylistList(
          title: '我创建的歌单',
          playlists: createdList,
        ),
        PlaylistList(
          title: '我收藏的歌单',
          playlists: likedList,
        )
      ]),
    );
  }
}

class TabSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: Theme.of(context).iconTheme.copyWith(
                size: 20.0,
                color: Colors.white,
              )),
      child: DefaultTextStyle(
        style: TextStyle(
            fontSize: 11.0, color: Theme.of(context).textTheme.display1.color),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
          padding: EdgeInsets.only(top: 20.0),
          width: MediaQuery.of(context).size.width,
          height: 95.0,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabSectionItem(
                    title: '私人FM',
                    iconData: Icons.radio,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '最新电音',
                    iconData: Icons.calendar_today,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: 'Sati空间',
                    iconData: Icons.calendar_today,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '私藏推荐',
                    iconData: Icons.favorite,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '亲子频道',
                    iconData: Icons.child_care,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '古典专区',
                    iconData: Icons.format_paint,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '跑步FM',
                    iconData: Icons.directions_run,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '小冰电台',
                    iconData: Icons.calendar_today,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '爵士电台',
                    iconData: Icons.audiotrack,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '驾驶模式',
                    iconData: Icons.local_taxi,
                    onTap: () {},
                  ),
                  TabSectionItem(
                    title: '因乐交友',
                    iconData: Icons.favorite,
                    onTap: () {},
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class TabSectionItem extends StatelessWidget {
  TabSectionItem({
    Key key,
    this.title,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
              child: Icon(
                iconData,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }
}

class CollectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      height: 220.0,
      child: Column(
        children: <Widget>[
          CounterSectionItem(
            title: '本地音乐',
            iconData: Icons.music_note,
            onTap: (){
              Routes.router.navigateTo(context, '/mymusic/local');
            },
          ),
          CounterSectionItem(
            title: '最近播放',
            iconData: Icons.music_note,
            onTap: (){
              Routes.router.navigateTo(context, '/mymusic/latelyplay');
            },
          ),
          CounterSectionItem(
            title: '我的电台',
            iconData: Icons.music_note,
          ),
          CounterSectionItem(
            title: '我的收藏',
            iconData: Icons.music_note,
            onTap: (){
              Routes.router.navigateTo(context, '/mymusic/collect');
            },
          ),
        ],
      ),
    );
  }
}



class CounterSectionItem extends StatelessWidget {
  CounterSectionItem({
    Key key,
    this.title,
    this.iconData,
    this.onTap,
    this.count = 0,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final VoidCallback onTap;
  final int count;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap == null ? null : this.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 66.0,
              child: Icon(iconData),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 10.0, 12.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      this.title,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${this.count}',
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.display1.color),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).textTheme.subtitle.color,
                        )
                      ],
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
