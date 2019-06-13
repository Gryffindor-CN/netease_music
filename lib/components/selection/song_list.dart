import 'package:flutter/material.dart';
import '../song_checkbox.dart';

class SongList extends StatefulWidget {
  final bool selectStatus;
  final Map<String, dynamic> item;
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
    if (widget.item['name'].toString().toString().length > 16) {
      _name = '${widget.item['name'].toString().substring(0, 15)}';
    } else {
      _name = widget.item['name'];
    }
    return GestureDetector(
      onTap: widget.handleTap,
      child: Container(
        width: 300.0,
        height: 56.0,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        padding: EdgeInsets.only(left: 10.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              SongCheckbox(checked: widget.selectStatus),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(widget.item['artist'],
                        style: Theme.of(context).textTheme.subtitle)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
