import 'package:flutter/material.dart';
import './music_item.dart';

class MusicItemList extends StatelessWidget {
  MusicItemList(
      {Key key, this.list, this.keyword, this.titleWidget, this.tailWidget})
      : super(key: key);
  final List<MusicItem> list;
  final String keyword;
  final Widget titleWidget;
  final Widget tailWidget;

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> _widgetlist = [];
    if (titleWidget != null) {
      _widgetlist.insert(0, titleWidget);
      list.forEach((MusicItem musicitem) {
        _widgetlist.add(musicitem);
      });
    } else {
      list.forEach((MusicItem musicitem) {
        _widgetlist.add(musicitem);
      });
    }

    if (tailWidget != null) {
      _widgetlist..addAll([tailWidget]);
    }

    return _widgetlist;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildContent(context),
    );
  }
}
