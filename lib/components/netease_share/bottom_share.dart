import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class ShareWidget extends StatefulWidget {
  @override
  ShareWidgetState createState() => ShareWidgetState();
}

class ShareWidgetState extends State<ShareWidget>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      animationController: _animationController,
      onClosing: () {},
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          height: 280,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Flexible(
              flex: 2,
              child: _buildShareInterior(context),
            ),
            Divider(),
            Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    _buildShareIcons(context),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                      child: InkWell(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '取消',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ))
          ]),
        );
      },
    );
  }
}

class BottomShare {
  static showBottomShare(BuildContext context) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return ShareWidget();
        });
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
                fluwx.share(fluwx.WeChatShareTextModel(
                    text: '_____',
                    transaction: "text${DateTime.now().millisecondsSinceEpoch}",
                    scene: fluwx.WeChatScene.SESSION));
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

Widget _buildShareInterior(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          child: Text('分享至'),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                        // child: Icon(Icons.mail_outline),
                        child: Icon(AntDesign.getIconData("mail")),
                      ),
                      Text('云音乐动态', style: TextStyle(fontSize: 10.0))
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
                        child: Icon(Icons.music_note),
                      ),
                      Text('私信', style: TextStyle(fontSize: 10.0))
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
      )
    ],
  );
}
