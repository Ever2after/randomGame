// import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:audioplayers/audioplayers.dart';

class FryingPanScreen extends StatelessWidget {
  static const String id = 'frying_pan_game';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Main(),
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
  AnimationController _controller;
  double _rotateSpeed = 0;
  var _speedarr = [
    0.0,20.0,40.0,60.0,   // 후라이팬 회전 속도
  ];
  String _imgsrc = 'images/frying_pan0.png';
  var _imgarr = [
    'images/frying_pan0.png',
    'images/frying_pan1.png',
    'images/frying_pan2.png',
    'images/frying_pan3.png'
  ];
   @override
   void initState() {
     super.initState();
     _controller = new AnimationController(
       vsync: this,
       duration: new Duration(seconds: 1000),  //1000초 주기, 중간에 끊기면 안되므로
     );
     _controller.repeat();
   }

  void _speedSelector(int level) {
    setState(() {
      _imgsrc = _imgarr[level];
      _rotateSpeed = _speedarr[level];  // 속도 레벨도 같이 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          //alignment: ,
          child: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Container(
                  child: Text(
                    '박자는 \'생명\'',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                AnimatedBuilder(  // 회전하는 후라이팬
                  animation: _controller,
                  child: SizedBox(   //회전시킬 child를 여기에 둠
                    height: 200,
                    width: 200,
                    child: Image.asset(_imgsrc),
                  ),
                  builder: (BuildContext context, Widget _widget) {
                    return new Transform.rotate(
                      origin: Offset(0,-30),  //회전중심
                      angle: _controller.value*_rotateSpeed,  //회전각도, _controller.value는 시간에 비례해 증가하는 값
                      child: _widget,
                    );
                  },
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _speedSelector(1);
                        },
                        color: Color.fromARGB(255, 255, 228, 0),
                        padding: EdgeInsets.all(3),
                        shape: CircleBorder(),
                        child: const Text(
                          '느림',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _speedSelector(2);
                        },
                        color: Color.fromARGB(255, 255, 112, 18),
                        padding: EdgeInsets.all(3),
                        shape: CircleBorder(),
                        child: const Text(
                          '보통',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          _speedSelector(3);
                        },
                        color: Colors.redAccent,
                        padding: EdgeInsets.all(3),
                        shape: CircleBorder(),
                        child: const Text(
                          '빠름',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {},
                        shape: CircleBorder(),
                        child: Container(
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 228, 0),
                                Color.fromARGB(255, 255, 94, 0),
                                Color.fromARGB(255, 255, 0, 0)
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(80.0)),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 88.0,
                                minHeight:
                                    36.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: const Text(
                              '점점 빠름',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        _imgsrc = _imgarr[0];
                        _rotateSpeed = _speedarr[0];
                        //오디오를 중지하는 코드 넣어주기
                      });
                    },
                    color: Colors.black,
                    padding: EdgeInsets.all(3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    ),
                    child: const Text(
                      '중지',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
