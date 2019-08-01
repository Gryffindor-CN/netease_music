import 'package:flutter/material.dart';
import '../../repository/netease.dart';
import '../../components/video/video_item.dart';

class SearchVideoTab extends StatefulWidget {
  final String keyword;
  SearchVideoTab({@required this.keyword});
  @override
  SearchVideoTabState createState() => SearchVideoTabState();
}

class SearchVideoTabState extends State<SearchVideoTab>
    with AutomaticKeepAliveClientMixin {
  int videoCount = 1;
  List<Map<String, dynamic>> videos = [];
  bool _isLoading = true;
  int offset = 0;
  ScrollController _scrollController;

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
      offset = offset + 1;
      _getVideos();
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
        await NeteaseRepository.getVideos(widget.keyword, offset: offset);
    if (this.mounted) {
      Future.delayed(Duration(milliseconds: 20), () {
        if (result == null) {
          setState(() {
            _isLoading = false;
            videos = [];
          });
        } else {
          setState(() {
            videoCount = result['videoCount'];
            result['videos'].asMap().forEach((int index, video) {
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
            if (videos.length == _len + result['videos'].length) {
              setState(() {
                _isLoading = false;
              });
            }
          });
        }
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return (_isLoading == true && offset == 0)
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
            : (_isLoading == true && offset > 0)
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
}
