import 'package:flutter/material.dart';
import '../../../model/music.dart';
import './music_item.dart';
import '../../../repository/netease.dart';
import '../../../components/song_detail_dialog.dart';
import '../../../components/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/musicplayer/inherited_demo.dart';

class MusicTitle extends StatelessWidget {
  final List<Music> songList;

  // final StateContainerState store;
  final BuildContext pageContext;
  MusicTitle(this.songList, {this.pageContext});

  // 获取歌曲论数量
  getSongComment(int id) async {
    var result = await NeteaseRepository.getSongComment(id);
    return result;
  }

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  // 获取单曲详情
  _getSongDetail(int id) async {
    Map<String, dynamic> songDetail = {};
    var result = await NeteaseRepository.getSongDetail(id);
    var comment = await getSongComment(id);
    songDetail.addAll(
        {'detail': result['songs'][0], 'commentCount': comment['total']});
    return songDetail;
  }

  List<Widget> _buildWidget(BuildContext context, StateContainerState store) {
    List<Widget> widgetList = [];
    songList.asMap().forEach((int index, Music item) {
      widgetList.add(MusicItem(
        item,
        isSelect: true,
        tailsList: item.mvId == 0
            ? [
                {
                  'iconData': Icons.more_vert,
                  'iconPress': () async {
                    var res = await _getSongDetail(item.id);
                    var _url = await _getSongUrl(item.id);
                    item.commentCount = res['commentCount'];
                    item.detail = res['detail'];
                    var detail = item.detail;
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
                                  'leadingIcon':
                                      AntDesign.getIconData('playcircleo'),
                                  'title': '下一首播放',
                                  'callback': _url == null
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
                                  'title': '评论(${item.commentCount})',
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
                                            thumbnail: detail['al']['picUrl'],
                                            title:
                                                '${detail['name']}（${detail['al']['name']}）',
                                            description:
                                                '${detail['ar'][0]['name']}',
                                            transaction: "music",
                                            musicUrl: detail['songUrl'],
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
                                            thumbnail: detail['picUrl'],
                                            scene: fluwx.WeChatScene.SESSION,
                                            title:
                                                '${detail['name']}（${detail['al']['name']}）',
                                            description:
                                                '${detail['ar'][0]['name']}',
                                            transaction: "music",
                                            musicUrl: detail['songUrl'],
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
                                  'title': '歌手：${detail['ar'][0]['name']}',
                                  'callback': () {}
                                },
                                {
                                  'leadingIcon':
                                      AntDesign.getIconData('adduser'),
                                  'title': '专辑：${detail['al']['name']}',
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
                              ]);
                        });
                  }
                }
              ]
            : [
                {'iconData': Icons.play_circle_outline, 'iconPress': () {}},
                {
                  'iconData': Icons.more_vert,
                  'iconPress': () async {
                    var res = await _getSongDetail(item.id);
                    var _url = await _getSongUrl(item.id);
                    item.commentCount = res['commentCount'];
                    item.detail = res['detail'];
                    var detail = item.detail;
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
                                  'leadingIcon':
                                      AntDesign.getIconData('playcircleo'),
                                  'title': '下一首播放',
                                  'callback': _url == null
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
                                  'title': '评论(${item.commentCount})',
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
                                            thumbnail: detail['al']['picUrl'],
                                            title:
                                                '${detail['name']}（${detail['al']['name']}）',
                                            description:
                                                '${detail['ar'][0]['name']}',
                                            transaction: "music",
                                            musicUrl: detail['songUrl'],
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
                                            thumbnail: detail['picUrl'],
                                            scene: fluwx.WeChatScene.SESSION,
                                            title:
                                                '${detail['name']}（${detail['al']['name']}）',
                                            description:
                                                '${detail['ar'][0]['name']}',
                                            transaction: "music",
                                            musicUrl: detail['songUrl'],
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
                                  'title': '歌手：${detail['ar'][0]['name']}',
                                  'callback': () {}
                                },
                                {
                                  'leadingIcon':
                                      AntDesign.getIconData('adduser'),
                                  'title': '专辑：${detail['al']['name']}',
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
                              ]);
                        });
                  }
                }
              ],
        pageContext: this.pageContext,
        onTap: () {
          // 播放音乐
          print('播放音乐');
        },
      ));
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(context, store),
    );
  }
}
