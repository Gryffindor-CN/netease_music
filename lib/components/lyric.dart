import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import './lyricNotifierData.dart';
import './position_event.dart';

class Lyric extends StatefulWidget {
  final int songId;

  final LyricNotifierData data;

  Lyric({@required this.songId, this.data});

  @override
  State<StatefulWidget> createState() => LyricState();
}

class LyricState extends State<Lyric> {
  bool lyricLoading = false;
  List<String> lyricList = [];
  List<Map<String, dynamic>> lyricTimestampList = [];
  ScrollController _controller;
  int playingSongId;
  double offset = 0.0;
  GlobalKey _containerKey = GlobalKey();
  Size _containerSize = Size(0, 0);
  Offset _containerPosition = Offset(0, 0);
  String _lyric;
  int highlightIndex = 0;
  _getContainerSize() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerSize = containerRenderBox.size;
    print(
        'Size: width = ${containerSize.width} - height = ${containerSize.height}');
  }

  /// New
  _getContainerPosition() {
    final RenderBox containerRenderBox =
        _containerKey.currentContext.findRenderObject();
    final containerPosition = containerRenderBox.localToGlobal(Offset.zero);
    print(
        'Position: x = ${containerPosition.dx} - y = ${containerPosition.dy}');
  }

  _onBuildCompleted(_) {
    _getContainerSize();

    _getContainerPosition();
  }

  @override
  void initState() {
    _controller = ScrollController();
    _getLyric(widget.songId);
    widget.data.addListener(_scrollToCurrentPosition);
    _controller.addListener(() {});
    Player.eventBus.on<int>().listen((e) {
      if (this.mounted) {
        _getLyric(e);
      }
    });
    offset = 0.0;
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(_scrollToCurrentPosition);
    _controller.dispose();
    super.dispose();
  }

  void _scrollToCurrentPosition() {
    for (int i = 0, size = lyricTimestampList.length; i < size; i++) {
      if (lyricTimestampList[i]['position'] != null) {
        if (lyricTimestampList[i]['position'] <
                widget.data.value.inMilliseconds.toDouble() &&
            widget.data.value.inMilliseconds.toDouble() <
                lyricTimestampList[i + 1]['position']) {
          if (_lyric == lyricList[lyricTimestampList[i]['index']]) continue;
          if (lyricList[lyricTimestampList[i]['index']] == null) {
            continue;
          }

          highlightIndex = lyricTimestampList[i]['index'];
          setState(() {
            _lyric = lyricList[lyricTimestampList[i]['index']]
                .replaceAll(RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), '');
          });
          _controller.animateTo(highlightIndex * 50.toDouble(),
              duration: Duration(milliseconds: 1), curve: Curves.ease);
          continue;
        }
        if (widget.data.value.inMilliseconds.toDouble() >
            lyricTimestampList[lyricTimestampList.length - 1]['position']) {
          break;
        }
      }
    }

    if (this.mounted && lyricList.length > 0) {
      // _controller.jumpTo(offset);
      // offset += 1.0;
      // WidgetsBinding.instance.addPostFrameCallback(_onBuildCompleted);
    }
  }

  measureStartTimeMillis(String str) {
    // double minute = Long.parseLong(str.substring(1, 3));
    double minute = double.parse(str.substring(1, 3));
    double second = double.parse(str.substring(4, 6));
    double millisecond = double.parse(str.substring(7, 9));
    return millisecond + second * 1000 + minute * 60 * 1000;
  }

  Future<String> _getLyric(int id) async {
    List<String> _lyricList = [];
    lyricList.clear();
    lyricTimestampList.clear();
    try {
      setState(() {
        lyricLoading = true;
        _lyric = '';
      });
      Response response =
          await Dio().get('http://192.168.206.133:3000/lyric?id=$id');
      var result = json.decode(response.toString())['lrc']['lyric'];

      _lyricList =
          result.toString().replaceAll(new RegExp(r'[\r\n]'), '^^').split('^^');
      _lyricList.asMap().forEach((int index, String value) {
        // if (value.replaceAll(RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), '') != '') {
        //   lyricList.add(value);
        // }
        lyricList.add(value);
      });
      _lyricList.asMap().forEach((int index, String value) {
        String _m;

        RegExp reg = new RegExp(r"\[\d{2}:\d{2}.\d{2,3}]");
        Iterable<Match> matches = reg.allMatches(value.toString());
        for (Match m in matches) {
          _m = m.group(0);
        }
        if (_m != null) {
          lyricTimestampList
              .add({'position': measureStartTimeMillis(_m), 'index': index});
        }
      });
      offset = 0.0;
      setState(() {
        lyricLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        lyricLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (lyricLoading == true || lyricList.length <= 0 || _lyric == null)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              key: _containerKey,
              controller: _controller,
              itemCount: lyricList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  // decoration: BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.white))),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(12.0),
                  child: _lyric ==
                          lyricList[index]
                              .replaceAll(RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), '')
                      ? lyricList[index].replaceAll(
                                  RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), '') ==
                              ''
                          ? Text('')
                          : Text(
                              lyricList[index].replaceAll(
                                  RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), ''),
                              style: TextStyle(color: Colors.red),
                            )
                      : Text(
                          lyricList[index].replaceAll(
                              RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), ''),
                        ),
                  // child: _lyric != null
                  //     ? Text(_lyric.replaceAll(
                  //         RegExp(r"\[\d{2}:\d{2}.\d{2,3}]"), ''))
                  //     : Text(''),
                );
              },
            ),
          );
  }
}
