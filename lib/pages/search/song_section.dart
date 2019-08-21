import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/musicplayer/player.dart';
import '../../components/song_detail_dialog.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../components/bottom_share.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import '../../components/music/music_item.dart';
import '../../components/music/music_item_list.dart';
import '../../model/music.dart';
import '../../components/musicplayer/inherited_demo.dart';
import '../../repository/netease.dart';
import '../../router/Routes.dart';
import '../artist/artist_page.dart';
import '../album/album_cover.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../redux/app.dart';

class SongSection extends StatelessWidget {
  final String keyword;
  final List<Music> songList;
  final TabController tabController;
  final StateContainerState store;
  final BuildContext pageContext;
  SongSection(this.keyword, this.songList,
      {this.tabController, this.store, this.pageContext});
  static Widget _nameWidget;
  static Widget _albumnameWidget;

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  List<MusicItem> _buildList(BuildContext context, VoidCallback cb) {
    List<MusicItem> _widgetlist = [];
    songList.asMap().forEach((int index, Music music) {
      _widgetlist.add(MusicItem(music,
          keyword: this.keyword,
          sortIndex: index + 1,
          tailsList: music.mvId == 0
              ? [
                  {
                    'iconData': Icons.more_vert,
                    'iconPress': () async {
                      var detail = music.detail;
                      var commentCount = music.commentCount;
                      var res = await _getSongUrl(detail['id']);

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
                                    'callback': res == null
                                        ? null
                                        : () async {
                                            await store.playInsertNext(music);
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
                                    'callback': () {
                                      cb();
                                    }
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
                                    'callback': () {
                                      var picUrl = Uri.encodeComponent(music.albumCoverImg);
                                      String url = '/commentpage?type=0&id=${music.id}&name=${music.name}&author=${music.aritstName}&imageUrl=$picUrl';
                                      url = Uri.encodeFull(url);
                                      Routes.router.navigateTo(context, url);
                                    }
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
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return ArtistPage(music.artists[0].id);
                                      }));
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('adduser'),
                                    'title': '专辑：${detail['al']['name']}',
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return AlbumCover(music.album.id);
                                      }));
                                    }
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
                      var detail = music.detail;
                      var commentCount = music.commentCount;
                      var res = await _getSongUrl(detail['id']);

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
                                    'callback': res == null
                                        ? null
                                        : () async {
                                            await store.playInsertNext(music);
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
                                    'callback': () {
                                      cb();
                                    }
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
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return ArtistPage(music.artists[0].id);
                                      }));
                                    }
                                  },
                                  {
                                    'leadingIcon':
                                        AntDesign.getIconData('adduser'),
                                    'title': '专辑：${detail['al']['name']}',
                                    'callback': () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) {
                                        return AlbumCover(music.album.id);
                                      }));
                                    }
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
                ]));
    });

    return _widgetlist;
  }

  Widget _buildTitle() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
            child: InkResponse(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: tabController != null
                    ? () {
                        tabController.animateTo(1);
                      }
                    : null,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(16.0)),
                        child: Text(
                          '播放全部',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        onPressed: () async {
                          await store.playMultis(this.songList);
                          if (store.player.isPlaying == true) {
                            var res = await MyPlayer.player.stop();
                            if (res == 1) {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (BuildContext context) {
                              //   return AlbumCover(
                              //     isNew: true,
                              //   );
                              // }));
                              Routes.router.navigateTo(
                                  pageContext, '/albumcoverpage?isNew=true');
                            }
                          } else {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (BuildContext context) {
                            //   return AlbumCover(
                            //     isNew: true,
                            //   );
                            // }));
                            Routes.router.navigateTo(
                                pageContext, '/albumcoverpage?isNew=true');
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '单曲',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    ),
                  ],
                )),
          ),
        ),
        SizedBox(
          width: 15.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<NeteaseState, VoidCallback>(
      builder: (BuildContext context, cb) {
        return SingleChildScrollView(
          child: MusicItemList(
              keyword: keyword,
              list: _buildList(context, cb),
              titleWidget: _buildTitle()),
        );
      },
      converter: (Store<NeteaseState> appstore) {
        return () {
          appstore.dispatch(NeteaseActions.AddToCollection);
        };
      },
    );
  }
}
