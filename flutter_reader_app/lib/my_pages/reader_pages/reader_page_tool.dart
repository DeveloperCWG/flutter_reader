import 'package:flutter/material.dart';
import 'package:flutter_reader_app/public_widget/custom_toolbar.dart';
import 'package:flutter_reader_app/public_widget/custom_appbar.dart';
import 'package:provider/provider.dart';


class ReaderPageTool extends StatefulWidget {
  Widget titleBar;
  Widget bottomBar;
  Function closeCallback;

  ReaderPageTool({
    this.titleBar, 
    this.bottomBar, 
    this.closeCallback
  });
  @override
  _ReaderPageToolState createState() => _ReaderPageToolState();
}

class _ReaderPageToolState extends State<ReaderPageTool> with TickerProviderStateMixin {


  AnimationController _controller;
  bool _isOpen;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _controller.forward();
    _isOpen = true;
    
    setState(() {
    });
    _controller.addStatusListener((status){
      switch (status) {
        case AnimationStatus.forward:
          print("forward");
          break;
        case AnimationStatus.reverse:
          print("reverse");
          break;
        case AnimationStatus.dismissed:
          if (!_isOpen && widget.closeCallback != null) {
            widget.closeCallback();
          }
          break;
        case AnimationStatus.completed:
          print("completed");
          break;
        default:
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: (){
          _controller.reverse();
          _isOpen = false;
          setState(() {
          });
        },
        child: Stack(
          children: <Widget>[
            FadeTransition(
              opacity: Tween(
                begin: 0.0,
                end: 0.3,
              ).animate(
                _controller
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, -1.0),
                  end: Offset(0.0, 0.0),
                ).animate(CurvedAnimation(
                  parent: _controller, 
                  curve: Curves.easeInOut)
                ),
                child: widget.titleBar??CustomAppBar(

                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0.0, 1.0),
                  end: Offset(0.0, 0.0),
                ).animate(CurvedAnimation(
                  parent: _controller, 
                  curve: Curves.easeInOut)
                ),
                child: widget.bottomBar??CustomBottomBar(

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}