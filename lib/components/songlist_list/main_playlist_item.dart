import 'package:flutter/material.dart';
import '../../model/model.dart';

class PlaylistItem extends StatelessWidget {
  PlaylistItem(
      {Key key,
      this.playlist,
      this.showTail = false,
      this.showIdentifier = false,
      this.onTap})
      : super(key: key);
  final PlayList playlist;
  final bool showTail;
  final bool showIdentifier;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(playlist.id);
      },
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 15.0,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 45.0,
                  height: 45.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(
                        playlist.coverImgUrl,
                      )),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(playlist.name),
                        SizedBox(
                          height: 4.0,
                        ),
                        DefaultTextStyle(
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('${playlist.trackCount}首，'),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'by${playlist.nickName}',
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }
}
