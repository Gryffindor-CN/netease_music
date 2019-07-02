import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circle_bottom_bar.dart';
import 'dart:ui';

class NeteaseBottomNavBar extends StatefulWidget {
  final Widget child;
  final List<Map<String, dynamic>> barsList;
  final int currentIndex;
  final ValueChanged<int> onTap;

  NeteaseBottomNavBar(
    this.barsList, {
    this.onTap,
    @required this.currentIndex,
    @required this.child,
  });

  @override
  NeteaseBottomNavBarState createState() => NeteaseBottomNavBarState();
}

class NeteaseBottomNavBarState extends State<NeteaseBottomNavBar> {
  Widget renderCircleTab(IconData iconData) {
    return LogoApp(iconData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: widget.child,
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.3,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 52.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 8.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:
                        List.generate(widget.barsList.length, (int index) {
                      return InkWell(
                        onTap: () {
                          if (widget.onTap != null) widget.onTap(index);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            widget.currentIndex == index
                                ? renderCircleTab(
                                    widget.barsList[index]['iconData'],
                                  )
                                : Icon(widget.barsList[index]['iconData']),
                            Text(
                              widget.barsList[index]['title'],
                              style: widget.currentIndex == index
                                  ? TextStyle(
                                      fontSize: 10.0,
                                      color: Theme.of(context).primaryColor)
                                  : TextStyle(
                                      fontSize: 10.0,
                                    ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        )
        // Positioned(
        //   left: 0,
        //   right: 0,
        //   bottom: 0,
        //   child: ,
        // )
      ],
    );
  }
}
