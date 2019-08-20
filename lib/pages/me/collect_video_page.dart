import 'package:flutter/material.dart';
import 'package:netease_music/components/video/video_item.dart';
import 'package:netease_music/model/music.dart';
import 'package:netease_music/pages/artist/artist_page.dart';
import 'package:netease_music/repository/netease.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class CollectVideoPage extends StatefulWidget {
  @override
  CollectVideoState createState() => CollectVideoState();
}

class CollectVideoState extends State<CollectVideoPage> with AutomaticKeepAliveClientMixin{

  bool _isLoading = true;
  List<Map<String, dynamic>> videos = [];
  ScrollController _scrollController;
  int videoCount = 1;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    if (this.mounted) {
      _getVideos();
    }
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2.0) {
      if (_isLoading == true) return;

    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  Future<void> _getVideos() async {
    setState(() {
      _isLoading = true;
    });
    var _len = videos.length;
    var result =
    await NeteaseRepository.getVideoSublist();
    if (this.mounted) {
      Future.delayed(Duration(milliseconds: 20), () {
        if (result == null) {
          setState(() {
            _isLoading = false;
            videos = [];
          });
        } else {
          setState(() {
            videoCount = result['count'];
            result['data'].asMap().forEach((int index, video) {
              videos.add({
                'coverUrl': video['coverUrl'],
                'vid': video['vid'],
                'title': video['title'],
                'playTime': video['playTime'],
                'durationms': video['durationms'],
                'creator': {
                  'userId': video['creator'][0]['userId'],
                  'userName': video['creator'][0]['userName']
                }
              });
            });
            if (videos.length == _len + result['data'].length) {
              setState(() {
                _isLoading = false;
              });
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading == true)
        ? Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          ),
        ))
        : videos.length == 0
        ? Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Text(
            '暂无视频记录',
            style: TextStyle(
                color: Theme.of(context).textTheme.subtitle.color),
          ),
        ))
        : (_isLoading == true)
        ? SingleChildScrollView(
      controller: _scrollController,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: _buildContent(context)
              ..addAll([
                Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Text('视频加载中...',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor)),
                )
              ]),
          ),
        ),
      ),
    )
        : SingleChildScrollView(
      controller: _scrollController,
      child: Center(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: _buildContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context) {
    List<Widget> _widgetlist = [];
    videos
      ..asMap().forEach((int index, item) {
        _widgetlist.add(VideoItem(
          item,
          this.context,
          onTap: () async {},
        ));
      });

    return _widgetlist;
  }

}
