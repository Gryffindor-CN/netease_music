import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'dart:convert';
import '../../components/selection/select_all.dart';
import '../../model/music.dart';
import './music_item.dart';
import '../../components/song_detail_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../components/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class SearchSongTab extends StatefulWidget {
  final String keyword;
  SearchSongTab({@required this.keyword});
  @override
  SearchSongTabState createState() => SearchSongTabState();
}

class SearchSongTabState extends State<SearchSongTab> {
  bool _isLoading = true;
  bool _selection = false;
  List<Music> songs = []; // 单曲

  @override
  void initState() {
    super.initState();
    _getSongs();
  }

  // 获取歌曲论数量
  getSongComment(int id) async {
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/comment/music?id=$id");
      var result = json.decode(response.toString());
      return result;
    } catch (e) {
      print(e);
    }
  }

  // 获取单曲详情
  _getSongDetail(int id) async {
    Map<String, dynamic> songDetail = {};
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/song/detail?ids=$id");
      var result = json.decode(response.toString());
      await getSongComment(id).then((data) {
        songDetail.addAll(
            {'detail': result['songs'][0], 'commentCount': data['total']});
      });
      return songDetail;
    } catch (e) {
      print(e);
    }
  }

// 获取歌曲播放url
  _getSongUrl(int id) async {
    try {
      Response response =
          await Dio().get("http://192.168.206.133:3000/song/url?id=$id");
      var data = json.decode(response.toString())['data'][0];
      return data['url'];
    } catch (e) {
      print(e);
    }
  }

  void _getSongs() async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/search?keywords=${widget.keyword}");
      var songRes = json.decode(response.toString())['result']['songs'];

      await songRes.asMap().forEach((int index, item) async {
        var res = await _getSongDetail(item['id']);
        setState(() {
          songs.add(
            Music(
                name: item['name'],
                id: item['id'],
                aritstName: item['artists'][0]['name'],
                aritstId: item['artists'][0]['id'],
                albumName: item['album']['name'],
                albumId: item['album']['id'],
                detail: res['detail'],
                commentCount: res['commentCount']),
          );
        });
        if (songs.length == songRes.asMap().length) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildSongList() {
    List<Widget> widgetItems = [];
    List<Widget> clearItems = [
      Theme(
        data: ThemeData(
          iconTheme: IconThemeData(color: Color(0xffd4d4d4)),
        ),
        child: GestureDetector(
          onTap: () {
            // todo 清除播放记录
            _clearPlayRecords(context, () {
              setState(() {
                songs.clear();
              });
            });
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 50.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.transparent))),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.delete_outline),
                Text(
                  '清除播放记录',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle.color,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      )
    ];

    if (songs.length > 0) {
      songs.map((item) {
        widgetItems.add(MusicItem(item, widget.keyword, tailsList: [
          {'iconData': Icons.play_circle_outline, 'iconPress': () {}},
          {
            'iconData': Icons.more_vert,
            'iconPress': () async {
              var detail = item.detail;
              var commentCount = item.commentCount;
              var res = await _getSongUrl(detail['id']);

              detail['songUrl'] = res;
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SongDetailDialog(
                        detail['name'],
                        detail['al']['name'],
                        detail['ar'][0]['name'],
                        detail['al']['picUrl'],
                        detail['alia'].length == 0
                            ? ''
                            : '（${detail['alia'][0]}）',
                        [
                          {
                            'leadingIcon': AntDesign.getIconData('playcircleo'),
                            'title': '下一首播放',
                            'callback': null
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
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('sharealt'),
                            'title': '分享',
                            'callback': () {
                              Navigator.of(context).pop();
                              BottomShare.showBottomShare(context, [
                                {
                                  'shareLogo':
                                      'assets/icons/friend_circle_32.png',
                                  'shareText': '微信朋友圈',
                                  'shareEvent': () {
                                    var model = fluwx.WeChatShareMusicModel(
                                      scene: fluwx.WeChatScene.TIMELINE,
                                      thumbnail: detail['al']['picUrl'],
                                      title:
                                          '${detail['name']}（${detail['al']['name']}）',
                                      description: '${detail['ar'][0]['name']}',
                                      transaction: "music",
                                      musicUrl: detail['songUrl'],
                                    );

                                    fluwx.share(model);
                                  }
                                },
                                {
                                  'shareLogo': 'assets/icons/wechat_32.png',
                                  'shareText': '微信好友',
                                  'shareEvent': () {
                                    var model = fluwx.WeChatShareMusicModel(
                                      thumbnail: detail['picUrl'],
                                      scene: fluwx.WeChatScene.SESSION,
                                      title:
                                          '${detail['name']}（${detail['al']['name']}）',
                                      description: '${detail['ar'][0]['name']}',
                                      transaction: "music",
                                      musicUrl: detail['songUrl'],
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
                            'title': '歌手：${detail['ar'][0]['name']}',
                            'callback': () {}
                          },
                          {
                            'leadingIcon': AntDesign.getIconData('adduser'),
                            'title': '专辑：${detail['al']['name']}',
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
                  });
            }
          }
        ]));
      }).toList();
    }

    return Column(
      children: widgetItems..addAll(clearItems),
    );
  }

  Widget buildSongsWidget() {
    return _isLoading == true
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ))
        : songs.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '暂无播放记录',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle.color),
                  ),
                ))
            : ListView.builder(
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
                                  onTap: () {},
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
                                        Text('（共${songs.length}首）',
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
                                    setState(() {
                                      _selection = !_selection;
                                    });
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
                          _buildSongList(),
                        ],
                      ));
                },
                itemCount: 1,
              );
  }

  void _onSongsDelete(val) {
    setState(() {
      val.forEach((item) {
        var _index = songs.indexOf(item);
        songs.removeAt(_index);
      });
      _selection = !_selection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !_selection
        ? buildSongsWidget()
        : SelectAll(
            songs: songs,
            handleSongsDel: (val) => _onSongsDelete(val),
            handleFinish: () {
              setState(() {
                _selection = false;
              });
            });
  }
}

void _clearPlayRecords(BuildContext ctx, VoidCallback callback) {
  showCupertinoModalPopup(
    context: ctx,
    builder: (BuildContext context) => CupertinoActionSheet(
        message: const Text('确定清除播放记录？'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              '清除',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              callback();
              Navigator.pop(context, '清除');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('取消'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, '取消');
          },
        )),
  );
}

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
