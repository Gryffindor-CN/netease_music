import 'package:flutter/material.dart';
import './selection_parent.dart';

class CircleCheckbox extends StatefulWidget {
  final isSelected;
  final VoidCallback handleTap;
  CircleCheckbox({Key key, this.isSelected = false, this.handleTap})
      : super(key: key);

  @override
  CircleCheckboxState createState() => CircleCheckboxState();
}

class CircleCheckboxState extends State<CircleCheckbox> {
  @override
  Widget build(BuildContext context) {
    var _isAllSelected = SelectionShareDataWidget.of(context).isSelectAll;
    return GestureDetector(
      onTap: () {
        widget.handleTap();
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
            color:
                _isAllSelected ? Theme.of(context).primaryColor : Colors.white,
            shape: BoxShape.circle,
            border: _isAllSelected
                ? Border.all(color: Theme.of(context).primaryColor)
                : Border.all(color: Colors.grey)),
      ),
    );
  }
}
