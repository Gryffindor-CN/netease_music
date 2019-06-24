import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'circle_bottom_bar.dart';

class NeteaseBottomNavBar extends StatefulWidget {
  final List<Map<String, dynamic>> barsList;
  final int activeIndex;
  final ValueChanged<int> onTap;

  NeteaseBottomNavBar(this.barsList, this.activeIndex, {this.onTap});

  @override
  NeteaseBottomNavBarState createState() => NeteaseBottomNavBarState();
}

class NeteaseBottomNavBarState extends State<NeteaseBottomNavBar> {
  Widget renderCircleTab(IconData iconData) {
    return LogoApp(iconData);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(widget.barsList.length, (int index) {
        return InkWell(
          onTap: () {
            if (widget.onTap != null) widget.onTap(index);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              widget.activeIndex == index
                  ? renderCircleTab(
                      widget.barsList[index]['iconData'],
                    )
                  : Icon(widget.barsList[index]['iconData']),
              Text(
                widget.barsList[index]['title'],
                style: widget.activeIndex == index
                    ? TextStyle(
                        fontSize: 14.0, color: Theme.of(context).primaryColor)
                    : TextStyle(
                        fontSize: 14.0,
                      ),
              )
            ],
          ),
        );
      }),
    );
  }
}
