import 'package:flutter/material.dart';
import './selection_checkbox.dart';
import '../../model/music.dart';
import '../../components/music_item.dart';

class SongList extends StatefulWidget {
  final bool selectStatus;
  final Music item;
  final VoidCallback handleTap;
  SongList(
      {Key key, @required this.item, this.selectStatus = false, this.handleTap})
      : super(key: key);

  @override
  SongListState createState() => SongListState();
}

class SongListState extends State<SongList> {
  @override
  Widget build(BuildContext context) {
    String _name;
    if (widget.item.name.toString().toString().length > 16) {
      _name = '${widget.item.name.toString().substring(0, 15)}';
    } else {
      _name = widget.item.name;
    }
    return GestureDetector(
      onTap: widget.handleTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20.0),
        child: Row(children: <Widget>[
          SongCheckbox(checked: widget.selectStatus),
          Expanded(
            child: MusicItem(widget.item),
          )
        ]),
      ),
    );
  }
}
