import 'package:flutter/material.dart';
import '../../model/music.dart';

class MusicItem extends StatelessWidget {
  final Music item;
  final String keyword;
  final List<Map<String, dynamic>> tailsList;
  MusicItem(this.item, this.keyword, {this.tailsList});

  static Widget _nameWidget;
  static Widget _albumnameWidget;

  @override
  Widget build(BuildContext context) {
    if (item.name.contains(keyword)) {
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
          text: item.name.substring(0, _startIndex),
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
    if (tailsList != null) {
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
              width: 15.0,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: _buildTail(),
    );
  }
}
