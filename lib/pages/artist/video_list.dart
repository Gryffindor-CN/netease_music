import 'package:flutter/material.dart';
import './video_item.dart';

class VideoTitle extends StatelessWidget {
  VideoTitle(this.videoList, {this.pageContext});
  final List<Map<String, dynamic>> videoList;
  final BuildContext pageContext;

  List<Widget> _buildWidget(
    BuildContext context,
  ) {
    List<Widget> widgetList = [];
    videoList.asMap().forEach((int index, item) {
      widgetList.add(VideoItem(
        item,
        this.pageContext,
        onTap: () async {},
      ));
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(
        context,
      ),
    );
  }
}
