import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../model/music.dart';
import './inherited_demo.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PlayingListSheet extends StatefulWidget {
  final ValueChanged<BuildContext> clear;
  final ValueChanged<Music> play;
  final ValueChanged<Music> delete;
  PlayingListSheet({this.clear, this.play, this.delete});

  @override
  _PlayingListSheetState createState() => _PlayingListSheetState();
}

class _PlayingListSheetState extends State<PlayingListSheet>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _animationController,
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              _Header(clear: widget.clear),
              _Center(
                play: widget.play,
                delete: widget.delete,
              )
            ],
          ),
        );
      },
    );
  }
}

class _Center extends StatelessWidget {
  final ValueChanged<Music> play;
  final ValueChanged<Music> delete;

  _Center({
    this.play,
    this.delete,
  });

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: store.player.playingList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: TextStyle(
                          color: store.player.playingList[index].id ==
                                  store.player.current.id
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).textTheme.title.color),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          store.player.playingList[index].id ==
                                  store.player.current.id
                              ? Padding(
                                  padding: EdgeInsets.only(right: 2.0),
                                  child: Icon(
                                    Icons.volume_up,
                                    size: 18.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Text(''),
                          Text(
                            store.player.playingList[index].name,
                            style: TextStyle(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text('-'),
                          ),
                          Text(
                            store.player.playingList[index].aritstName,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.subtitle.color,
                              fontSize:
                                  Theme.of(context).textTheme.subtitle.fontSize,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).textTheme.subtitle.color,
                      ),
                      onTap: () {
                        this.delete(store.player.playingList[index]);
                      },
                    )
                  ],
                ),
              ),
            ),
            onTap: store.player.playingList[index].id == store.player.current.id
                ? null
                : () {
                    this.play(store.player.playingList[index]);
                  },
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final ValueChanged<BuildContext> clear;
  _Header({this.clear});

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    final playmode = store.player.playMode.toString();
    IconData icon;
    String mode;
    switch (playmode) {
      case 'PlayMode.single':
        icon = Icons.repeat_one;
        mode = '循环播放';
        break;
      case 'PlayMode.sequence':
        icon = Icons.repeat;
        mode = '列表循环';
        break;
      case 'PlayMode.shuffle':
        icon = Icons.shuffle;
        mode = '随机播放';
        break;
    }
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 2.0, 5.0),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon),
              Text(mode),
              Text('${store.player.playingList.length}')
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  // 收藏全部
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_to_queue),
                    Padding(
                      padding: EdgeInsets.only(left: 6.0),
                      child: Text('收藏全部'),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  AntDesign.getIconData('delete'),
                  size: 20.0,
                ),
                onPressed: () {
                  //清空播放列表
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text('确定要清空播放列表？'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('取消'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('确定'),
                            onPressed: () async {
                              // var res = await store.player.audioPlayer.stop();
                              // await store.clearPlayingList();
                              // if (res == 1) {
                              //   Navigator.of(context).pop();
                              //   // Navigator.of(ctx).pop();
                              //   // Navigator.of(ctx).pop();
                              // }
                              this.clear(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
