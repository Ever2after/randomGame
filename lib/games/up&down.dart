import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class UpDown extends StatefulWidget {
  @override
  _UpDownState createState() => _UpDownState();
}

class _UpDownState extends State<UpDown> {
  final _myController = TextEditingController();
  int _maxNum = 100;
  int _targetNum = 1;
  bool _gameStarted = false;
  bool _hasInserted = false;
  bool _up = false;
  bool _hasCorrect = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _gameStarted ? _inGame() : _beforeGame(),
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

  Widget _beforeGame() {
    return Container(
      color : Color.fromRGBO(235, 215, 138, 0.7),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              '랜덤 숫자 범위 정하기!',
              style: TextStyle(
                fontSize: 28,
                fontWeight : FontWeight.bold,
                color : Colors.black,
                  fontFamily: 'Recipekorea'
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 200, 0, 100),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '1 ~',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              Container(
                width: 100,
                padding: EdgeInsets.all(10),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    border: OutlineInputBorder(),
                    hintText: '999',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  controller: _myController,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
            child: Text(
              '게임시작!',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                  fontFamily: 'Recipekorea'
              ),
            ),
            color: Color.fromRGBO(104, 178, 228,1),
            onPressed: () {
              this.setState(() {
                this._maxNum = int.parse(_myController.text);
                if (_maxNum > 1000 || _maxNum < 2) {
                  if (_maxNum > 1000)
                    _showDialog('999 이하의 숫자를 입력해주세요');
                  else
                    _showDialog('2 이상의 숫자를 입력해주세요');
                  return;
                }
                this._targetNum = Random().nextInt(_maxNum);
                _myController.clear();
                this._gameStarted = true;
              });
            },
          )
        ],
      ),
    );
  }

  Widget _inGame() {
    return Container(
      color : Color.fromRGBO(235, 215, 138, 0.7),
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 100),
              child: Text(
                !_hasInserted
                    ? '숫자를 입력해주세요!'
                    : (_hasCorrect ? 'CLAER!' : (_up ? 'UP!' : 'DOWN!')),
                style: TextStyle(
                  fontSize: !_hasInserted ? 30 : 40,
                  color: !_hasInserted
                      ? Colors.black
                      : _hasCorrect
                          ? Color.fromRGBO(77, 158, 79,1)
                          : _up ? Color.fromRGBO(104, 178, 228,1) : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                    fontFamily: 'Recipekorea'
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 50),
              width: 150,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  border: OutlineInputBorder(),
                  hintText: '1 ~ $_maxNum',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                controller: _myController,
              ),
            ),
            RaisedButton(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                color: _hasCorrect ? Color.fromRGBO(77, 158, 79,1) : Colors.redAccent,
                child: Text(
                  _hasCorrect ? '다시 시작' : '입력!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                      fontFamily: 'Recipekorea'
                  ),
                ),
                onPressed: () {
                  this.setState((){
                    if (_hasCorrect) {
                      _hasCorrect = false;
                      _gameStarted = false;
                      _myController.clear();
                      _hasInserted = false;
                    } else {
                      _hasInserted = true;
                      if (int.parse(_myController.text) > _targetNum)
                        _up = false;
                      else if (int.parse(_myController.text) < _targetNum)
                        _up = true;
                      else
                        _hasCorrect = true;
                    }
                  });
                })
          ])),
    );
  }

  void _showDialog(_text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("경고!"),
          content: new Text(_text),
          actions: <Widget>[
            new FlatButton(
              child: new Text("닫기"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
