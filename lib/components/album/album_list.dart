import 'package:flutter/material.dart';
import '../../model/music.dart';
import './album_item.dart';
import '../../pages/album/album_cover.dart';

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
        onTap: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return AlbumCover(item.id);
          }));
        },
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
