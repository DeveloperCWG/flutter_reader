import 'package:flutter/material.dart';

class ToolBarItem extends StatefulWidget {
  final Widget icon;
  final Widget activeIcon;
  final bool selected;
  final Function onTap;
  ToolBarItem({
    @required this.icon, 
    this.activeIcon, 
    this.selected = false,
    this.onTap,
  });
  @override
  _ToolBarItemState createState() => _ToolBarItemState();
}

class _ToolBarItemState extends State<ToolBarItem> {

  bool selected;
  @override
  void initState() {
    super.initState();
    this.selected = widget.selected??false;
  }

  @override
  Widget build(BuildContext context) {
    if (this.selected) {
      return IconButton(icon: widget.activeIcon??widget.icon, onPressed: (){
        setState(() {
          this.selected = !this.selected;
        });
        if (widget.onTap != null) widget.onTap();
      });
    } else {
      return IconButton(icon: widget.icon, onPressed: (){
        if (widget.onTap != null) widget.onTap();
        setState(() {
          this.selected = !this.selected;
        });
      });
    }
  }
}

