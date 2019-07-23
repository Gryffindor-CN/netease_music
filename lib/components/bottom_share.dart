import 'package:flutter/material.dart';

class ShareWidget extends StatefulWidget {
  final List<dynamic> shareBars;
  ShareWidget(this.shareBars);

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
                    _buildShareIcons(context, widget.shareBars),
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
  static showBottomShare(BuildContext context, List<dynamic> shareBars) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext context) {
          return ShareWidget(shareBars);
        });
  }
}

Widget _buildShareIcons(BuildContext context, List<dynamic> shareBars) {
  List<Padding> _shareWidget = [];
  shareBars.asMap().forEach((int index, dynamic item) {
    _shareWidget.add(Padding(
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
                item['shareLogo'],
              ),
            ),
            Text(item['shareText'], style: TextStyle(fontSize: 10.0))
          ],
        ),
        onTap: item['shareEvent'] != null ? item['shareEvent'] : null,
      ),
    ));
  });

  return Container(
    width: MediaQuery.of(context).size.width,
    child: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _shareWidget),
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
                        child: Image.asset('assets/icons/music_logo_32.png'),
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
