import 'package:flutter/material.dart';
import '../../model/model.dart';
import './album_item.dart';

class AlbumTitle extends StatelessWidget {
  final List<Album> albumList;

  // final StateContainerState store;
  final BuildContext pageContext;
  AlbumTitle(this.albumList, {this.pageContext});

  List<Widget> _buildWidget(
    BuildContext context,
  ) {
    List<Widget> widgetList = [];
    albumList.asMap().forEach((int index, Album item) {
      widgetList.add(AlbumItem(
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
