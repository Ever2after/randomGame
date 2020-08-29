import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'dart:math';
import 'dart:async';
import 'dart:io';

class JuruMarbleRoullete extends StatefulWidget {
  final int curPlayer;
  final double width, height;
  JuruMarbleRoullete ({ Key key, @required this.curPlayer, @required this.width, @required this.height}): super(key: key);
  @override
  _JuruMarbleRoulleteState createState() => _JuruMarbleRoulleteState();
}

class _JuruMarbleRoulleteState extends State<JuruMarbleRoullete> {
  final StreamController _dividerController = StreamController<int>();
  bool _isEnd = true; //야매로... 이거 수정할수 있을까
  @override
  Widget build(BuildContext context) {
    double height = widget.height;
    return Stack(
      children: <Widget> [ Opacity(
        opacity: 0.5,
        child: Container(
          color: Colors.purple,
        )),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Text((widget.curPlayer + 1).toString() + '번 룰렛 돌리기', style: TextStyle(fontSize: 20, color: Colors.black),),
            SpinningWheel(
                        Image.asset('images/simple_roullete.png'),
                        width: height * 0.7,
                        height: height * 0.7,
                        initialSpinAngle: _generateRandomAngle(),
                        spinResistance: 0.5,
                        canInteractWhileSpinning: false,
                        dividers: 8,
                        onUpdate: _dividerController.add,
                        onEnd: (int k) {
                          _isEnd = !_isEnd;
                          _dividerController.add(k);
                          if (!_isEnd) return;
                          sleep(Duration(milliseconds: 1500)); //끝났을때 좀 기다리기
                          Navigator.pop(context, k);
                        },
                        secondaryImage: Image.asset('images/red_arrow.png'),
                        secondaryImageHeight: height * 0.1,
                        secondaryImageWidth: height * 0.1,
                      ),
                      Container(),
          ]),
      ]);
  }

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;

}
