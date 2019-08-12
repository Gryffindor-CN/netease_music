import 'package:flutter/material.dart';
import 'package:netease_music/components/album/album_item.dart';
import 'package:netease_music/components/bottom_share.dart';
import 'package:netease_music/components/music/music_item.dart';
import 'package:netease_music/components/music/music_item_list.dart';
import 'package:netease_music/components/musicplayer/inherited_demo.dart';
import 'package:netease_music/components/musicplayer/player.dart';
import 'package:netease_music/components/song_detail_dialog.dart';
import 'package:netease_music/components/songlist_list/song_list_list.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/pages/album/album_cover.dart';
import 'package:netease_music/pages/artist/artist_page.dart';
import 'package:netease_music/repository/netease.dart';
import 'package:netease_music/router/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:sticky_headers/sticky_headers.dart';


class LocalPage extends StatefulWidget {
  @override
  LocalPageState createState() => LocalPageState();
}

class LocalPageState extends State<LocalPage> with SingleTickerProviderStateMixin{

  TabController _tabController;

  ScrollController _scrollController;

  final TextEditingController _searchMusicController = new TextEditingController();
  final TextEditingController _searchArtistController = new TextEditingController();
  final TextEditingController _searchAlbumController = new TextEditingController();

  Map data;

  List<Artist> artists = [];

  List<Album> albums = [];

  @override
  void initState() {
    super.initState();
    this.data = {
      "songTotal":1,
      "liveTotal":0,
      "videoTotal":0,
      "songList":[
        {
          "id": 347230,
          "name":"海阔天空",
          "aritstName":"Beyond",
          "albumName":"海阔天空",
          "commentCount": 500,
          "picUrl":"https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
          "songUrl":"http://m7.music.126.net/20190809122221/1353d63392de65d5693c8f4ebf92bac6/ymusic/b1c4/b5de/74d0/9158ae4873e10b743790320db9ef9b29.mp3",
          "al":{
            "picUrl":"https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "name":"海阔天空",
            "albumCoverImg": "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "publishTime": 746812800000,
            "size": 10,
          },
          "ar":[
            {"name":"Beyond"}
          ],

        },
      ]
    };

    artists.add(Artist(
      id: 11127,
      albumSize: 0,
      mvSize: 0,
      name: "Beyond",
      imageUrl: "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
      alias: [

      ],
      briefDesc: "testtest",
      followed: true,
    ));

    albums.add(Album(
        id: 34209,
        name: "海阔天空",
        coverImageUrl: "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
        publishTime: 746812800000,
        size: 10
    ));

    _scrollController = ScrollController()..addListener(_scrollListener);
    _tabController = new TabController(initialIndex:0,length: 3,vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2.0) {

    }
  }

  @override
  Widget build(BuildContext context) {

    final store = StateContainer.of(context);

    return new Scaffold(

      appBar: new AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        bottomOpacity: 0,
        title: Container(
          child: Row(

            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              Expanded(
                flex: 1,
                child: Center(),
              ),
              Expanded(
                flex: 10,
                child: new TabBar(
                  indicator: const BoxDecoration(),
                  tabs: <Widget>[
                    Text("单曲"),
                    Text("节目"),
                    Text("MV"),
                  ],
                  controller: _tabController,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(),
              ),
            ],
          ),
        ),
        actions: (store.player != null && store.player.playingList.length > 0)
            ? <Widget>[
          IconButton(
            onPressed: () {
//              Routes.router
//                  .navigateTo(widget.pageContext, '/albumcoverpage');
            },
            icon: Icon(Icons.equalizer),
          )
        ]
            : [],
      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new DefaultTabController(
            length: 3,
            child: new Scaffold(
              appBar: new AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title: new TabBar(
                  labelPadding: EdgeInsets.all(0),
                  indicatorPadding: EdgeInsets.only(left: 15, bottom: 0, right: 15),
                  indicatorWeight: 1,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text("歌曲"),
                            ),
                          ),
                          Text('|', style: TextStyle(color: Colors.grey, fontSize: 20,fontWeight: FontWeight.w100))
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text("歌手"),
                            ),
                          ),
                          Text('|', style: TextStyle(color: Colors.grey, fontSize: 20,fontWeight: FontWeight.w100))
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text("专辑"),
                            ),
                          ),
                          Text(' ', style: TextStyle(color: Color(0xffd0d0d0), fontSize: 23))
                        ],
                      ),
                    ),
                  ],
                  indicatorColor: Colors.white,
                ),
              ),
              body: new TabBarView(
                children: [
                  _buildMusic(store),
                  _buildArtist(),
                  _buildAlbum(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
            child: Center(
              child: Text('下载的节目会出现在这里'),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.fromSTEB(0,0,0,0),
            child: Center(
              child: Text('下载的MV会出现在这里'),
            ),
          ),
        ],
      ),

    );
  }

  _buildMusic(store){
    return ListView.builder(
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return MusicItemList(
          keyword: "123asd",
          titleWidget: Column(
            children: <Widget>[
              TextField(
                textInputAction: TextInputAction.send,
                keyboardType: TextInputType.multiline,
//                      maxLength: 135,
                maxLines: 3,
                minLines: 1,
                controller: _searchMusicController,
                onChanged: (value) {
                },
                decoration: InputDecoration(
                  hintText: '搜索本地歌曲',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: Color(0x96999999),
                  ),

                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,

                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(
                            color: Color(0xFFE0E0E0), width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: GestureDetector(
                        onTap: () async {
                          await store.playMultis(null);
                          if (store.player.isPlaying == true) {
                            var res = await MyPlayer.player.stop();
                            if (res == 1) {
                            }
                          } else {
                          }
                        },
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.play_circle_outline),
                              Padding(
                                padding:
                                EdgeInsets.only(left: 12.0),
                                child: Text(
                                  '播放全部',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .title
                                        .fontSize,
                                  ),
                                ),
                              ),
                              Text('（共${data['songTotal']}首）',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Theme.of(context)
                                          .textTheme
                                          .subtitle
                                          .color))
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () {
//                                setState(() {
//                                  _selection = !_selection;
//                                });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.list),
                            Text(
                              '多选',
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          list: _buildMusicList(store),
        );
      },
      itemCount: 1,
    );
  }

  List<MusicItem> _buildMusicList(StateContainerState store){
    List<MusicItem> _widgetlist = [];

    List<dynamic> songList = data['songList'];

    songList.forEach((song){
      Music item = Music(
        name: song['name'],
        id: song['id'],
        aritstName: song['aritstName'],
        aritstId: 11127,
        albumName: song['al']['name'],
        albumId: 34209,
        commentCount: song['commentCount'],
        albumCoverImg: song['al']['albumCoverImg'],
        album: Album(
          id: 34209,
          name: song['al']['name'],
          coverImageUrl: song['al']['albumCoverImg'],
          publishTime: 746812800000,
          size: 10,
        ),
      );
      MusicItem musicItem = MusicItem(
        item,
        underline: false,
        tailsList:[
          {
            'iconData': Icons.more_vert,
            'iconPress': () async {

              var songUrl = song['songUrl'];
              var commentCount = song['commentCount'];

              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SongDetailDialog(
                      song['name'],
                      song['albumName'],
                      song['aritstName'],
                      song['picUrl'],
                      "",
                      [
                        {
                          'leadingIcon':
                          AntDesign.getIconData('playcircleo'),
                          'title': '下一首播放',
                          'callback': songUrl == null
                              ? null
                              : () async {
                            await store.playInsertNext(item);
                            Fluttertoast.showToast(
                              msg: '已添加到播放列表',
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('plussquareo'),
                          'title': '收藏到歌单',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('download'),
                          'title': '下载',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('message1'),
                          'title': '评论($commentCount)',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('sharealt'),
                          'title': '分享',
                          'callback': () {
                            Navigator.of(context).pop();
                            BottomShare.showBottomShare(context, [
                              {
                                'shareLogo':
                                'assets/icons/friend_circle_32.png',
                                'shareText': '微信朋友圈',
                                'shareEvent': () {
                                  var model =
                                  fluwx.WeChatShareMusicModel(
                                    scene: fluwx.WeChatScene.TIMELINE,
                                    thumbnail: song['al']['picUrl'],
                                    title:
                                    '${song['name']}（${song['al']['name']}）',
                                    description:
                                    '${song['ar'][0]['name']}',
                                    transaction: "music",
                                    musicUrl: song['songUrl'],
                                  );

                                  fluwx.share(model);
                                }
                              },
                              {
                                'shareLogo':
                                'assets/icons/wechat_32.png',
                                'shareText': '微信好友',
                                'shareEvent': () {
                                  var model =
                                  fluwx.WeChatShareMusicModel(
                                    thumbnail: song['picUrl'],
                                    scene: fluwx.WeChatScene.SESSION,
                                    title:
                                    '${song['name']}（${song['al']['name']}）',
                                    description:
                                    '${song['ar'][0]['name']}',
                                    transaction: "music",
                                    musicUrl: song['songUrl'],
                                  );

                                  fluwx.share(model);
                                }
                              },
                              {
                                'shareLogo':
                                'assets/icons/qq_zone_32.png',
                                'shareText': 'QQ空间',
                                'shareEvent': () {}
                              },
                              {
                                'shareLogo':
                                'assets/icons/qq_friend_32.png',
                                'shareText': 'QQ好友',
                                'shareEvent': () {}
                              },
                              {
                                'shareLogo':
                                'assets/icons/weibo_32.png',
                                'shareText': '微薄',
                                'shareEvent': () {}
                              },
                              {
                                'shareLogo':
                                'assets/icons/qq_friend_32.png',
                                'shareText': '大神圈子',
                                'shareEvent': () {}
                              }
                            ]);
                          }
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('adduser'),
                          'title': '歌手：${song['ar'][0]['name']}',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('adduser'),
                          'title': '专辑：${song['al']['name']}',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('youtube'),
                          'title': '查看视频',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('barchart'),
                          'title': '人气榜应援',
                          'callback': () {}
                        },
                        {
                          'leadingIcon':
                          AntDesign.getIconData('delete'),
                          'title': '删除',
                          'callback': () {}
                        }
                      ]
                  );
                },
              );
            },

          }
        ],
      );

      _widgetlist.add(musicItem);
    });

    return _widgetlist;
  }

  _buildArtist(){
    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: _buildArtistContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildArtistContent(BuildContext context) {
    List<Widget> _widgetlist = [];

    _widgetlist.add(TextField(
      textInputAction: TextInputAction.send,
      keyboardType: TextInputType.multiline,
//                      maxLength: 135,
      maxLines: 3,
      minLines: 1,
      controller: _searchArtistController,
      onChanged: (value) {
      },
      decoration: InputDecoration(
        hintText: '搜索歌手',
        hintStyle: TextStyle(
          fontSize: 13,
          color: Color(0x96999999),
        ),

        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,

      ),
    ));

    artists
      ..asMap().forEach((int index, item) {
        _widgetlist.add(InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ArtistPage(item.id);
            }));
          },
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(backgroundImage: NetworkImage(item.imageUrl)),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            item.name,
                            style: TextStyle(
//                              color: Color(0xff0c73c2),
                              fontSize: 16
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          item.alias.length > 0
                              ? Text('（${item.alias[0]}）')
                              : Text('')
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "50 首",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      });

    return _widgetlist;
  }

  _buildAlbum(){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: _guildAlbumContent(),
        ),
      ),
    );
  }

  _guildAlbumContent(){
    List<Widget> _widgetList = [];
    _widgetList.add(TextField(
      textInputAction: TextInputAction.send,
      keyboardType: TextInputType.multiline,
//                      maxLength: 135,
      maxLines: 3,
      minLines: 1,
      controller: _searchAlbumController,
      onChanged: (value) {
      },
      decoration: InputDecoration(
        hintText: '搜索专辑',
        hintStyle: TextStyle(
          fontSize: 13,
          color: Color(0x96999999),
        ),

        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,

      ),
    ));
    albums.asMap().forEach((int index, album) {
      _widgetList.add(
          AlbumItem(album, context, onTap: () {
        print(0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return AlbumCover(album.id);
        }));
      })
      );
    });
    return _widgetList;
  }
}
