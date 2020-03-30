import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CustomExpansionTitle extends StatefulWidget {
  bool initiallyExpanded;
  final String title;
  final TextStyle style;
  final TextOverflow overflow;
  final int minLines;
  final Widget icon;
  final Function(bool flag) onExpansionChanged;

  CustomExpansionTitle({
    Key key, 
    this.title,
    this.minLines = 1,
    this.style,
    this.overflow,
    this.icon,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
  });
  @override
  _CustomExpansionTitleState createState() => _CustomExpansionTitleState();
}

class _CustomExpansionTitleState extends State<CustomExpansionTitle> with TickerProviderStateMixin {

  AnimationController controller;
  bool isOpen;

  @override
  void initState() {
    super.initState();
    this.isOpen = widget.initiallyExpanded;
    controller = AnimationController(
        duration: Duration(milliseconds: 200), vsync: this);
    controller.addListener((){

    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          this.isOpen = !this.isOpen;
          if (this.isOpen) {
            controller.forward();
          }else{
            controller.reverse();
          }
          controller.addListener((){
            setState(() {
            });
          });
          controller.addStatusListener((status){
            if (status == AnimationStatus.completed) {
              if (widget.onExpansionChanged != null) {
                widget.onExpansionChanged(this.isOpen);
              }
            }
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                widget.title??"",
                maxLines:this.isOpen?kMaxValue:widget.minLines,
                style: widget.style,
                overflow: widget.overflow,
              ),
            ),
            RotationTransition(
              turns: Tween<double>(
                begin: 0, 
                end: 0.5,
              ).animate(
                controller,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: widget.icon??Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
      )
    );
  }
}