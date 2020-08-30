import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math.dart' hide Colors;

class BottleSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Main(),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with SingleTickerProviderStateMixin {
  bool isDragging = false;
  double startDXPoint = 0;
  double startDYPoint = 0;
  double angle = 0;
  Vector2 vel = Vector2.all(0);
  int _duration = 5;
  String imgsrc = 'images/alcohol_bottle.png';
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: _duration),
    );
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Vector2 position =
        Vector2(startDXPoint - width / 2, height / 2 - startDYPoint);
    angle = position.x > 0
        ? atan(position.y / position.x)
        : pi + atan(position.y / position.x);
    Vector2 tanVel =
        vel - position * dot2(vel, position) / dot2(position, position);
    bool direction = cross2(position, tanVel) > 0;
    double w0 = (direction ? 1 : -1) *
        sqrt(dot2(tanVel, tanVel)) /
        sqrt(dot2(position, position));
    double alpha = -w0 / _duration;

    if (_controller.value == 1) _controller.stop();
    return Container(
      color: Color.fromRGBO(235, 215, 138, 0.7),
      child: GestureDetector(
        onHorizontalDragStart: _onDragStartHandler,
        onVerticalDragStart: _onDragStartHandler,
        behavior: HitTestBehavior.translucent,
        onHorizontalDragUpdate: _onDragUpdateHandler,
        onVerticalDragUpdate: _onDragUpdateHandler,
        onHorizontalDragEnd: _onDragEnd,
        onVerticalDragEnd: _onDragEnd,
        child: Center(
          child: Stack(children: <Widget>[
            Container(
              height: height,
              width: width,
            ),
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _controller,
                child: Container(
                  child: Image.asset(imgsrc),
                ),
                builder: (BuildContext context, Widget _widget) {
                  return new Transform.rotate(
                    angle: isDragging
                        ? -angle
                        : -angle +
                            alpha *
                                _duration *
                                _duration *
                                _controller.value *
                                (1 - 0.5 * _controller.value),
                    child: _widget,
                  );
                },
              ),
            ),
            Positioned(
              width: width,
              top: height * 0.04,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _bottleSelector('images/alcohol_bottle.png'),
                  _bottleSelector('images/alcohol_bottle2.png'),
                  _bottleSelector('images/alcohol_bottle3.png'),
                  _bottleSelector('images/alcohol_bottle4.png'),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  void _onDragStartHandler(DragStartDetails details) {
    _controller.stop();
    setState(() {
      this.isDragging = true;
      this.startDXPoint =
          double.parse(details.globalPosition.dx.toStringAsFixed(3));
      this.startDYPoint =
          double.parse(details.globalPosition.dy.toStringAsFixed(3));
    });
  }

  void _onDragUpdateHandler(DragUpdateDetails details) {
    setState(() {
      this.startDXPoint =
          double.parse(details.globalPosition.dx.toStringAsFixed(3));
      this.startDYPoint =
          double.parse(details.globalPosition.dy.toStringAsFixed(3));
    });
  }

  void _onDragEnd(DragEndDetails details) {
    double vel_x = details.velocity.pixelsPerSecond.dx.floorToDouble();
    double vel_y = -details.velocity.pixelsPerSecond.dy.floorToDouble();
    _controller.value = 0;
    _controller.forward();
    setState(() {
      this.isDragging = false;
      this.vel = Vector2(vel_x, vel_y);
    });
  }

  Widget _bottleSelector(String _imgsrc) {
    return RaisedButton(
      padding: EdgeInsets.all(0),
      child: Container(
        width: 90,
        height: 60,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_imgsrc),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onPressed: () {
        this.setState(() {
          this.imgsrc = _imgsrc;
        });
      },
    );
  }
}
