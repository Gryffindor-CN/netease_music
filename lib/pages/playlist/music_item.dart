import 'package:flutter/material.dart';
import '../../model/model.dart';

class MusicItem extends StatelessWidget {
  final Music item;
  final int itemIndex;
  final List<Map<String, dynamic>> tailsList;
  final BuildContext pageContext;
  final GestureTapCallback onTap;
  MusicItem(this.item,
      {this.itemIndex, this.tailsList, this.pageContext, this.onTap});

  static Widget _nameWidget;
  static Widget _albumnameWidget;

  @override
  Widget build(BuildContext context) {
    // final store = StateContainer.of(context);
    var themeColor = Theme.of(context).primaryColor;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Text(
                        itemIndex < 10 ? '0$itemIndex' : '$itemIndex',
                        style: TextStyle(
                            color: itemIndex < 4 ? themeColor : Colors.grey,
                            fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
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
