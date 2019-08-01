import 'package:flutter/material.dart';
import '../../model/music.dart';
import 'dart:math';
import '../../pages/playlist/playlist.dart';

class PlaylistSection extends StatelessWidget {
  final String keyword;
  final List<PlayList> playList;
  final TabController tabController;
  PlaylistSection(this.keyword, this.playList, {this.tabController});
  static Widget _nameWidget;

  List<Widget> _buildWidget(BuildContext ctx) {
    List<Widget> widgetList = [];
    playList.asMap().forEach((int index, PlayList item) {
      if (item.name.contains(keyword)) {
        var startIndex = item.name.indexOf(keyword);
        var itemNameLen = item.name.length;
        var keywordLen = keyword.length;
        _nameWidget = DefaultTextStyle(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            text: TextSpan(
              text: item.name.substring(0, startIndex),
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: keyword, style: TextStyle(color: Color(0xff0c73c2))),
                TextSpan(
                    text: item.name
                        .substring(startIndex + keywordLen, itemNameLen),
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        );
      } else {
        _nameWidget = DefaultTextStyle(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15.0, color: Colors.black),
          child: Text(
            item.name,
          ),
        );
      }

      widgetList.add(InkWell(
        onTap: () {
          Navigator.of(ctx)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Playlists(item.id, 'playlist');
          }));
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
                          item.coverImgUrl,
                        )),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _nameWidget,
                          SizedBox(
                            height: 4.0,
                          ),
                          DefaultTextStyle(
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.grey),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '${item.trackCount}首音乐',
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Text('by ${item.creatorName}'),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '播放${((item.playCount / 10000) * (pow(10, 1))).round() / (pow(10, 1))}万次',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
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
      ));
    });
    widgetList.insert(
        0,
        Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                child: InkResponse(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: tabController != null
                        ? () {
                            tabController.animateTo(5);
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '歌单',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                            ),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    )),
              ),
            ),
            SizedBox(
              width: 15.0,
            )
          ],
        ));
    return widgetList;
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildWidget(context),
    );
  }
}
