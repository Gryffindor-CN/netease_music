import 'package:flutter/material.dart';

import '../../model/model.dart';

class MusicList extends StatelessWidget{
  final Widget child;
  final void Function(BuildContext context, Music music) onMusicTap;
  final Widget Function(BuildContext context, Music music) leadingBuilder;

  MusicList(
    {Key key, 
    this.child, 
    this.onMusicTap, 
    this.leadingBuilder}
  ) : super(key: key);

  static MusicList of(BuildContext context) {
    final list = context.ancestorWidgetOfExactType(MusicList);
    assert(list != null, 'you can only use [MusicTitle] inside MusicList scope.');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class   MusicTitle extends StatelessWidget {
  const MusicTitle({Key key, this.music}) : super(key: key);

  final Music music;

  Widget _buildPadding(BuildContext context, Music music) {
      return SizedBox(width: 8);
  }

  @override
  Widget build(BuildContext context) {
    // final list = MusicList.of(context);
    return Container(
      height: 56,
      child: InkWell(
        onTap: () {
          // if (list.onMusicTap != null) list.onMusicTap(context, music);
        },
        child: Row(
          // 将子控件放在主轴的中间位置
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // list.leadingBuilder ?? _buildPadding(context, music),
            _buildPadding(context, music),
            Expanded(
              child: _SimpleMusicTitle(music),
            ),
            // list.leadingBuilder ?? _buildPadding(context, music),
            _buildPadding(context, music),
          ],
        ),
      ),
    );
  }
}

class _SimpleMusicTitle extends StatelessWidget {

  const _SimpleMusicTitle(this.music, {Key key}) : super(key: key);

  final Music music;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              // children 在交叉轴的起点处开始展示
              crossAxisAlignment: CrossAxisAlignment.start,
              // spaceEvenly：将主轴方向上的空白区域均分，使得children之间的空白区域相等，包括首尾child；
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Spacer(),
                Text(
                  music.title,
                  maxLines: 1,
                  // 当内容超出窗口范围时：使用省略号表示文本已溢出。
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}