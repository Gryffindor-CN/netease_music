import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './item.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
      // enablePullUp: true,
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
      // child: CustomScrollView(
      //   controller: _scrollController,
      //   slivers: <Widget>[
      //     // SliverToBoxAdapter(
      //     //   child: Container(
      //     //     decoration: BoxDecoration(color: Colors.green),
      //     //     height: 200.0,
      //     //     child: Swiper(
      //     //       itemBuilder: (BuildContext context, int index) {
      //     //         return Container(
      //     //           padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      //     //           child: ClipRRect(
      //     //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //     //             child: Container(
      //     //                 child: Image.network(
      //     //               banners[index]['imageUrl'],
      //     //               fit: BoxFit.fill,
      //     //             )),
      //     //           ),
      //     //         );
      //     //       },
      //     //       itemCount: banners.length,
      //     //       autoplay: true,
      //     //       pagination: SwiperPagination(),
      //     //     ),
      //     //   ),
      //     // ),
      //     // ListView.builder(
      //     //   itemCount: 1,
      //     //   itemBuilder: (BuildContext context, int index) {
      //     //     return Padding(
      //     //       padding: EdgeInsets.all(10.0),
      //     //       child: Text('wowowow'),
      //     //     );
      //     //   },
      //     // ),

      //     SliverGrid(
      //       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //         maxCrossAxisExtent: 500.0,
      //         mainAxisSpacing: 0.0,
      //         childAspectRatio: 4.0,
      //       ),
      //       delegate: SliverChildBuilderDelegate(
      //         (BuildContext context, int index) {
      //           if (index == 0) {
      //             return Container(
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   border: Border(
      //                       bottom: BorderSide(color: Colors.transparent))),
      //               child: Align(
      //                 alignment: Alignment.center,
      //                 child: Stack(
      //                   children: <Widget>[
      //                     Container(
      //                       decoration: BoxDecoration(
      //                           color: Theme.of(context).primaryColor,
      //                           border: Border(
      //                               top: BorderSide(
      //                                   color: Theme.of(context).primaryColor,
      //                                   width: 2.0))),
      //                       width: MediaQuery.of(context).size.width,
      //                       height: 40.0,
      //                     ),
      //                     Container(
      //                       padding: EdgeInsets.only(bottom: 60.0),
      //                       width: MediaQuery.of(context).size.width,
      //                       height: 200.0,
      //                       child: Swiper(
      //                         itemBuilder: (BuildContext context, int index) {
      //                           return Container(
      //                             padding:
      //                                 EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      //                             child: ClipRRect(
      //                               borderRadius:
      //                                   BorderRadius.all(Radius.circular(10.0)),
      //                               child: Container(
      //                                   child: Image.network(
      //                                 banners[index]['imageUrl'],
      //                                 fit: BoxFit.fill,
      //                               )),
      //                             ),
      //                           );
      //                         },
      //                         itemCount: banners.length,
      //                         autoplay: true,
      //                         pagination: SwiperPagination(),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             );
      //           } else {
      //             return Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //               ),
      //               alignment: Alignment.center,
      //               child: Text('grid item $index'),
      //             );
      //           }
      //         },
      //         childCount: 20,
      //       ),
      //     ),
      //   ],
      // ),
      child: ListView.builder(
        itemCount: 19,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
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
                                  width: 2.0))),
                      width: MediaQuery.of(context).size.width,
                      height: 40.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 60.0),
                      width: MediaQuery.of(context).size.width,
                      height: 200.0,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
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
                    )
                  ],
                ),
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('wowowow'),
            );
          }
        },
      ),
    );
  }
}
