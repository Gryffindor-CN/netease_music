import 'package:flutter/material.dart';
import 'package:netease_music/components/bottom_share.dart';
import 'package:netease_music/components/music/music_item.dart';
import 'package:netease_music/components/music/music_item_list.dart';
import 'package:netease_music/components/musicplayer/inherited_demo.dart';
import 'package:netease_music/components/musicplayer/player.dart';
import 'package:netease_music/components/song_detail_dialog.dart';
import 'package:netease_music/components/songlist_list/song_list_list.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/repository/netease.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:sticky_headers/sticky_headers.dart';


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
      "songTotal":1,
      "liveTotal":0,
      "videoTotal":0,
      "songList":[
        {
          "id": 347230,
          "name":"龙的传人",
          "aritstName":"成龙",
          "albumName":"中国红",
          "commentCount": 500,
          "picUrl":"https://p1.music.126.net/klOSGBRQhevtM6c9RXrM1A==/18808245906527670.jpg",
          "songUrl":"http://m7.music.126.net/20190809122221/1353d63392de65d5693c8f4ebf92bac6/ymusic/b1c4/b5de/74d0/9158ae4873e10b743790320db9ef9b29.mp3",
          "al":{
            "picUrl":"123",
            "name":"龙歌",
            "albumCoverImg": "https://p1.music.126.net/6y-UleORITEDbvrOLV0Q8A==/5639395138885805.jpg",
            "publishTime": 746812800000,
            "size": 10,
          },
          "ar":[
            {"name":"成龙"}
          ],

        }
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
    if (_scrollController.position.extentAfter < 2.0) {

    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: new Text('最近播放'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Row(
                  children: <Widget>[
                    Text("歌曲"),
                    Text(
                      this.data['songTotal'] == 0?'':' ${this.data['songTotal']}',
                      style: TextStyle(
                        fontSize: 11
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
                    Text("直播"),
                    Text(
                      this.data['liveTotal'] == 0?'':' ${this.data['liveTotal']}',
                      style: TextStyle(
                          fontSize: 11
                      ),
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
                      this.data['videoTotal'] == 0?'':' ${this.data['videoTotal']}',
                      style: TextStyle(
                          fontSize: 11
                      ),
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
          // title: Text('Tabs Demo'),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return StickyHeader(
                  header: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Container(
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
                  ),
                  content: Column(
                    children: <Widget>[
                      MusicItemList(
                        keyword: "123asd",
                        list: _buildList(store),
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
    );
  }

  List<MusicItem> _buildList(StateContainerState store){
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

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }
}
