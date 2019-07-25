import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../model/model.dart';
import '../../repository/netease.dart';
import './music_item.dart';

class MusicTitle extends StatelessWidget {
  final List<Music> songList;

  // final StateContainerState store;
  final BuildContext pageContext;
  MusicTitle(this.songList, {this.pageContext});

  // 获取歌曲播放url
  _getSongUrl(int id) async {
    var result = await NeteaseRepository.getSongUrl(id);
    return result;
  }

  List<Widget> _buildWidget(BuildContext context) {
    List<Widget> widgetList = [];
    songList.asMap().forEach((int index, Music item) {
      widgetList.add(MusicItem(
        item,
        itemIndex: index + 1,
        tailsList: [
          {'iconData': Icons.play_circle_outline, 'iconPress': () {}},
          {'iconData': Icons.more_vert, 'iconPress': () async {}}
        ],
        pageContext: this.pageContext,
      ));
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(context),
    );
  }
}
