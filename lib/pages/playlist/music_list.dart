import 'package:flutter/material.dart';
import '../../model/music.dart';
import '../../components/music/music_item.dart';

class MusicTitle extends StatelessWidget {
  final List<Music> songList;

  // final StateContainerState store;
  final BuildContext pageContext;
  MusicTitle(this.songList, {this.pageContext});

  List<Widget> _buildWidget(BuildContext context) {
    List<Widget> widgetList = [];
    songList.asMap().forEach((int index, Music item) {
      widgetList.add(MusicItem(
        item,
        sortIndex: index + 1,
        tailsList: item.mvId == 0
            ? [
                {'iconData': Icons.more_vert, 'iconPress': () async {}}
              ]
            : [
                {'iconData': Icons.play_circle_outline, 'iconPress': () {}},
                {'iconData': Icons.more_vert, 'iconPress': () async {}}
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(context),
    );
  }
}
