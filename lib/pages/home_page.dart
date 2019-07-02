import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../components/netease_toast.dart';
import '../router/Routes.dart';

class RefreshIndicators extends StatefulWidget {
  RefreshIndicators({this.showToastCb});

  final VoidCallback showToastCb;

  @override
  _RefreshIndicatorState createState() => _RefreshIndicatorState();
}

class _RefreshIndicatorState extends State<RefreshIndicators> {
  RefreshController _refreshController;
  ScrollController _scrollController;
  List<Widget> items = [];
  List banners = [];
  void _init() {
    for (int i = 0; i < 5; i++) {
      items.add(Item(
        title: "Data$i",
      ));
    }
    _getBanner();
  }

  void _getBanner() async {
    var url = 'http://192.168.206.133:3000/banner';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      setState(() {
        banners = jsonResponse['banners'];
      });
    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _scrollController = ScrollController(initialScrollOffset: 50.0);
    _init();
  }

  void _onRefresh() {
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      items.add(Item(title: "Data"));
      if (mounted) setState(() {});
      _refreshController.refreshCompleted();
    });

    Future.delayed(Duration(milliseconds: 2000)).then((_) {
      widget.showToastCb();
    });
  }

  void _onLoading() {
    /// se _refreshController.loadComplete() or loadNoData() to end loading
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      int index = items.length;
      if (mounted) setState(() {});
      items.add(Item(
        title: "Data$index",
      ));
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(color: Theme.of(context).primaryColor)),
        refreshStyle: RefreshStyle.Follow,
        completeText: '',
        releaseText: '',
        refreshingText: '',
        idleText: '',
        idleIcon: Icon(
          Icons.ac_unit,
          color: Colors.white,
        ),
        releaseIcon: Icon(
          Icons.cached,
          color: Colors.white,
        ),
        completeIcon: const Icon(Icons.done, color: Colors.white),
        refreshingIcon: SizedBox(
          width: 25.0,
          height: 25.0,
          child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0x64ffff)),
          ),
        ),
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(bottom: BorderSide(color: Colors.transparent))),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border(
                                top: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: .0))),
                        width: MediaQuery.of(context).size.width,
                        height: 40.0,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.transparent),
                            width: MediaQuery.of(context).size.width,
                            height: 138.0,
                            child: banners.length <= 0
                                ? Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0x9bffffff)),
                                    ),
                                  )
                                : Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            12.0, 0.0, 12.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          child: Container(
                                              child: Image.network(
                                            banners[index]['imageUrl'],
                                            fit: BoxFit.fill,
                                          )),
                                        ),
                                      );
                                    },
                                    itemCount: banners.length,
                                    autoplay: true,
                                    pagination: SwiperPagination(),
                                  ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20.0),
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 0.0))),
                              width: MediaQuery.of(context).size.width,
                              height: 80.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 44.0,
                                        height: 44.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('abc')
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 44.0,
                                        height: 44.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('abc')
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 44.0,
                                        height: 44.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('abc')
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 44.0,
                                        height: 44.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('abc')
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 44.0,
                                        height: 44.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon(
                                          Icons.ac_unit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('abc')
                                    ],
                                  )
                                ],
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: List.generate(20, (int index) {
                  return Container(
                    padding: EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: Text('grid item $index'),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NeteaseHome extends StatefulWidget {
  @override
  NeteaseHomeState createState() => NeteaseHomeState();
}

class NeteaseHomeState extends State<NeteaseHome>
    with AutomaticKeepAliveClientMixin {
  bool isShow = false;
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        RoutePageBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (_, __, ___) => NeteaseHomeContainer(
                  pageContext: context,
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return PageRouteBuilder(
          pageBuilder: builder,
        );
      },
    );
  }
}

class NeteaseHomeContainer extends StatefulWidget {
  final BuildContext pageContext;
  NeteaseHomeContainer({Key key, this.pageContext}) : super(key: key);

  @override
  NeteaseHomeContainerState createState() => NeteaseHomeContainerState();
}

class NeteaseHomeContainerState extends State<NeteaseHomeContainer> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        leading: Icon(Icons.mic),
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Routes.router.navigateTo(context, '/home/searchpage');
          },
          splashColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: 250.0,
            height: 36.0,
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.white24,
                  size: 22.0,
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sort),
          )
        ],
      ),
      body: NeteaseToast(
        toastText: '已为你推荐新的个性化内容!!!',
        showToast: isShow,
        child: RefreshIndicators(showToastCb: () {
          setState(() {
            isShow = true;
          });
        }),
      ),
    );
  }
}

class Item extends StatefulWidget {
  final String title;

  Item({this.title});
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: Center(
        child: Text(widget.title),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
