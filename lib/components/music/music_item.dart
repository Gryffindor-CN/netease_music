import 'package:flutter/material.dart';
import '../../model/music.dart';
import '../musicplayer/inherited_demo.dart';
import '../../router/Routes.dart';

class MusicItem extends StatelessWidget {
  final Music item;
  final String keyword;
  final bool sort;
  final int sortIndex;
  final List<Map<String, dynamic>> tailsList;
  final BuildContext pageContext;
  final VoidCallback onTap;
  MusicItem(this.item,
      {this.keyword,
      this.sort = false,
      this.tailsList,
      this.pageContext,
      this.onTap,
      @required this.sortIndex});

  static Widget _nameWidget;
  static Widget _albumnameWidget;

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    if (this.keyword == null) {
      // 搜索关键字非高亮
      _nameWidget = DefaultTextStyle(
        style: TextStyle(fontSize: 15.0, color: Colors.black),
        child: Text(
          item.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );
      _albumnameWidget =
          Text(item.albumName, maxLines: 1, overflow: TextOverflow.ellipsis);
    } else {
      // 搜索关键字高亮
      if (store.player.current.id == item.id) {
        _nameWidget = DefaultTextStyle(
          style: TextStyle(color: Theme.of(context).primaryColor),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.volume_up,
                size: 18.0,
                color: Theme.of(context).primaryColor,
              ),
              Text(item.name)
            ],
          ),
        );
      } else if (item.name.contains(keyword)) {
        var _startIndex = item.name.indexOf(keyword);
        var _itemNameLen = item.name.length;
        var _keywordLen = keyword.length;
        _nameWidget = DefaultTextStyle(
          style: TextStyle(fontSize: 15.0, color: Colors.black),
          child: RichText(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            text: TextSpan(
              text: item.name.substring(0, _startIndex),
              style: TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: keyword, style: TextStyle(color: Color(0xff0c73c2))),
                TextSpan(
                    text: item.name
                        .substring(_startIndex + _keywordLen, _itemNameLen),
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        );
      } else {
        _nameWidget = DefaultTextStyle(
          style: TextStyle(fontSize: 15.0, color: Colors.black),
          child: Text(
            item.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        );
      }

      if (item.albumName.contains(keyword)) {
        var _startIndex = item.albumName.indexOf(keyword);
        var _itemNameLen = item.albumName.length;
        var _keywordLen = keyword.length;

        _albumnameWidget = RichText(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          text: TextSpan(
            text: item.albumName.substring(0, _startIndex),
            style: TextStyle(color: Colors.grey, fontSize: 10.0),
            children: <TextSpan>[
              TextSpan(
                  text: keyword,
                  style: TextStyle(
                    color: Color(0xff0c73c2),
                  )),
              TextSpan(
                  text: item.albumName
                      .substring(_startIndex + _keywordLen, _itemNameLen)),
            ],
          ),
        );
      } else {
        _albumnameWidget =
            Text(item.albumName, maxLines: 1, overflow: TextOverflow.ellipsis);
      }
    }

    if (tailsList != null) {
      return InkWell(
        onTap: () async {
          if (store.player.current.id == item.id) {
            Routes.router.navigateTo(context, '/albumcoverpage');
            return;
          }
          await store.play(Music(
            name: item.name,
            id: item.id,
            aritstId: item.aritstId,
            aritstName: item.aritstName,
            albumName: item.albumName,
            albumId: item.albumId,
            albumCoverImg: item.albumCoverImg,
          ));
          Routes.router.navigateTo(context, '/albumcoverpage?isNew=true');
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: sort == true
                      ? <Widget>[
                          Flexible(
                            flex: 1,
                            child: Text('$sortIndex'),
                          ),
                          Flexible(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.0),
                                    child: _nameWidget,
                                  ),
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        item.aritstName == keyword
                                            ? Text(item.aritstName,
                                                style: TextStyle(
                                                  color: Color(0xff0c73c2),
                                                ))
                                            : Text(
                                                item.aritstName,
                                              ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text('-'),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Flexible(
                                          child: _albumnameWidget,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: ListTail(
                              tails: tailsList,
                            ),
                          )
                        ]
                      : [
                          Flexible(
                            flex: 7,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 2.0),
                                    child: _nameWidget,
                                  ),
                                  DefaultTextStyle(
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.0,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        item.aritstName == keyword
                                            ? Text(item.aritstName,
                                                style: TextStyle(
                                                  color: Color(0xff0c73c2),
                                                ))
                                            : Text(
                                                item.aritstName,
                                              ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Text('-'),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        Flexible(
                                          child: _albumnameWidget,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: ListTail(
                              tails: tailsList,
                            ),
                          )
                        ],
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 0.5))),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.0),
                        child: _nameWidget,
                      ),
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              item.aritstName,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text('-'),
                            SizedBox(
                              width: 4.0,
                            ),
                            Flexible(
                              child: _albumnameWidget,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        ),
      );
    }
  }
}

class ListTail extends StatelessWidget {
  final List<Map<String, dynamic>> tails;
  ListTail({this.tails});

  List<Padding> _buildTail() {
    List<Padding> _widgetlist = [];

    tails.asMap().forEach((int index, dynamic item) {
      _widgetlist.add(Padding(
        padding: EdgeInsets.only(left: 12.0),
        child: InkResponse(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Icon(
            item['iconData'],
            color: Color(0xFFD6D6D6),
          ),
          onTap: item['iconPress'],
        ),
      ));
    });
    return _widgetlist;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _buildTail(),
    );
  }
}
