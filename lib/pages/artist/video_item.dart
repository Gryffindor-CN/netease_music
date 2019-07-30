import 'package:flutter/material.dart';
import '../../utils/time.dart';

class VideoItem extends StatelessWidget {
  final Map<String, dynamic> item;
  final BuildContext pageContext;
  final GestureTapCallback onTap;
  VideoItem(this.item, this.pageContext, {this.onTap});

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
                  width: 72 * 1.6,
                  height: 72.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(3.0)),
                      child: Image.network(
                        item['coverUrl'],
                      )),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(item['title']),
                        SizedBox(
                          height: 4.0,
                        ),
                        DefaultTextStyle(
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text('${getTimeStamp(item["durationms"])}'),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                'by ${item['creator']['userName']}',
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
