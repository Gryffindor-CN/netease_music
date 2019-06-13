import 'package:flutter/material.dart';
import './song_list.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../song_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';
import './select_bottom.dart';

class SelectAll extends StatefulWidget {
  final List<dynamic> songs;
  final VoidCallback handleFinish;
  final handleSongsDel;
  SelectAll(
      {Key key, @required this.songs, this.handleSongsDel, this.handleFinish})
      : super(key: key);

  @override
  SelectAllState createState() => SelectAllState();
}

class SelectAllState extends State<SelectAll> {
  int selectedCount = 0;
  bool allSelected = false;
  Color bottomIconColor = Color(0xffd4d4d4);
  final List selectedList = [];
  // final List<Widget> widgetItems = [];

  Widget _buildList() {
    List<Widget> widgetItems = [];
    widget.songs.map((item) {
      widgetItems.add(SongList(
          handleTap: () {
            setState(() {
              if (!selectedList.remove(item)) {
                // true 代表是未选择
                selectedList.add(item);
                setState(() {
                  bottomIconColor = Theme.of(context).iconTheme.color;
                });
              }
              if (selectedList.length == widget.songs.length) {
                allSelected = true;
                setState(() {
                  bottomIconColor = Theme.of(context).iconTheme.color;
                });
              } else {
                allSelected = false;
              }
              if (selectedList.length == 0) {
                setState(() {
                  bottomIconColor = Color(0xffd4d4d4);
                });
              }
            });
          },
          item: item,
          selectStatus: selectedList.contains(item)));
    }).toList();

    return Column(
      children: widgetItems,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return StickyHeader(
            header: Container(
                decoration: BoxDecoration(color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            allSelected = !allSelected;
                            if (allSelected) {
                              selectedList.clear();
                              selectedList.addAll(widget.songs);
                            } else {
                              selectedList.clear();
                              setState(() {
                                bottomIconColor = Color(0xffd4d4d4);
                              });
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white))),
                          child: Row(
                            children: <Widget>[
                              SongCheckbox(
                                checked: allSelected,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16.0),
                                child: Text(
                                  '全选',
                                  style: Theme.of(context).textTheme.title,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: widget.handleFinish,
                        child: Text(
                          '完成',
                          style: TextStyle(
                              fontSize:
                                  Theme.of(context).textTheme.title.fontSize,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                )),
            content: _buildList(),
          );
        },
      ),
      SelectBottom(
        child: Container(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 1.0),
          height: 70.0,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: selectedList.length == 0
                    ? null
                    : () {
                        _addToNext(context);
                      },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.play_circle_outline,
                        color: bottomIconColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          '下一首播放',
                          style: TextStyle(color: Color(0xff3f3b3c)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: selectedList.length == 0
                    ? null
                    : () {
                        _addToCollection(context);
                      },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.add_circle_outline,
                        color: bottomIconColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          '收藏到歌单',
                          style: TextStyle(color: Color(0xff3f3b3c)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: selectedList.length == 0
                    ? null
                    : () {
                        _showDeleteModal(context, () {
                          widget.handleSongsDel(selectedList);
                        });
                      },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.delete_outline,
                        color: bottomIconColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Text(
                          '删除',
                          style: TextStyle(color: Color(0xff3f3b3c)),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // Positioned(
      //     width: MediaQuery.of(context).size.width,
      //     height: 70.0,
      //     left: 0,
      //     top: MediaQuery.of(context).size.height - 190,
      //     child: Container(
      //       decoration: BoxDecoration(
      //           border: Border(top: BorderSide(color: Color(0xffd4d4d4))),
      //           color: Color(0xfffafafa)),
      //       height: 70.0,
      //       child: Container(
      //         padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 1.0),
      //         height: 70.0,
      //         width: MediaQuery.of(context).size.width,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: <Widget>[
      //             GestureDetector(
      //               onTap: selectedList.length == 0
      //                   ? null
      //                   : () {
      //                       _addToNext(context);
      //                     },
      //               child: Container(
      //                 child: Column(
      //                   children: <Widget>[
      //                     Icon(
      //                       Icons.play_circle_outline,
      //                       color: bottomIconColor,
      //                     ),
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 4.0),
      //                       child: Text(
      //                         '下一首播放',
      //                         style: TextStyle(color: Color(0xff3f3b3c)),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             GestureDetector(
      //               onTap: selectedList.length == 0
      //                   ? null
      //                   : () {
      //                       _addToCollection(context);
      //                     },
      //               child: Container(
      //                 child: Column(
      //                   children: <Widget>[
      //                     Icon(
      //                       Icons.add_circle_outline,
      //                       color: bottomIconColor,
      //                     ),
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 4.0),
      //                       child: Text(
      //                         '收藏到歌单',
      //                         style: TextStyle(color: Color(0xff3f3b3c)),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //             GestureDetector(
      //               onTap: selectedList.length == 0
      //                   ? null
      //                   : () {
      //                       _showDeleteModal(context, () {
      //                         widget.handleSongsDel(selectedList);
      //                         // widget.songs.contains()
      //                         // setState(() {
      //                         //   selectedList.clear();
      //                         // });
      //                         // print(widgetItems);
      //                       });
      //                     },
      //               child: Container(
      //                 child: Column(
      //                   children: <Widget>[
      //                     Icon(
      //                       Icons.delete_outline,
      //                       color: bottomIconColor,
      //                     ),
      //                     Padding(
      //                       padding: EdgeInsets.only(top: 4.0),
      //                       child: Text(
      //                         '删除',
      //                         style: TextStyle(color: Color(0xff3f3b3c)),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             )
      //           ],
      //         ),
      //       ),
      //     )),
    ]);
  }
}

// 删除
void _showDeleteModal(BuildContext ctx, VoidCallback handlePress) {
  showCupertinoModalPopup(
    context: ctx,
    builder: (BuildContext context) => CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  '从列表中删除',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  // todo
                  handlePress();
                  Navigator.pop(context, '从列表中删除');
                },
              ),
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

// 收藏到歌单
void _addToCollection(BuildContext context) {
  showSimpleNotification(context, Text("待完成"),
      background: Theme.of(context).primaryColor);
}

// 下一首播放
void _addToNext(BuildContext context) {
  showSimpleNotification(context, Text("待完成"),
      background: Theme.of(context).primaryColor);
}
