import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3),
    );
    _controller.repeat();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,//Color.fromRGBO(235, 215, 138, 1),
      body: Center(
          child: Column(
            children: <Widget>[
              Stack(
                  children: <Widget>[
                       AnimatedBuilder(
                          animation: _controller,
                          builder: (BuildContext context, Widget _widget) {
                            if(_controller.value>0.9) Navigator.pushNamed(context, '/home');
                            return Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top : height*0.35-_controller.value*200),
                              child: WaveWidget(
                                  duration: 1,
                                  config: CustomConfig(
                                    gradients: [
                                      [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                                      [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                                      [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                                      [Color.fromRGBO(104, 178, 228,1), Color.fromRGBO(104, 178, 228,1)],
                                    ],
                                    durations: [10000, 12000, 15000, 20000],
                                    heightPercentages: [0.20, 0.23, 0.25, 0.30],
                                    blur: MaskFilter.blur(BlurStyle.inner, 5),
                                    gradientBegin: Alignment.centerLeft,
                                    gradientEnd: Alignment.centerRight,
                                  ),
                                  waveAmplitude: 1.0,
                                  backgroundColor: Colors.transparent,
                                  size: Size(height*0.21, _controller.value*200)),
                            );
                          },
                        ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.1),
                      height: height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('images/emptylogo.png'))),
                    ),
                  ]
              ),
            ],
          )),
    );
  }
}