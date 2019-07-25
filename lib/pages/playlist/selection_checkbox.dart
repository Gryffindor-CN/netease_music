import 'package:flutter/material.dart';

class SongCheckbox extends StatelessWidget {
  SongCheckbox({@required this.checked});
  final bool checked;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 20.0,
      height: 20.0,
      child: Icon(
        Icons.check,
        size: 16.0,
        color: checked ? Colors.white : Colors.transparent,
      ),
      decoration: BoxDecoration(
          color: checked ? Theme.of(context).primaryColor : Colors.white,
          shape: BoxShape.circle,
          border: checked
              ? Border.all(color: Theme.of(context).primaryColor)
              : Border.all(color: Colors.grey)),
    );
  }
}
