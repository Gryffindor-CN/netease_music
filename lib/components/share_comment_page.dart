import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class CommentShareContainer extends StatefulWidget {
  final String id;
  final String coverImgUrl;
  CommentShareContainer(this.id, this.coverImgUrl);

  @override
  CommentShareContainerState createState() => CommentShareContainerState();
}

class CommentShareContainerState extends State<CommentShareContainer> {
  List<dynamic> hotComments = [];
  int commentTotal;
  void getHttp() async {
    try {
      Response response = await Dio()
          .get("http://192.168.206.133:3000/comment/playlist?id=${widget.id}");
      var result = json.decode(response.toString());
      setState(() {
        hotComments = result['hotComments'];
        commentTotal = result['total'];
      });
    } catch (e) {
      print(e);
    }
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Color(0xffA17B6E)),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Opacity(
                    opacity: 0.5,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.ac_unit,
                                color: Colors.white,
                                size: 17.0,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 6.0),
                                  child: Text(
                                    '网易云音乐，歌单评论分享',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    if (index == 0) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        margin: EdgeInsets.only(top: 80.0),
                        decoration: BoxDecoration(color: Color(0xffA17B6E)),
                        child: Stack(overflow: Overflow.visible, children: [
                          Container(
                            height: 130.0,
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
                                    SizedBox(
                                      width: 140.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 18.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '华语速爆新歌',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'by 网易云音乐',
                                            style: TextStyle(
                                                color: Color(0xffaaaaaa)),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(20.0, 25.0, 0.0, 0.0),
                                  child: Text('共 $commentTotal 条精彩评论'),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            left: 20.0,
                            top: -30.0,
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              child: hotComments.length > 0
                                  ? Image.network(
                                      '${widget.coverImgUrl.replaceAll('_', '/')}',
                                      fit: BoxFit.fill,
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                  border: Border.all(color: Colors.black)),
                            ),
                          )
                        ]),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(color: Color(0xffA17B6E)),
                        child: Container(
                          // height: 60.0,
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        hotComments[index]['user']
                                            ['avatarUrl'])),
                              )),
                              Flexible(
                                flex: 4,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(hotComments[index]['user']
                                                ['nickname']),
                                            Text(hotComments[index]['time']
                                                .toString()),
                                          ],
                                        ),
                                        Text(hotComments[index]['likedCount']
                                            .toString())
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }, childCount: hotComments.length),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          // left: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            height: 140,
            child: _buildShareIcons(context),
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
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
