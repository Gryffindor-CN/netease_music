import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_icons/flutter_icons.dart';

class CommentShareContainer extends StatefulWidget {
  final String playListId;
  final String coverImgUrl;
  final String playListName;
  final String playListUserName;
  CommentShareContainer(this.playListId, this.coverImgUrl, this.playListName,
      this.playListUserName);

  @override
  CommentShareContainerState createState() => CommentShareContainerState();
}

class CommentShareContainerState extends State<CommentShareContainer> {
  List<dynamic> hotComments = [];
  int commentTotal = 0;
  void getHttp() async {
    try {
      Response response = await Dio().get(
          "http://192.168.206.133:3000/comment/playlist?id=${widget.playListId}");
      var result = json.decode(response.toString());

      setState(() {
        hotComments = result['hotComments'];
        result['hotComments'].asMap().forEach((index, item) {
          var format =
              DateTime.fromMillisecondsSinceEpoch(item['time']).toString();
          var year = DateTime.parse(format).year;
          var month = DateTime.parse(format).month;
          var day = DateTime.parse(format).day;
          hotComments[index]['year'] = year;
          hotComments[index]['month'] = month;
          hotComments[index]['day'] = day;
        });

        commentTotal = result['total'];
        _buildCommentList();
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildCommentList() {
    List<Widget> _commentList = [];
    hotComments.asMap().forEach((index, item) {
      _commentList.add(Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.symmetric(vertical: 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                hotComments[index]['user']['avatarUrl'],
              )),
            )),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(hotComments[index]['user']['nickname'],
                              style: TextStyle(fontSize: 12.0)),
                          Text(
                            '${hotComments[index]['year']}年${hotComments[index]['month']}月${hotComments[index]['day']}日',
                            style: TextStyle(
                                color: Color(0xffaaaaaa), fontSize: 9.0),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            hotComments[index]['likedCount'].toString(),
                            style: TextStyle(
                                color: Color(0xffaaaaaa), fontSize: 10.0),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(2.0, 0.0, 0.0, 4.0),
                            child: Icon(
                              AntDesign.getIconData("like2"),
                              size: 14.0,
                              color: Color(0xffaaaaaa),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: (index + 1) == hotComments.length
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  hotComments[index]['content'],
                                  style: TextStyle(fontSize: 12.0),
                                )
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  hotComments[index]['content'],
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                                  child: Divider(),
                                )
                              ],
                            ))
                ],
              ),
            ),
          ],
        ),
      ));
    });
    return Column(
      children: _commentList,
    );
  }

  Widget _buildCommentListTitle() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          // border: Border.all(color: Color(0xffffffff)),
          color: Color(0xffA17B6E)),
      child: Opacity(
        opacity: 0.5,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.ac_unit,
                color: Colors.white,
                size: 18.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 6.0),
                  child: Text(
                    '网易云音乐，歌单评论分享',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentListAdpator() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Colors.white),
      child: Stack(overflow: Overflow.visible, children: [
        Container(
          height: 100.0,
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(4.0),
                  topRight: const Radius.circular(4.0)),
              color: Color(0xffffffff)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 125),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 18.0),
                      child: Flex(
                        direction: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            width: 180.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  widget.playListName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'by ${widget.playListUserName}',
                                  style: TextStyle(
                                      color: Color(0xffaaaaaa), fontSize: 10.0),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                child: Text(
                  '共 $commentTotal 条精彩评论',
                  style: TextStyle(fontSize: 10.0),
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: 15.0,
          top: -30.0,
          child: Container(
              width: 100.0,
              height: 100.0,
              child: hotComments.length > 0
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      child: Image.network(
                        '${widget.coverImgUrl.replaceAll('_', '/')}',
                        fit: BoxFit.fill,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor),
                      ),
                    )),
        )
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffA17B6E)),
                  color: Color(0xffA17B6E)),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    _buildCommentListTitle(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffA17B6E)),
                            color: Color(0xffA17B6E)),
                      ),
                    ),
                    Container(
                      // height: 200.0,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          _buildCommentListAdpator(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                                borderRadius: new BorderRadius.only(
                                    bottomLeft: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0)),
                                color: Color(0xffffffff)),
                            child: _buildCommentList(),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 130.0),
                        margin: EdgeInsets.only(top: 20.0),
                        decoration: BoxDecoration(color: Color(0xffA17B6E)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 80.0,
                              height: 80.0,
                              child: Image.asset(
                                'assets/code.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 40.0),
                                child: Text('长按识别可在网易云音乐播放',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                    )))
                          ],
                        ))
                  ],
                ),
              )),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xffA17B6E),
              // border: Border.all(color: Colors.white),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              height: 130,
              child: _buildShareIcons(context),
            ),
          ),
        ),
        Positioned(
          top: 40.0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(color: Colors.white)),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}

Widget _buildShareIcons(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                        color: Color(0xfff7f7f7), shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/icons/friend_circle_32.png',
                    ),
                  ),
                  Text('微信朋友圈', style: TextStyle(fontSize: 10.0))
                ],
              ),
              onTap: () {
                print('share');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                        color: Color(0xfff7f7f7), shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/icons/wechat_32.png',
                    ),
                  ),
                  Text('微信好友', style: TextStyle(fontSize: 10.0))
                ],
              ),
              onTap: () {
                print('share');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                        color: Color(0xfff7f7f7), shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/icons/qq_zone_32.png',
                    ),
                  ),
                  Text('QQ空间', style: TextStyle(fontSize: 10.0))
                ],
              ),
              onTap: () {
                print('share');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                        color: Color(0xfff7f7f7), shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/icons/qq_friend_32.png',
                    ),
                  ),
                  Text('QQ好友', style: TextStyle(fontSize: 10.0))
                ],
              ),
              onTap: () {
                print('share');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                        color: Color(0xfff7f7f7), shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/icons/weibo_32.png',
                    ),
                  ),
                  Text('微薄', style: TextStyle(fontSize: 10.0))
                ],
              ),
              onTap: () {
                print('share');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: InkWell(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 46.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                        color: Color(0xfff7f7f7), shape: BoxShape.circle),
                    child: Icon(Icons.airline_seat_legroom_reduced),
                  ),
                  Text('大神圈子', style: TextStyle(fontSize: 10.0))
                ],
              ),
              onTap: () {
                print('share');
              },
            ),
          ),
        ],
      ),
    ),
  );
}
