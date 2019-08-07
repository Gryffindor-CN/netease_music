import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../router/Routes.dart';
import '../../model/music.dart';
import '../../repository/netease.dart';
import './search_result.dart';

class SearchPage extends StatefulWidget {
  final String keyword;
  final BuildContext pageContext;
  SearchPage({this.keyword, this.pageContext});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  bool hasSearchInsert;
  bool isSuggestLoading = true;
  bool hotSearchLoading = false;
  List<Music> searchhistorylists = [];
  List<Music> hotlists = [];
  List<dynamic> suggestlists = [];
  String _keyword;

  @override
  void initState() {
    super.initState();
    if (widget.keyword != null) {
      hasSearchInsert = true;
      isSuggestLoading = true;
      _textEditingController = TextEditingController(text: widget.keyword);
      _getSearchSuggest(widget.keyword);
      _keyword = widget.keyword;
    } else {
      _getSearchHot();
      SharedPreferences.getInstance().then((prefs) {
        if (prefs.getStringList('search_history') != null) {
          setState(() {
            searchhistorylists.clear();
            prefs.getStringList('search_history').reversed.forEach((item) {
              searchhistorylists.add(Music(name: item));
            });
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    hasSearchInsert = false;
    _textEditingController.clear();
  }

  // 获取热搜榜
  void _getSearchHot() async {
    setState(() {
      hotSearchLoading = true;
    });
    var hots = await NeteaseRepository.getSearchHot();
    setState(() {
      hotSearchLoading = false;
      hots.forEach((item) {
        hotlists.add(Music(name: item['first']));
      });
    });
  }

  // 获取输入建议
  void _getSearchSuggest(String keywords) async {
    var result = await NeteaseRepository.getSearchSuggest(keywords);
    if (result == null) {
      setState(() {
        isSuggestLoading = false;
        suggestlists = [];
      });
    } else {
      setState(() {
        isSuggestLoading = false;
        suggestlists = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 32.0,
          child: TextField(
            onChanged: (value) {
              if (value == '') {
                _keyword = value;
                setState(() {
                  hasSearchInsert = false;
                });
              } else {
                _keyword = value;
                setState(() {
                  hasSearchInsert = true;
                  _getSearchSuggest(value);
                });
              }
            },
            controller: _textEditingController,
            autofocus: true,
            style: TextStyle(fontSize: 14.0, color: Colors.white),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2.0),
              suffixIcon: _textEditingController.text == ''
                  ? null
                  : Opacity(
                      opacity: 0.8,
                      child: IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.black26,
                          size: 16.0,
                        ),
                        onPressed: () {
                          setState(() {
                            _textEditingController.clear();
                            hasSearchInsert = false;
                          });
                        },
                      )),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white24,
                size: 22.0,
              ),
              hintText: 'Seach...',
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(40.0))),
              fillColor: Colors.white12,
              hintStyle: TextStyle(color: Colors.white30),
            ),
          ),
        ),
      ),
      body: hasSearchInsert == true
          ? Container(
              decoration: BoxDecoration(color: Colors.white),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      child: InkWell(
                        onTap: () async {
                          // 跳转搜索页面
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var searchHisLists =
                              prefs.getStringList('search_history');
                          if (searchHisLists == null) {
                            searchHisLists = [_textEditingController.text];
                          } else if (!searchHisLists
                              .contains(_textEditingController.text)) {
                            searchHisLists.add(_textEditingController.text);
                          }

                          SharedPreferences.getInstance().then((preference) {
                            preference.setStringList(
                                'search_history', searchHisLists);

                            // String url =
                            //     '/home/searchresultpage?keyword=${_textEditingController.text}';
                            // url = Uri.encodeFull(url);
                            // Routes.router.navigateTo(context, url);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return SearchResult(
                                  keyword: _keyword,
                                  pageContext: widget.pageContext);
                            }));
                            setState(() {
                              hasSearchInsert = false;
                              searchhistorylists.clear();
                              searchHisLists
                                  .asMap()
                                  .forEach((int index, String item) {
                                searchhistorylists.add(Music(name: item));
                              });
                              _textEditingController.clear();
                            });
                          });
                        },
                        child: DefaultTextStyle(
                          style: TextStyle(color: Color(0xff0c73c2)),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xFFE0E0E0)))),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text('搜索'),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text('“${_textEditingController.text}”')
                                      ],
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: isSuggestLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor)))
                        : Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: suggestlists.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SearchSuggestMusic(
                                    suggestlists[index]['keyword'],
                                    searchCb: () {
                                  setState(() {
                                    searchhistorylists.clear();
                                    SharedPreferences.getInstance()
                                        .then((prefs) {
                                      prefs
                                          .getStringList('search_history')
                                          .asMap()
                                          .forEach((int index, String item) {
                                        searchhistorylists
                                            .add(Music(name: item));
                                      });
                                    });

                                    hasSearchInsert = false;
                                    _textEditingController.clear();
                                  });
                                }, pageContext: widget.pageContext);
                              },
                            ),
                          ),
                  )
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(color: Colors.white),
              child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: searchhistorylists.length <= 0
                      ? [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 10.0,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SearchListTitle(
                              '热搜榜',
                            ),
                          ),
                          SearchHotList(
                            hotlists,
                            isLoading: hotSearchLoading,
                            callback: (lists) {
                              setState(() {
                                lists.asMap().forEach((int index, String item) {
                                  searchhistorylists.add(Music(name: item));
                                });
                              });
                            },
                            pageContext: widget.pageContext,
                          ),
                        ]
                      : [
                          SliverToBoxAdapter(
                            child: SearchListTitle(
                              '搜索历史',
                              icon: {
                                'iconData': Icons.delete_forever,
                                'iconPressd': () {
                                  //清空搜索历史
                                  SharedPreferences.getInstance().then((prefs) {
                                    prefs.remove('search_history');
                                    setState(() {
                                      searchhistorylists.clear();
                                    });
                                  });
                                }
                              },
                            ),
                          ),
                          SearchHistoryList(
                            searchhistorylists,
                            ctx: context,
                            pageContext: widget.pageContext,
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 25.0,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SearchListTitle(
                              '热搜榜',
                            ),
                          ),
                          SearchHotList(
                            hotlists,
                            isLoading: hotSearchLoading,
                            callback: (list) {
                              setState(() {
                                list.asMap().forEach((int index, String item) {
                                  searchhistorylists.add(Music(name: item));
                                });
                              });
                            },
                            pageContext: widget.pageContext,
                          ),
                        ]),
            ),
    );
  }
}

class SearchSuggestMusic extends StatelessWidget {
  final String keyword;
  final VoidCallback searchCb;
  final BuildContext pageContext;
  SearchSuggestMusic(this.keyword, {this.searchCb, this.pageContext});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // 点击后加入搜索记录
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var searchHisLists = prefs.getStringList('search_history');
        if (searchHisLists == null) {
          searchHisLists = [keyword];
        } else if (!searchHisLists.contains(keyword)) {
          searchHisLists.add(keyword);
        }

        SharedPreferences.getInstance().then((preference) {
          preference.setStringList('search_history', searchHisLists);
          // 跳转搜索页面
          String url = '/home/searchresultpage?keyword=$keyword';
          url = Uri.encodeFull(url);
          // Routes.router.navigateTo(context, url);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return SearchResult(
                keyword: keyword, pageContext: this.pageContext);
          }));
          searchCb();
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.search,
                size: 20.0,
                color: Colors.grey.withOpacity(0.4),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 10.0),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFE0E0E0)))),
                child: Text(keyword),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 热搜榜列表
class SearchHotList extends StatelessWidget {
  final List<Music> songlist;
  final ValueChanged callback;
  final BuildContext pageContext;
  final bool isLoading;
  SearchHotList(this.songlist,
      {this.callback, this.pageContext, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor)),
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () async {
                    // 点击后加入搜索记录
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var searchHisLists = prefs.getStringList('search_history');
                    if (searchHisLists == null) {
                      searchHisLists = [songlist[index].name];
                    } else if (!searchHisLists.contains(songlist[index].name)) {
                      searchHisLists.add(songlist[index].name);
                    }

                    SharedPreferences.getInstance().then((preference) {
                      preference.setStringList(
                          'search_history', searchHisLists);
                      String url =
                          '/home/searchresultpage?keyword=${songlist[index].name}';
                      url = Uri.encodeFull(url);
                      // Routes.router.navigateTo(context, url);
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SearchResult(
                            keyword: '${songlist[index].name}',
                            pageContext: this.pageContext);
                      }));
                      if (callback != null) callback(searchHisLists);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 15.0),
                          margin: EdgeInsets.only(right: 20.0),
                          child: Container(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                  color: (index < 3)
                                      ? Theme.of(context).primaryColor
                                      : Theme.of(context)
                                          .textTheme
                                          .display4
                                          .color,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Text(
                            songlist[index].name,
                            style: TextStyle(
                                color: Theme.of(context).textTheme.body1.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: songlist.length,
            ),
          );
  }
}

// 列表顶部标题
class SearchListTitle extends StatelessWidget {
  final String title;
  final Map<String, dynamic> icon;
  SearchListTitle(this.title, {this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: icon != null
            ? <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
                ),
                IconButton(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                  icon: Icon(
                    icon['iconData'],
                    color: Color(0xFFE0E0E0),
                  ),
                  onPressed: icon['iconPressd'],
                )
              ]
            : <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0),
                ),
              ],
      ),
    );
  }
}

// 搜索历史列表
class SearchHistoryList extends StatelessWidget {
  final List<Music> songlist;
  final BuildContext ctx;
  final BuildContext pageContext;
  SearchHistoryList(this.songlist, {this.ctx, this.pageContext});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 30.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: songlist.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
                child: InkResponse(
              onTap: () {
                // Routes.router.navigateTo(
                //     ctx,
                //     Uri.encodeFull(
                //         '/home/searchresultpage?keyword=${songlist[index].name}'));

                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return SearchResult(
                      keyword: '${songlist[index].name}',
                      pageContext: this.pageContext);
                }));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Text(
                  songlist[index].name,
                  style: TextStyle(fontSize: 12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
              ),
            ));
          },
        ),
      ),
    );
  }
}
