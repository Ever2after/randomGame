import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_game/main.dart';
import 'package:noise_meter/noise_meter.dart';
import 'dart:async';
import 'dart:math';

class Game1 extends StatefulWidget {
  @override
  _Game1State createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  bool _isRecording = false;
  StreamSubscription<NoiseReading> _noiseSubscription;
  NoiseMeter _noiseMeter = new NoiseMeter();
  double _decibel = 0;
  double _maxDecibel = 0;
  bool _isPassed = false;
  bool _gameStarted = false;
  @override
  void initState() {
    super.initState();
    _decibel = 0;
    _maxDecibel = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getContent())),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder : (context)=>HomePage()));
          },
        ),
      ),
    );
  }

  List<Widget> getContent() => <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(25, 100, 25, 100),
            child: Column(children: [
              Container(
                child: Text(
                  !_gameStarted
                      ? '클레오파트라 게임을 \n시작해보세요!'
                      : _isRecording
                            ? '측정 중...'
                            : (_isPassed ? '통과! 자 다음 사람~!' : '실패! 일단 마시고 말해~!'),
                  style: TextStyle(
                    fontSize : 24,
                    color: !_gameStarted ? Colors.blueAccent
                     : (_isPassed ? Colors.green : Colors.deepOrangeAccent),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Text(
                    _isRecording
                        ? "Current Decibel : $_decibel dB\nMax Decibel: $_maxDecibel dB"
                        : "최고기록 : $_maxDecibel dB",
                    style: TextStyle(fontSize: 25, color: Colors.blue),
                    textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20),
                height: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                color: Colors.blueAccent,
                width: this._decibel * 2,
                height: 30,
              ),
              SizedBox(
                height: 100,
              ),
              RaisedButton(
                  color: _isRecording ? Colors.redAccent : Colors.greenAccent,
                  padding: EdgeInsets.only(top : 10, bottom : 10),
                  child: Container(
                    width: 200,
                    child: Text(
                      _isRecording ? '측정 종료' : '측정 시작!',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: _isRecording ? stop : start),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                  color: Colors.blueAccent,
                  padding: EdgeInsets.only(top : 10, bottom : 10),
                  child: Container(
                    width: 200,
                    child: Text(
                      '게임 초기화',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                onPressed: (){
                    stop();
                    this.setState(() {
                      _decibel = 0;
                      _maxDecibel = 0;
                      _isPassed = false;
                      _gameStarted = false;
                    });
                },
              ),
            ])),
      ];

  void onData(NoiseReading noiseReading) {
    this.setState(() {
      if (!this._isRecording) {
        this._isRecording = true;
      }
      this._decibel = double.parse(noiseReading.maxDecibel.toStringAsFixed(2));
      if (this._maxDecibel < this._decibel) {
        this._maxDecibel = double.parse(this._decibel.toStringAsFixed(2));
        this._isPassed = true;
      }
    });
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
      this._isPassed = false;
      this._gameStarted = true;
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription.cancel();
        _noiseSubscription = null;
      }
      this.setState(() {
        this._isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }
}
