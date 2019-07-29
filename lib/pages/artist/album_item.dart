import 'package:flutter/material.dart';
import '../../model/model.dart';
import 'package:intl/intl.dart';

class AlbumItem extends StatelessWidget {
  final Album item;
  final BuildContext pageContext;
  final GestureTapCallback onTap;
  AlbumItem(this.item, this.pageContext, {this.onTap});

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 45.0,
                  height: 45.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: Image.network(
                        item.coverImageUrl,
                      )),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item.name),
                        SizedBox(
                          height: 4.0,
                        ),
                        DefaultTextStyle(
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(DateFormat("y.M.d").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      item.publishTime))),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                '${item.size}首',
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
