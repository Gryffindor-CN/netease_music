import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongDetailDialog extends StatefulWidget {
  final String songName;
  final String albumName;
  final String artistName;
  final String albumPicUrl;
  final String songAlia;
  final List<Map<String, dynamic>> lists;

  SongDetailDialog(this.songName, this.albumName, this.artistName,
      this.albumPicUrl, this.songAlia, this.lists);

  @override
  SongDetailDialogState createState() => SongDetailDialogState();
}

class SongDetailDialogState extends State<SongDetailDialog> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  List<Widget> _buildLists() {
    List<Widget> widgetsList = [];

    widget.lists.asMap().forEach((index, item) {
      widgetsList.add(
        ListViewItem(item['leadingIcon'], item['title'], item['callback']),
      );
    });
    return widgetsList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Colors.red.withOpacity(0)),
      child: Container(
          padding: EdgeInsets.only(bottom: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16.0),
                topRight: const Radius.circular(16.0),
              ),
              color: Colors.white),
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: <Widget>[
              _Header(widget.albumPicUrl, widget.songName, widget.songAlia,
                  widget.artistName),
              Expanded(
                child: Material(
                  child: Container(
                    margin: EdgeInsets.only(top: 0.5),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: _buildLists(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
    ;
  }
}

class ListViewItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback handleTap;
  ListViewItem(this.iconData, this.title, this.handleTap);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: Theme.of(context).iconTheme.copyWith(
            color: handleTap == null
                ? Color(0x96aaaaaa)
                : Theme.of(context).iconTheme.color),
      ),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: InkWell(
          onTap: handleTap == null
              ? () {
                  return null;
                }
              : handleTap,
          child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    iconData,
                    size: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 16.0),
                      padding: EdgeInsets.only(bottom: 14.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFE0E0E0), width: 0.5))),
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: handleTap == null
                            ? TextStyle(color: Color(0x96aaaaaa))
                            : DefaultTextStyle.of(context).style,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

const double _DIALOG_HEADER_HEIGHT = 100.0;

class OpenVipBtn extends StatefulWidget {
  final String text;
  OpenVipBtn(this.text);
  @override
  OpenVipBtnState createState() => OpenVipBtnState();
}

class OpenVipBtnState extends State<OpenVipBtn> {
  bool tapping = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18.0)),
          border: Border.all(color: Theme.of(context).primaryColor)),
      child: FlatButton(
        padding: EdgeInsets.all(2.0),
        onPressed: () {
          // setState(() {
          //   tapping = !tapping;
          // });
        },
        onHighlightChanged: (value) {
          setState(() {
            tapping = value;
          });
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
        textColor: tapping ? Colors.white : Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: tapping ? Theme.of(context).primaryColor : Colors.white,
        splashColor: Colors.white,
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 11.0),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String albumPicUrl;
  final String songName;
  final String songAlia;
  final String artistName;

  _Header(this.albumPicUrl, this.songName, this.songAlia, this.artistName);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
          ),
          color: Colors.white,
        ),
        height: _DIALOG_HEADER_HEIGHT,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 50.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          child: albumPicUrl != ''
                              ? Image.network(albumPicUrl, fit: BoxFit.fill)
                              : CircularProgressIndicator(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: 160.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '$songName$songAlia',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  Text(
                                    artistName,
                                    style: TextStyle(
                                        color: Color(0xffaaaaaa),
                                        fontSize: 10.0),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    '开通VIP享高品质听觉盛宴',
                    style: TextStyle(color: Color(0xffaaaaaa), fontSize: 10.0),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                alignment: Alignment.centerRight,
                child: OpenVipBtn('开通VIP畅享'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
