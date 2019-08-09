import 'package:flutter/material.dart';
import '../../../model/music.dart';
import '../../../components/musicplayer/inherited_demo.dart';
import '../../../router/Routes.dart';
import '../../album_cover/album_cover.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../../redux/app.dart';

class MusicItem extends StatelessWidget {
  final Music item;
  final List<Map<String, dynamic>> tailsList;
  final BuildContext pageContext;
  final GestureTapCallback onTap;
  final bool isSelect;
  MusicItem(this.item,
      {this.tailsList, this.pageContext, this.onTap, this.isSelect = true});

  static Widget _nameWidget;
  static Widget _albumnameWidget;

  @override
  Widget build(BuildContext context) {
    final store = StateContainer.of(context);
    if (store.player.current.id == item.id) {
      _nameWidget = DefaultTextStyle(
        style: TextStyle(fontSize: 15.0, color: Theme.of(context).primaryColor),
        child: Text(
          item.name,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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

    _albumnameWidget =
        Text(item.albumName, maxLines: 1, overflow: TextOverflow.ellipsis);

    if (tailsList != null) {
      return StoreConnector<NeteaseState, VoidCallback>(
          builder: (BuildContext context, cb) {
        return InkWell(
          onTap: () async {
            if (store.player.current.id == item.id) {
              Routes.router.navigateTo(context, '/albumcoverpage');
              return;
            }
            await store.play(item);
            cb();
            Routes.router.navigateTo(context, '/albumcoverpage?isNew=true');
          },
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              isSelect == true
                  ? Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                margin: EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    child: Image.network(
                                      item.albumCoverImg,
                                    )),
                              ),
                            ),
                            store.player.current.id == item.id
                                ? Flexible(
                                    flex: 1,
                                    child: Icon(
                                      Icons.volume_up,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Container(),
                            Flexible(
                              flex: store.player.current.id == item.id ? 4 : 4,
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
                                          Expanded(
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
                    )
                  : Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                margin: EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    child: Image.network(
                                      item.albumCoverImg,
                                    )),
                              ),
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
                                          Expanded(
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
      }, converter: (Store<NeteaseState> appstore) {
        return () {
          appstore.dispatch(AddToRecentPlayAction(item));
        };
      });
    } else {
      return StoreConnector<NeteaseState, VoidCallback>(
          builder: (BuildContext context, cb) {
        return InkWell(
          onTap: () async {
            if (store.player.current.id == item.id) {
              Routes.router.navigateTo(context, '/albumcoverpage');
              return;
            }
            await store.play(item);
            cb();
            Routes.router.navigateTo(context, '/albumcoverpage?isNew=true');
          },
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              isSelect == true
                  ? Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                margin: EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    child: Image.network(
                                      item.albumCoverImg,
                                    )),
                              ),
                            ),
                            store.player.current.id == item.id
                                ? Flexible(
                                    child: Icon(
                                      Icons.volume_up,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                : Container(),
                            Flexible(
                              flex: 6,
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
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                width: 36.0,
                                height: 36.0,
                                margin: EdgeInsets.only(right: 10.0),
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4.0)),
                                    child: Image.network(
                                      item.albumCoverImg,
                                    )),
                              ),
                            ),
                            Flexible(
                              flex: 6,
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
      }, converter: (Store<NeteaseState> appstore) {
        return () {
          appstore.dispatch(AddToRecentPlayAction(item));
        };
      });
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
