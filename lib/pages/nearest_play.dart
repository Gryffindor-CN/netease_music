import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart' as prefix0;
import 'dart:convert';
import 'package:sticky_headers/sticky_headers.dart';
import '../components/selection/select_all.dart';
import 'package:flutter/cupertino.dart';

class TabbedAppBarSample extends StatefulWidget {
  @override
  TabbedAppBarSampleState createState() => TabbedAppBarSampleState();
}

class TabbedAppBarSampleState extends State<TabbedAppBarSample> {
  final scaffoldKey = GlobalKey<TabbedAppBarSampleState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('最近播放'),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 36.0),
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: choices.map((Choice choice) {
              return Tab(
                text: choice.title,
              );
            }).toList(),
          ),
        ),
        body: TabBarView(
          children: choices.map((Choice choice) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: ChoiceCard(choice: choice, key: scaffoldKey),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '歌曲'),
  const Choice(
    title: '直播',
  ),
  const Choice(
    title: '视频',
  ),
  const Choice(
    title: '其他',
  ),
];

class ChoiceCard extends StatefulWidget {
  ChoiceCard({Key key, this.choice});
  final Choice choice;

  @override
  ChoiceCardState createState() => ChoiceCardState();
}

class ChoiceCardState extends State<ChoiceCard> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    switch (widget.choice.title) {
      case '歌曲':
        return SongsTab();
      default:
        return Center(
            child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(widget.choice.title, style: textStyle),
          ],
        ));
    }
  }
}

class SongsTab extends StatefulWidget {
  SongsTab();

  @override
  SongsTabState createState() => SongsTabState();
}

class SongsTabState extends State<SongsTab> {
  bool _selection = false;
  bool _active = false;
  bool _isLoading = true;
  List<Map<String, dynamic>> lists = [];

  void _httpRequest() async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/user/record?uid=1788319348&type=0");
      var result = json.decode(response.toString())['allData'];
      result.forEach((item) {
        lists.add({
          'name': item['song']['song']['name'],
          'id': item['song']['song']['id'],
          'artist': item['song']['song']['artist']['name'],
          'artistId': item['song']['song']['artist']['id'],
          'albumName': item['song']['song']['album']['name']
        });
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onSongsDelete(val) {
    setState(() {
      val.forEach((item) {
        var _index = lists.indexOf(item);
        lists.removeAt(_index);
      });
      _selection = !_selection;
    });
  }

  @override
  void initState() {
    super.initState();
    _httpRequest();
  }

  Widget _buildSongTailling(Widget tailling) {}

  Widget _buildSongContainer(Map<String, dynamic> item, {bool hasTailling}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 56.0,
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.white))),
        padding: EdgeInsets.only(left: 10.0),
        child: Padding(
          padding: EdgeInsets.only(bottom: 6.0),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 10,
                padding: EdgeInsets.only(left: 4.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.title,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(item['artist'],
                            style: Theme.of(context).textTheme.subtitle),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(' - ',
                              style: Theme.of(context).textTheme.subtitle),
                        ),
                        Expanded(
                          child: Text(item['albumName'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSongList() {
    List<Widget> widgetItems = [];
    List<Widget> clearItems = [
      Theme(
        data: ThemeData(
          iconTheme: IconThemeData(color: Color(0xffd4d4d4)),
        ),
        child: GestureDetector(
          onTap: () {
            // todo 清除播放记录
            _clearPlayRecords(context, () {
              setState(() {
                lists.clear();
              });
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.transparent))),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.delete_outline),
                Text(
                  '清除播放记录',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.subtitle.color,
                      fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      )
    ];

    if (lists.length > 0) {
      lists.map((item) {
        widgetItems.add(_buildSongContainer(item, hasTailling: true));
      }).toList();
    }

    return Column(
      children: widgetItems..addAll(clearItems),
    );
  }

  Widget buildSongsWidget() {
    return _isLoading == true
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          ))
        : lists.length == 0
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    '暂无播放记录',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.subtitle.color),
                  ),
                ))
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return StickyHeader(
                      header: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom:
                                              BorderSide(color: Colors.white))),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.play_circle_outline),
                                      Padding(
                                        padding: EdgeInsets.only(left: 12.0),
                                        child: Text(
                                          '播放全部',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .title
                                                .fontSize,
                                          ),
                                        ),
                                      ),
                                      Text('（共${lists.length}首）',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .subtitle
                                                  .color))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selection = !_selection;
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.list),
                                    Text(
                                      '多选',
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      content: Column(
                        children: <Widget>[
                          _buildSongList(),
                        ],
                      ));
                },
                itemCount: 1,
              );
  }

  @override
  Widget build(BuildContext context) {
    return !_selection
        ? buildSongsWidget()
        : SelectAll(
            songs: lists,
            handleSongsDel: (val) => _onSongsDelete(val),
            handleFinish: () {
              setState(() {
                _selection = false;
              });
            });
  }
}

void _clearPlayRecords(BuildContext ctx, prefix0.VoidCallback callback) {
  showCupertinoModalPopup(
    context: ctx,
    builder: (BuildContext context) => CupertinoActionSheet(
        message: const Text('确定清除播放记录？'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              '清除',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            onPressed: () {
              callback();
              Navigator.pop(context, '清除');
            },
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('取消'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, '取消');
          },
        )),
  );
}

void main() {
  runApp(TabbedAppBarSample());
}
