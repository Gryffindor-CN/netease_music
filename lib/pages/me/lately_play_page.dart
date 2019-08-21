import 'package:flutter/material.dart';
import 'package:netease_music/components/bottom_share.dart';
import 'package:netease_music/components/music/music_item.dart';
import 'package:netease_music/components/music/music_item_list.dart';
import 'package:netease_music/components/musicplayer/inherited_demo.dart';
import 'package:netease_music/components/musicplayer/player.dart';
import 'package:netease_music/components/song_detail_dialog.dart';
import 'package:netease_music/components/songlist_list/song_list_list.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/router/Routes.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:sticky_headers/sticky_headers.dart';
import '../../utils/utils.dart';

class LatelyPlayPage extends StatefulWidget {
  @override
  MeHomePageState createState() => MeHomePageState();
}

class MeHomePageState extends State<LatelyPlayPage> {
  Map data;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    this.data = {
      "songTotal": 1,
      "liveTotal": 0,
      "videoTotal": 0,
      "songList": [
        {
          "id": 347230,
          "name": "海阔天空",
          "aritstName": "Beyond",
          "albumName": "海阔天空",
          "commentCount": 500,
          "mvid": 376199,
          "picUrl":
              "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
          "songUrl":
              "http://m7.music.126.net/20190809122221/1353d63392de65d5693c8f4ebf92bac6/ymusic/b1c4/b5de/74d0/9158ae4873e10b743790320db9ef9b29.mp3",
          "al": {
            "id": 34209,
            "picUrl":
                "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "name": "海阔天空",
            "albumCoverImg":
                "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "publishTime": 746812800000,
            "size": 10,
          },
          "ar": [
            {"name": "Beyond", "id": 11127}
          ],
          "detail": {
            "name": "海阔天空",
            "id": 347230,
            "pst": 0,
            "t": 0,
            "ar": [
              {"id": 11127, "name": "Beyond", "tns": [], "alias": []}
            ],
            "alia": [],
            "pop": 100,
            "st": 0,
            "rt": "600902000004240302",
            "fee": 8,
            "v": 31,
            "crbt": null,
            "cf": "",
            "al": {
              "id": 34209,
              "name": "海阔天空",
              "picUrl":
                  "https://p2.music.126.net/QHw-RuMwfQkmgtiyRpGs0Q==/102254581395219.jpg",
              "tns": [],
              "pic": 102254581395219
            },
            "dt": 326348,
            "h": {"br": 320000, "fid": 0, "size": 13070578, "vd": 0.109906},
            "m": {"br": 160000, "fid": 0, "size": 6549371, "vd": 0.272218},
            "l": {"br": 96000, "fid": 0, "size": 3940469, "vd": 0.228837},
            "a": null,
            "cd": "1",
            "no": 1,
            "rtUrl": null,
            "ftype": 0,
            "rtUrls": [],
            "djId": 0,
            "copyright": 1,
            "s_id": 0,
            "mark": 0,
            "mst": 9,
            "cp": 7002,
            "mv": 376199,
            "rtype": 0,
            "rurl": null,
            "publishTime": 746812800000
          },
        },
      ]
    };
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2.0) {}
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: new Text('最近播放'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 1.0,
            tabs: [
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("歌曲"),
                    Text(
                      this.data['songTotal'] == 0
                          ? ''
                          : ' ${this.data['songTotal']}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("直播"),
                    Text(
                      this.data['liveTotal'] == 0
                          ? ''
                          : ' ${this.data['liveTotal']}',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("视频"),
                    Text(
                      this.data['videoTotal'] == 0
                          ? ''
                          : ' ${this.data['videoTotal']}',
                      style: TextStyle(fontSize: 11),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
              ),
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("其他"),
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
          // title: Text('Tabs Demo'),
        ),
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: TabBarView(
            children: [
              ListView.builder(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return StickyHeader(
                    header: Container(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
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
                                    if (res == 1) {}
                                  } else {}
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.play_circle_outline),
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.0),
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
                    ),
                    content: Column(
                      children: <Widget>[
                        MusicItemList(
                          keyword: "123asd",
                          list: _buildList(store, context),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: 1,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Text("暂无播放记录"),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                    child: Text("暂无播放记录"),
                  ),
                ],
              ),
              SongListList(),
            ],
          ),
        ),
      ),
    );
  }

  List<MusicItem> _buildList(StateContainerState store, mainContext) {
    List<MusicItem> _widgetlist = [];

    List<dynamic> songList = data['songList'];

    songList.forEach((song) {
      Music item = Music(
          name: song['name'],
          id: song['id'],
          aritstName: song['ar'][0]['name'],
          aritstId: song['ar'][0]['id'],
          albumName: song['al']['name'],
          albumId: song['al']['id'],
          albumCoverImg: song['al']['albumCoverImg'],
          detail: song['detail'],
          commentCount: song['commentCount'],
          mvId: song['mvid'],
          album: Album(
              id: song['al']['id'],
              name: song['al']['name'],
              coverImageUrl: song['al']['albumCoverImg']),
          artists: [
            Artist(
                id: song['ar'][0]['id'],
                name: song['ar'][0]['name'],
                imageUrl: '')
          ]);
      MusicItem musicItem = MusicItem(
        item,
        showBottomLine: false,
        tailsList: [
          {
            'iconData': Icons.more_vert,
            'iconPress': () async {
              var songUrl = song['songUrl'];
              var commentCount = song['commentCount'];

              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SongDetailDialog(song['name'], song['albumName'],
                      song['aritstName'], song['picUrl'], "", [
                    {
                      'leadingIcon': AntDesign.getIconData('playcircleo'),
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
                      'leadingIcon': AntDesign.getIconData('plussquareo'),
                      'title': '收藏到歌单',
                      'callback': () {}
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('download'),
                      'title': '下载',
                      'callback': () {}
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('message1'),
                      'title': '评论($commentCount)',
                      'callback': () {
                        var picUrl =
                            song['picUrl'].toString().replaceAll('/', ')');
                        String url =
                            '/commentpage?type=0&id=${song['id']}&name=${FluroConvertUtils.fluroCnParamsEncode(song['name'])}&author=${FluroConvertUtils.fluroCnParamsEncode(song['ar'][0]['name'])}&imageUrl=$picUrl';

                        Routes.router.navigateTo(mainContext, url);
                      }
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('sharealt'),
                      'title': '分享',
                      'callback': () {
                        Navigator.of(context).pop();
                        BottomShare.showBottomShare(context, [
                          {
                            'shareLogo': 'assets/icons/friend_circle_32.png',
                            'shareText': '微信朋友圈',
                            'shareEvent': () {
                              var model = fluwx.WeChatShareMusicModel(
                                scene: fluwx.WeChatScene.TIMELINE,
                                thumbnail: song['al']['picUrl'],
                                title: '${song['name']}（${song['al']['name']}）',
                                description: '${song['ar'][0]['name']}',
                                transaction: "music",
                                musicUrl: song['songUrl'],
                              );

                              fluwx.share(model);
                            }
                          },
                          {
                            'shareLogo': 'assets/icons/wechat_32.png',
                            'shareText': '微信好友',
                            'shareEvent': () {
                              var model = fluwx.WeChatShareMusicModel(
                                thumbnail: song['picUrl'],
                                scene: fluwx.WeChatScene.SESSION,
                                title: '${song['name']}（${song['al']['name']}）',
                                description: '${song['ar'][0]['name']}',
                                transaction: "music",
                                musicUrl: song['songUrl'],
                              );

                              fluwx.share(model);
                            }
                          },
                          {
                            'shareLogo': 'assets/icons/qq_zone_32.png',
                            'shareText': 'QQ空间',
                            'shareEvent': () {}
                          },
                          {
                            'shareLogo': 'assets/icons/qq_friend_32.png',
                            'shareText': 'QQ好友',
                            'shareEvent': () {}
                          },
                          {
                            'shareLogo': 'assets/icons/weibo_32.png',
                            'shareText': '微薄',
                            'shareEvent': () {}
                          },
                          {
                            'shareLogo': 'assets/icons/qq_friend_32.png',
                            'shareText': '大神圈子',
                            'shareEvent': () {}
                          }
                        ]);
                      }
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('adduser'),
                      'title': '歌手：${song['ar'][0]['name']}',
                      'callback': () {}
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('adduser'),
                      'title': '专辑：${song['al']['name']}',
                      'callback': () {}
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('youtube'),
                      'title': '查看视频',
                      'callback': () {}
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('barchart'),
                      'title': '人气榜应援',
                      'callback': () {}
                    },
                    {
                      'leadingIcon': AntDesign.getIconData('delete'),
                      'title': '删除',
                      'callback': () {}
                    }
                  ]);
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
}
