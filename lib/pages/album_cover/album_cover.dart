import 'package:flutter/material.dart';
import '../../components/musicplayer/playing_album_cover.dart';

class AlbumCoverPage extends StatelessWidget {
  final bool isNew;

  const AlbumCoverPage({
    Key key,
    this.isNew,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return AlbumCover(
      isNew: isNew,
    );
  }
}
