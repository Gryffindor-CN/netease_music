import 'package:flutter/material.dart';
import '../../../model/music.dart';

class MusicItem extends StatelessWidget {
  final Music item;

  final List<Map<String, dynamic>> tailsList;
  final BuildContext pageContext;
  final GestureTapCallback onTap;
  MusicItem(this.item, {this.tailsList, this.pageContext, this.onTap});

  static Widget _nameWidget;
  static Widget _albumnameWidget;

  @override
  Widget build(BuildContext context) {
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

    if (tailsList != null) {
      return InkWell(
        onTap: this.onTap,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 36.0,
                      height: 36.0,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: Image.network(
                            item.albumCoverImg,
                          )),
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
        onTap: this.onTap,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 36.0,
                      height: 36.0,
                      margin: EdgeInsets.only(right: 10.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: Image.network(
                            item.albumCoverImg,
                          )),
                    ),
                    Container(
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
